#!/bin/sh
backTime=`date '+%Y%m%d%H%M%S'`
nfsIP=10.224.104.143
nfsFolder=/disk2/temp/build
logBaseFolder=/log
wapiIP=`hostname -i`
if [ `cat /etc/mtab | grep ${nfsIP}$nfsFolder |wc -l` -eq 0 ]
then
mount ${nfsIP}:$nfsFolder $logBaseFolder 
fi
mkdir -p $logBaseFolder/$wapiIP
tar cf $logBaseFolder/$wapiIP/$backTime.tar /usr/local/apache-tomcat/logs/*
/root/system/rb.sh
