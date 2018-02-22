---
author: admin
comments: true
date: 2017-04-05 14:57:05+00:00
layout: post
link: http://chiwbaka.com/wordpress-low-memory-servers/
slug: wordpress-low-memory-servers
title: Wordpress on Low Memory Servers
wordpress_id: 93
---

This site runs on a 512MB DigitalOcean droplet.  Every week or two the Linux kernel would kill MySQL for using too much RAM... and restarting it got tiring.

[caption id="attachment_94" align="alignnone" width="525"][![](http://chiwbaka.com/wp-content/uploads/2017/04/after-1024x766.png)](http://chiwbaka.com/wp-content/uploads/2017/04/after.png) After the tweaks[/caption]

When I first start nginx, php-fpm and MySQL, the memory usage starts at 370MB and only goes upwards from there. htop (and journalctl) tells me that MySQL is the biggest offender, so let's start there.


## MySQL



After some googling one parameter always popped up in every guide: innodb_buffer_pool_size. [MySQL docs](https://dev.mysql.com/doc/refman/5.6/en/innodb-parameters.html#sysvar_innodb_buffer_pool_size) state that it's 128MB by default. So I reduced it to 8MB to see what would happen. After all, I doubt the entirety of my posts on this site+Wordpress settings could ever reach 8MB, and even if it did, it's backed by an SSD, so who cares.

It made a huge difference. MySQL went from using 18% of my RAM (~92MB) to just 8% (43MB).


## PHP


Some Googling led to [A better way to run PHP](https://ma.ttias.be/a-better-way-to-run-php-fpm/), which advocates using pm = ondemand instead of pm = dynamic.

Before, php-fpm had 3 child processes taking up 18% of my RAM. Now, it has none, and it just spins them up on demand which makes a lot of sense.

I don't use php-fpm pools so I ignored that part.



## 390MB memory on fresh start -> 140MB!!


The system now uses ~140MB of RAM and I'm pretty proud of myself - after just two tweaks! Nobody cares about this site right now but if traffic picks up I'll just enable nginx microcaching.
