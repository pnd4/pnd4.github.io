---
author: pnd4
comments: true
date: 2012-08-31 11:26:16
layout: post
slug: adventures-w-freebsd
title: Adventures w/ FreeBSD
wordpress_id: 138
categories:
- Computing
---

{% img center /images/2012-08-31-adventures-w-freebsd/image0.png %}

_Apparently the MSI K8N Neo4 Platinum (SLI) is tight-butthole about GPT partition schemes. To work around this to get FreeBSD installed, we have to use BSD-Labeling for our partition table.. I tried a good ol' MS-DOS MBR with nested freebsd file systems, but it didnt work either. BSD-labeling is our only option as far as I know.. Also, as usual, the method I will be using here is the simplest case, using the whole disk and as 2 partitions, root and swap._

Ok so in the FreeBSD installer, choose manual partitioning.

Now highlight the hard drive you want to install to and select "Create".

This will create the partition table, we chose "BSD labels". It should automatically choose to use your whole drive, so just select "Ok" and get back to the partitioning menu.

Now we highlight the drive again which should have "BSD" next to it instead of "none", and select "Create" again to make our root partition inside the BSD-labeling table.



	
  * type = freebsd-ufs

	
  * size =  total disk size - size of swap

	
  * mount point = /


Select "Ok" to confirm and get back to the partitioning menu.

Now scroll back up to highlight the drive with "BSD" next to it like we did in the previous step. We're creating another partition to use as swap, so select "Create" once more.

	
  * type = freebsd-swap

	
  * size = remaining space (this should be automatically filled in)

	
  * mount point = blank


Select "Ok" to confirm and get back to the partitioning menu.

Ok now we can select "Finish" and exit the installer's partitioner and install as usual.

_Good luck with the rest of your installation.. and know that your hate for old motherboards that don't support GPT partition tables is shared by those like me, with similar hardware._
