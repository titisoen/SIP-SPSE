@ECHO OFF
SETLOCAL
SET CWRSYNCHOME=%PROGRAMFILES%\cwRsync\bin
SET CWOLDPATH=%PATH%
SET PATH=%CWRSYNCHOME%;%PATH%

rsync -avp -e 'ssh -p 222' --exclude '.git' --exclude 'tmp' --chmod=u=rwx,go=rx --delete-before --ignore-errors --force /cygdrive/c/xampp/htdocs/sip_spse username-server@url-server:/var/www/html (arahkan ke directory website berada)/

pause