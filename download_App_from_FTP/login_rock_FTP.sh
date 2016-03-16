#!/bin/sh
ftpIP=192.168.1.101
ftpUser=rock
ftpPass=pass
ftpFolder=/home/webex_us/client/us
#newBuildList=/spare/conf/new.lst
#ftpTempFile=/spare/conf/tmp
#applyTime=`date '+%Y%m%d-%H:%M:%S'`
#buildFolder=/build/C6/$applyTime
loginFtp()
{
ftp -niv<<EOF
open ftpIP
user $ftpUser $ftpPass
get rock
get rock2
}