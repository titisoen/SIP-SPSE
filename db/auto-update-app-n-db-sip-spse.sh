#!/bin/bash
# 0 1 * * * /root/auto-update-app-n-db-sip-spse.sh

pg_restore -vc --if-exists -U postgres -j 8 -d epns_prod '/home/andi/epns_prod.backup'
psql -U postgres -d epns_prod -f /root/recreate-view-sip.sql
cd /var/www/html/sip-spse/
git pull