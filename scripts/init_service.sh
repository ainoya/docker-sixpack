#!/bin/sh

/etc/init.d/redis start
/etc/init.d/td-agent start

supervisord -c /etc/supervisord.conf
