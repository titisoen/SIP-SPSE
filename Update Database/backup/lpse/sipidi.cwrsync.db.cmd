@ECHO OFF
SETLOCAL
SET CWRSYNCHOME=%PROGRAMFILES%\CWRSYNC
SET CWOLDPATH=%PATH%
SET PATH=%CWRSYNCHOME%\BIN;%PATH%
ECHO **********************************************************************
ECHO *                                                                    *
ECHO *         Ojo mbok close bro, iki sek lagi mbackup data ...          *
ECHO *                             Suwun!                                 *
ECHO *                                                                    *
ECHO **********************************************************************
rsync -av --delete-before --ignore-errors --force username-server@192.168.XXXX.XXXX:/home/backupdb (arahkan ke directory backup berada)/ /cygdrive/d/backup/lpse/backupdb/

pause