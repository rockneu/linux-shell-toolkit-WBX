#!/bin/sh
# Target 
#Plan to use this script to download WAPI, CAS, UserService, OOB Widget and other tricon app like NS, GS from WebEx FTP

# Method
# 1 determin to download which kind of App package from user input
# 2 determin to download which version of App from user input
# 3 initiate an array by assigning the array the package and doc names
# 4 download related files with the array elements

ftpIP=10.224.114.246
ftpUser=webex_us
ftpPass=awk159
ftpFolder=/home/webex_us/client/us
#newBuildList=/spare/conf/new.lst
#ftpTempFile=/spare/conf/tmp
#applyTime=`date '+%Y%m%d-%H:%M:%S'`
#buildFolder=/build/C6/$applyTime




#Get Wapi build version info from user input
read -p "Please input the version number of WAPI" ver
wapiBuild=WBXall_wapi_$ver.tar
wapiDoc=WBXall_wapi_$ver.doc
wapiShell=WBXall_wapi_$ver.sh

loginFtp()
{
ftp -niv<<EOF
open ftpIP
user $ftpUser $ftpPass
cd $ftpFolder
}




ftp -niv 192.168.1.101 > log <<EOF
user rock pass