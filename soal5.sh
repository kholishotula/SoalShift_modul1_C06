#!/bin/bash
awk 'NF<13 && tolower($0) ~ /cron/ && tolower($0) !~ /sudo/' /var/log/syslog > /home/nandha/modul1/user.log