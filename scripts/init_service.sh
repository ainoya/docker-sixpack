#!/bin/sh

service sshd start

service redis start

supervisord -c /etc/supervisord.conf
