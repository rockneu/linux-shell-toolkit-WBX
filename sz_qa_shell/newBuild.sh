#!/bin/sh
applyTime=`date '+%Y%m%d%H%M%S'`
webappsFolder=$CATALINA_HOME/webapps
buildFolder=/build/C6/last
warList=/spare/conf/war.lst
updateWarBuild()
{
echo "--$1--"
mkdir -p $webappsFolder/$1
cd $webappsFolder/$1
jar -xf $buildFolder/tmp/$1.war
cd -
echo ""
}

#get all build file names
wapiBuildName=`ls -l $buildFolder/ | awk '{print $9}'|grep WBXwapi`
dmsBuildName=`ls -l $buildFolder/ | awk '{print $9}'|grep WBXdms`

#untar WAPI/DMS build
mkdir -p $buildFolder/tmp $buildFolder/wig
tar xf $buildFolder/$wapiBuildName -C $buildFolder/tmp
tar xf $buildFolder/$dmsBuildName -C $buildFolder/tmp

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

echo "restore config file..."
./restoreConfigFile.sh

/etc/init.d/wbxtomcat.sh start
echo "sleep 20 seconds..."
sleep 20

echo "post mashkit.."
./postMashkit.sh
echo ""
echo "upload widget"
./uploadWidget.sh
echo ""
