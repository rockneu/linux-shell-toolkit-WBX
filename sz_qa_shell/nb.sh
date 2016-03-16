#!/bin/sh
applyTime=`date '+%Y%m%d%H%M%S'`
webappsFolder=$CATALINA_HOME/webapps
buildFolder=/build/C6/last
warList=/spare/bin/war.lst
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

#untar WAPI/DMS build
mkdir -p $buildFolder/tmp $buildFolder/wig
tar xf $buildFolder/$wapiBuildName -C $buildFolder/tmp

#update WAPI/DMS build

/etc/init.d/wbxtomcat.sh stop
#rm -rf /usr/local/apache-tomcat/logs/*
rm -rf /usr/local/apache-tomcat/temp/*
rm -rf /wbxdms_local/*
rm -rf $webappsFolder
mkdir -p $webappsFolder

for v in `cat $warList| sed '/^#/d'`
do
        updateWarBuild $v
done
chmod -R 755 $webappsFolder
chown -R nobody:nobody $webappsFolder
