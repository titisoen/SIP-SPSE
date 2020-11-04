#!/bin/bash
# 0 1 * * * /bin/sh /var/www/html/sip-spse/db/update.sh

cd /var/www/html/sip-spse/
git pull

#tgl=$(date "+%d-%m-%Y")

psql -U postgres -d epns_prod -f '/var/www/html/sip-spse/db/reset.sql'
#gzip -d '/home/backupdb/epns_prod_'"$tgl"'.backup.gz'
gzip -d '/home/backupdb/epns_prod.backup.gz'
#pg_restore -vc --if-exists -U postgres -j 8 -d epns_prod '/home/backupdb/epns_prod_'"$tgl"'.backup'
pg_restore -vc --if-exists -U postgres -j 8 -d epns_prod '/home/backupdb/epns_prod.backup'
psql -U postgres -d epns_prod -f '/var/www/html/sip-spse/db/recreate.sql'