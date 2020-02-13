#!/bin/bash

tgl=$(date "+%d-%m-%Y")

psql -U postgres -d epns_prod -f /home/lpse/del_schema_public_n_ekontrak.sql
gzip -d '/home/lpse/backupdb4sip-spse/epns_prod_'"$tgl"'.backup.gz'
pg_restore -vc --if-exists -U postgres -j 8 -d epns_prod '/home/lpse/backupdb4sip-spse/epns_prod_'"$tgl"'.backup'
psql -U postgres -d epns_prod -f /home/lpse/recreate-view-sip.sql