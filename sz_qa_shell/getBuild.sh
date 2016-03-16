#!/bin/sh
ftpIP=10.224.114.246
ftpUser=webex_us
ftpPass=awk159
ftpFolder=/home/webex_us/client/us
newBuildList=/spare/conf/new.lst
ftpTempFile=/spare/conf/tmp
applyTime=`date '+%Y%m%d-%H:%M:%S'`
buildFolder=/build/C6/$applyTime
getBuildFiles()
{
ftp -niv $ftpIP > $ftpTempFile <<EOF
user $ftpUser $ftpPass
cd $ftpFolder
bin
get $1
by
EOF
}
echo "Begin to download required files..."
mkdir -p $buildFolder
rm -rf $buildFolder/../last
ln -s $buildFolder $buildFolder/../last
cd $buildFolder
for v in `cat $newBuildList`
do
getBuildFiles $v
done
echo "The following files have been downloaded:"
ls -l $buildFolder | awk '{print $9}'
echo ""
