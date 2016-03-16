#!/bin/sh
applyTime=`date '+%Y%m%d-%H:%M:%S'`
buildFolder=/build/C6/last
mashkitFolder=/www/wbxconnect/acswidgets
postFolder=${mashkitFolder}/mashkit/build-profile
uploadWidget()
{
echo "start upload..."
cd $1
./postapp.pl 2&>1 << EOF


pass


EOF
echo "finished..."
cd -
}

mashkitBuildName=`ls -l $buildFolder/ | awk '{print $9}'|grep WBXcwclient`
if [ -d $mashkitFolder ]
then
echo "backup old mashkit..."
mv $mashkitFolder $mashkitFolder.$applyTime
fi
mkdir -p $mashkitFolder
tar xf $buildFolder/$mashkitBuildName -C $mashkitFolder
chmod -R 777 $mashkitFolder
chown -R nobody:nobody $mashkitFolder
uploadWidget $postFolder
