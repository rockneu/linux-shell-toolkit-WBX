#!/bin/sh
applyTime=`date '+%Y%m%d-%H:%M:%S'`
confFolder=/spare/conf/$applyTime
webappsFolder=/usr/local/apache-tomcat/webapps

backupConfigFile()
{
#cas
mkdir -p $confFolder/cas
cp ${webappsFolder}/cas/WEB-INF/classes/conf/authserver_service.properties ${confFolder}/cas/authserver_service.properties
cp ${webappsFolder}/cas/WEB-INF/classes/conf/cas0100.properties ${confFolder}/cas/cas0100.properties
cp ${webappsFolder}/cas/WEB-INF/classes/conf/casserver_config.properties ${confFolder}/cas/casserver_config.properties
cp ${webappsFolder}/cas/WEB-INF/classes/conf/casserver_wapi.properties ${confFolder}/cas/casserver_wapi.properties
#CM
mkdir -p $confFolder/CM0100
cp ${webappsFolder}/CM0100/WEB-INF/classes/conf/CM0100.properties ${confFolder}/CM0100/CM0100.properties
#connectimages
#Nothing to be backup...
#probeconnect
#mkdir -p $confFolder/probeconnect
#cp ${webappsFolder}/probeconnect/WEB-INF/classes/conf/connect_master_config.properties ${confFolder}/probeconnect/connect_master_config.properties
#SM
mkdir -p $confFolder/SM0100
cp ${webappsFolder}/SM0100/WEB-INF/classes/conf/SM0100.properties ${confFolder}/SM0100/SM0100.properties
#tableservice
mkdir -p $confFolder/tableservice
cp ${webappsFolder}/tableservice/WEB-INF/classes/conf/wbxcts0100.properties ${confFolder}/tableservice/wbxcts0100.properties
#tal
mkdir -p $confFolder/tal
#cp ${webappsFolder}/tal/WEB-INF/classes/conf/cts.properties ${confFolder}/tal/cts.properties
#cp ${webappsFolder}/tal/WEB-INF/classes/conf/tableserviceapplicationlayer.properties ${confFolder}/tal/tableserviceapplicationlayer.properties
cp ${webappsFolder}/tal/WEB-INF/classes/conf/tal.properties ${confFolder}/tal/tal.properties
cp ${webappsFolder}/tal/WEB-INF/classes/conf/wapi.properties ${confFolder}/tal/wapi.properties
cp ${webappsFolder}/tal/WEB-INF/classes/conf/wbxcts0100.properties ${confFolder}/tal/wbxcts0100.properties
cp ${webappsFolder}/tal/WEB-INF/classes/conf/wbxtal0100.properties ${confFolder}/tal/wbxtal0100.properties

#wbxconnect
mkdir -p $confFolder/wbxconnect
cp ${webappsFolder}/wbxconnect/WEB-INF/classes/conf/activemq.xml ${confFolder}/wbxconnect/activemq.xml
cp ${webappsFolder}/wbxconnect/WEB-INF/classes/conf/wapiConfig.xml ${confFolder}/wbxconnect/wapiConfig.xml
cp ${webappsFolder}/wbxconnect/WEB-INF/classes/conf/wbxconnect0100.properties ${confFolder}/wbxconnect/wbxconnect0100.properties
cp ${webappsFolder}/wbxconnect/WEB-INF/classes/conf/clientServerConfig.xml ${confFolder}/wbxconnect/clientServerConfig.xml
#wbxcpip
mkdir -p $confFolder/wbxcpip
cp ${webappsFolder}/wbxcpip/WEB-INF/classes/conf/cpip.properties ${confFolder}/wbxcpip/cpip.properties
#wbxcsuper
mkdir -p $confFolder/wbxcsuper
cp ${webappsFolder}/wbxcsuper/WEB-INF/conf/wbxsuperserver.properties ${confFolder}/wbxcsuper/wbxsuperserver.properties
#wbxdms
#mkdir -p $confFolder/wbxdms
#cp ${webappsFolder}/wbxdms/WEB-INF/classes/conf/wbxdms0100.properties ${confFolder}/wbxdms/wbxdms0100.properties
#wikiservice
mkdir -p $confFolder/wikiservice
cp ${webappsFolder}/wikiservice/WEB-INF/classes/conf/wbxwiki0100.properties ${confFolder}/wikiservice/wbxwiki0100.properties
}

backupConfigFile
rm -rf ${confFolder}/../last
ln -s ${confFolder}  ${confFolder}/../last
