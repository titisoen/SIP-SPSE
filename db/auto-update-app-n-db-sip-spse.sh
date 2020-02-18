#!/bin/bash
# 0 1 * * * /var/www/html/sip-spse/db/auto-update-app-n-db-sip-spse.sh

cd /var/www/html/sip-spse/
git pull

tgl=$(date "+%d-%m-%Y")

psql -U postgres -d epns_prod -f '/var/www/html/sip-spse/db/reset_schema_public_n_ekontrak.sql'
gzip -d '/home/backupdb/epns_prod_'"$tgl"'.backup.gz'
pg_restore -vc --if-exists -U postgres -j 8 -d epns_prod '/home/backupdb/epns_prod_'"$tgl"'.backup'
psql -U postgres -d epns_prod -f '/var/www/html/sip-spse/db/recreate-view-sip.sql'