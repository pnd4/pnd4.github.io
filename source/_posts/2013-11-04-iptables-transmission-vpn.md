---
layout: post
title: IPTables + Transmission + VPN
---
Transmission doesn't have a way to bind to specific interfaces without patching, and I like the simplicity of using a package manager like 'pacman' vs patching 'BindInterface' into Transmission and building it from source. The work-around, since Transmission can bind to an IP, is to run a script with cron periodically. 
The script should basically:

- first make sure the VPN is up and operational
- correct transmission's config if the address isn't current.. [stop, edit, start]
- definitely end with transmission running

### Quote
> Enforcing an application, for example a torrent client like Transmission, to always use the VPN interface or any particular network interface for that matter, is trivially simple using iptables on Debian, Ubuntu or any other GNU/Linux distro.
> Personally, I am running Debian Sid on the Raspberry Pi. Occasionally I use it for downloading files ( legal stuff, seriously, believe me :D  ) using Transmission Bittorrent client over a VPN connection. Sometimes it happens that the VPN connection fails and doesn't reconnect for whatever reason and Transmission continues pulling stuff directly over my internet connection, which I would like to avoid. Fortunately it is very straightforward to enforce rules based on application owner UID. Transmission runs under the owner debian-transmission in Debian (use htop to check this) and the following two lines of iptables ensures that any process with owner having UID, debian-transmission, will not use any other network interface apart from the OpenVPN tunnel interface tun0

    iptables -A OUTPUT -m owner --uid-owner debian-transmission -d 192.168.0.100 -j ACCEPT
    iptables -A OUTPUT -m owner --uid-owner debian-transmission \! -o tun0 -j REJECT

> The first line ensures that, my Mac-mini having IP address 192.168.0.100 on the lan, can always access the web interface of transmission. The second line makes sure, no outgoing traffic can leave via anything other that tun0. 
> Peace of mind restored, thanks to iptables.

### Code
transmission-vpn-only.sh

*Ver. ArchLinuxARM-110413*

{% highlight bash %}
#!/bin/sh

iface="tun0"
service="transmission.service"
config="/var/lib/transmission/.config/transmission-daemon/settings.json"

# test if service is currently running
systemctl --quiet is-active $service
if [ $? -eq 0 ]; then
    # get the ip from the current config
    savedIP=$(cat $config | egrep -o '\"bind-address-ipv4\": \"[^ ]*' | cut -d'"' -f4)
    # test if ip has changed and is no longer available
    ping -i1 -w2 -c1 $savedIP >/dev/null
    if [[ $? -ne 0 || "x$savedIP" == "x0.0.0.0" ]]; then
        echo IP unavailable, stop and reconfigure transmission..
        systemctl stop $service
        # test if VPN went down completely
        ifconfig $iface >/dev/null
        if [ $? -ne 0 ]; then
            echo Oops.. $iface not available, exiting without restarting transmission..
            exit 1
        fi
        # reconfigure transmission with new ip address
        sed -i "s/\"bind-address-ipv4\":.*\$/\"bind-address-ipv4\": \"$(ip a show dev $iface | egrep -o 'inet [^ ]* ' | cut -d' ' -f2 | sed 's/ //')\",/" $config
        systemctl start $service
        echo Transmission started.
    fi
else
    echo "Transmission isn't running.."
    exit 1
fi
{% endhighlight %}

### To-Do
- Figure out how to 'BindInterface', if possible.
- Revise transmission-vpn-only script.
- Figure out why openvpn config leaves routes behind.

#### Useful Links and References
1. [BotCyborg](http://www.botcyb.org/2012/11/force-application-to-use-vpn-using.html "BotCyborg")

