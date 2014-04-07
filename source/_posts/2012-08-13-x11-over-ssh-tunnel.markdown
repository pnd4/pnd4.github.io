---
author: pnd4
comments: true
date: 2012-08-13 16:05:07
layout: post
slug: x11-over-ssh-tunnel
title: X11 over SSH tunnel
wordpress_id: 89
categories:
- Computing
---

{% img center /images/2012-08-13-x11-over-ssh-tunnel/openssh2.gif %}


## Conventions
	
  * Server - aka headless. Where X apps will be run on.

	
  * Client - aka laptop. Where apps will be shown.


## Setting up the Server:

Start by running sshd and configuring /etc/ssh/sshd_config
	
  * Enable the **AllowTcpForwarding** option in `ssh**d**_config` on the **server**.

	
  * Enable the **X11Forwarding** option in `ssh**d**_config` on the **server**.

	
  * Set the **X11DisplayOffset** option in `ssh**d**_config` on the **server** to 10.

	
  * Enable the **X11UseLocalhost** option in `ssh**d**_config` on the **server**.

Restart the server

Check /etc/hosts and make sure it has been configured with correct hostnames and IPs.


## Setting up the Client

Configure /etc/ssh/ssh_config

  * Enable the **ForwardX11** option in `ssh_config` on the **client**.

  * Or.. just use "ssh -X" [or -Y for X11 Trusted Forwarding] when you ssh into the server (for security)


## Testing

SSH into the server with "ssh -X user@10.0.0.1" and then run an X application such as xeyes, xterm, xclock, et cetera.. and enjoy.
