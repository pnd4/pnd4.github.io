---
author: pnd4
comments: true
date: 2013-03-25 08:14:11
layout: post
slug: dd-wrt-firewall-fine-tuning
title: DD-WRT Firewall Fine Tuning
wordpress_id: 302
categories: Computing
---

To add additional firewall rules via the DD-WRT web interface when there's no checkbox, navigate to web interface's section at [Administration] -> [Commands]

You should see a text box, there you can add individual iptables rules as if you were using the command line. Just save the command with the appropriate button labeled [Save Firewall]

I found this particularly useful for allowing a machine with a static IP ping a machine that drops ping requests. Here is the rule I added as an example

{% codeblock %}
iptables -A INPUT -s <ip.allowed.pings> -p icmp -j ACCEPT
{% endcodeblock %}


