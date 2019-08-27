@ECHO OFF
SETLOCAL
SET CWRSYNCHOME=%PROGRAMFILES%\cwRsync\bin
SET CWOLDPATH=%PATH%
SET PATH=%CWRSYNCHOME%;%PATH%

rsync -avp -e 'ssh -p 222' --chmod=u=rwx,go=rx --delete-before --ignore-errors --force /cygdrive/d/backup/lpse/backupdb/database-yang-baru-diimport.backup username-server@url-server:/var/lib/.. arahkan ke library pgadmin untuk proses restore

pause