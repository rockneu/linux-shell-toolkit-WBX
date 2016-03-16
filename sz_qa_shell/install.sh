#!/bin/sh
autoHome=/spare
applyTime=`date '+%Y%m%d%H%M%S'`
ftpIP=10.224.114.246
ftpUser=webex_us
ftpPass=awk159
ftpFolder=/home/webex_us/client/us
ftpTempFile=$autoHome/conf/tmp.lst
buildFolder=/build/C6/$applyTime
lastFolder=/build/C6/last
newBuildList=$autoHome/conf/new.lst
appList=$autoHome/conf/down.lst
requiredList=$autoHome/conf/tmp1
realList=$autoHome/conf/tmp2
webappsFolder=$CATALINA_HOME/webapps
warList=/spare/conf/war.lst
mashkitFolder=/www/wbxconnect/acswidgets
mashkitPostFolder=${mashkitFolder}/mashkit/build-profile
widgetFolder=$lastFolder/wig
widgetConfList=$autoHome/conf/widgetConf.lst

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

specifyBuildName()
{
echo "Please specify required build numbers..."
rm -f $newBuildList
for v in `cat $appList|sed '/^#/d'|awk -F: '{print $2}'`
do
echo -e "$v...\c"
read buildNumber
echo "$v$buildNumber.tar" >>$newBuildList
echo ""
done
}

showBuildList()
{
clear
echo ""
echo "The following are the builds list:"
echo "--------------------------------------------"
cat $newBuildList
echo "--------------------------------------------"
echo ""
}

getBuildFile()
{
ftp -niv $ftpIP > $ftpTempFile <<EOF
user $ftpUser $ftpPass
cd $ftpFolder
bin
get $1
by
EOF
}

updateWarBuild()
{
echo "--$1--"
mkdir -p $webappsFolder/$1
cd $webappsFolder/$1
jar -xf $lastFolder/tmp/$1.war
cd -
echo ""
}

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

installWidget()
{
echo "===$1==="
./${installShellName} 2&>1 << EOF



pass


$1
EOF
echo ""
}

approveWidget()
{
echo "===$1==="
./${approveShellName} 2&>1 << EOF



pass


$1
EOF
echo ""
}

#################################
#	backup config		#
#################################

echo "backup old config file..."
$autoHome/bin/backupConfigFile.sh

#################################
#	specify build		#
#################################

echo "get required build..."
echo ""
echo -e "Do you want to specify the build numbers?y/n[n]\c"
read userWantSpecify
echo ""

if [ "X$userWantSpecify" = "Xy" -o "X$userWantSpecify" = "XY" ]
then
specifyBuildName
else
#auto get Build number
rm -f $newBuildList
for v in `cat $appList | sed '/^#/d' | awk -F: '{print $2}'`
do
getLatestBuildName $v
done
fi

showBuildList

#################################
#	download build		#
#################################

echo ""
echo "Begin to download required files..."
mkdir -p $buildFolder
rm -rf $lastFolder
ln -s $buildFolder $lastFolder
cd $lastFolder
for v in `cat $newBuildList`
do
getBuildFile $v
done
echo "The following files have been downloaded:"
ls -l $buildFolder | awk '{print $9}'
echo ""

#################################
#	deploy build		#
#################################

cat $newBuildList|sed '/^#/d' |sed '/^$/d'> $requiredList
ls -l $lastFolder/ | awk '{print $9}'| sed '/^$/d' > $realList
if [ `diff $requiredList $realList |wc -l` -eq 0 ]
then
#get all build file names
wapiBuildName=`ls -l $lastFolder/ | awk '{print $9}'|grep WBXwapi`
dmsBuildName=`ls -l $lastFolder/ | awk '{print $9}'|grep WBXdms`

#untar WAPI/DMS build
mkdir -p $lastFolder/tmp $lastFolder/wig
tar xf $lastFolder/$wapiBuildName -C $lastFolder/tmp
tar xf $lastFolder/$dmsBuildName -C $lastFolder/tmp

#update WAPI/DMS build
/etc/init.d/wbxtomcat.sh stop
#rm -rf /usr/local/apache-tomcat/logs/*
rm -rf /usr/local/apache-tomcat/temp/*
rm -rf /wbxdms_local/*
mv $webappsFolder $webappsFolder.$applyTime
mkdir -p $webappsFolder
for v in `cat $warList| sed '/^#/d'`
do
        updateWarBuild $v
done
chmod -R 755 $webappsFolder
chown -R nobody:nobody $webappsFolder

rm -rf $lastFolder/tmp

#################################
#	restore config		#
#################################

echo "restore config file..."
$autoHome/bin/restoreConfigFile.sh

#################################
#	start tomcat		#
#################################

/etc/init.d/wbxtomcat.sh start
echo "sleep 20 seconds..."
sleep 20

#################################
#	post mashkit		#
#################################

echo "post mashkit.."

mashkitBuildName=`ls -l $lastFolder/ | awk '{print $9}'|grep WBXcwclient`
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

#################################
#	upload widgets		#
#################################

echo ""
echo "upload widgets..."
widgetBuildName=`ls -l $lastFolder/ | awk '{print $9}'|grep WBXwidget`
installShellName=`ls -l $lastFolder/ | awk '{print $9}'|grep installwgt`
approveShellName=`ls -l $lastFolder/ | awk '{print $9}'|grep approvewgt`

#handle Widget build in wig folder
mkdir -p $widgetFolder
cp $lastFolder/$widgetBuildName $widgetFolder
cp $lastFolder/$installShellName $widgetFolder
cp $lastFolder/$approveShellName $widgetFolder
cd $widgetFolder
chmod +x *.sh

for v in `cat $widgetConfList|sed '/^#/d'|awk -F: '{print $2}'`
do
installWidget $v
done

for v in `cat $widgetConfList|sed '/^#/d'|awk -F: '{print $1}'`
do
approveWidget $v
done

rm -rf $widgetFolder

echo ""

else
echo ""
echo "the downloaded builds are not the same as required..."
echo ""
fi 
rm -rf $requiredList $realList
