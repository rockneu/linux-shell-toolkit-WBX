#!/bin/sh
appList=/spare/conf/down.lst
ftpIP=10.224.114.246
ftpUser=webex_us
ftpPass=awk159
ftpFolder=/home/webex_us/client/us
ftpTempFile=/spare/conf/tmp.lst
newBuildList=/spare/conf/new.lst
getLatestBuildName()
{
ftp -niv $ftpIP > $ftpTempFile <<EOF
user $ftpUser $ftpPass
cd $ftpFolder
ls $1*
by
EOF
cat $ftpTempFile | grep $1 | awk '{ if ($5>0) print $9}' | sed '$!d' >> $newBuildList
rm -f $ftpTempFile
}
showBuildList()
{
echo ""
echo "The following are the builds list:"
echo "--------------------------------------------"
cat $newBuildList
echo "--------------------------------------------"
echo ""
}
rm -f $newBuildList
for v in `cat $appList | sed '/^#/d' | awk -F: '{print $2}'`
do
getLatestBuildName $v
done

showBuildList
