---
author: pnd4
comments: true
date: 2012-12-15 01:33:07
layout: post
slug: ssh-pubkeyauth
title: 'OpenSSH: Public Key Auth'
wordpress_id: 222
categories:
- Computing
---

{% img center /images/2012-12-15-ssh-pubkeyauth/screenshot-12152012-011033-am.png %}

_I finally set up OpenSSH's Public Key Authentication on my NAS to incrementally backup my data daily. Despite there being lots of resources, I had to reference a few to get this working. Its kind of confusing figuring out where the public and private keys go in most guides. They don't really say what keys need to be on what box and what doesn't. A lot are pretty confusing about their naming conventions for remote/local and server/client. Also most completely leave out the user's .ssh/config in which you can specify the identity file to try in SSH. Naturally, I compiled a few snippets from the ssh manual page, and an example I cooked up from tonight's mucking around.. enjoi._

**Public-Key Authentication**:



	
  * The server knows the public key, and only the user knows the private key.

	
  * The file ~/.ssh/authorized_keys lists the public keys that are permitted for logging in.

	
  * When the user logs in, the ssh program tells the server which key pair it would like to use for authentication.

	
  * The client proves that it has access to the private key and the server checks that the corresponding public key is authorized to accept the account.


Example:
This will set up ssh without password connecting as foo@desktop (their account on their machine at home) to root@server (root account on machine at work)

On the desktop: Generate a key-pair

{% codeblock %}
foo@desktop: ~/.ssh$ ssh-keygen -t rsa -f 'foo'
foo@desktop: ~/.ssh$ mkdir ~/.ssh/private-keys
foo@desktop: ~/.ssh$ mv ~/.ssh/foo ~/.ssh/private-keys
foo@desktop: ~/.ssh$ chmod -R go-rw ~/.ssh/private-keys
{% endcodeblock %}


On the desktop: Create or modify the user's .ssh/config file to use the new private key

{% codeblock %}
foo@desktop: ~/.ssh$ vi config
{% endcodeblock %}



{% codeblock %}
Host *
IdentityFile ~/.ssh/foo
{% endcodeblock %}


On the desktop: Copy the public key to server's authorized_keys file.

{% codeblock %}
foo@desktop: ~/.ssh$ cat ~/.ssh/foo.pub | ssh root@server 'umask 077; cat >>~/.ssh/authorized_keys'
{% endcodeblock %}


On the server: Modify the sshd_config file to allow for Public-Key Authentication

{% codeblock %}
root@server: ~/etc/ssh/# mv sshd_config sshd_config.orig ; sed < sshd_config.orig 's/^#Pubkey/Pubkey/' > sshd_config
{% endcodeblock %}



On the server: Restart the ssh-daemon on the server

{% codeblock %}
root@server: ~# systemctl restart sshd
{% endcodeblock %}


On the desktop: Test it out.

{% codeblock %}
foo@desktop: ~$ ssh root@server
{% endcodeblock %}

