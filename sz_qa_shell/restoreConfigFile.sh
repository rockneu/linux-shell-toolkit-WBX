#!/bin/sh
confFolder=/spare/conf/last
webappsFolder=$CATALINA_HOME/webapps

restoreConfigFile()
{
#cas
cp ${confFolder}/cas/authserver_service.properties ${webappsFolder}/cas/WEB-INF/classes/conf/authserver_service.properties
cp ${confFolder}/cas/cas0100.properties ${webappsFolder}/cas/WEB-INF/classes/conf/cas0100.properties
cp ${confFolder}/cas/casserver_config.properties ${webappsFolder}/cas/WEB-INF/classes/conf/casserver_config.properties
cp ${confFolder}/cas/casserver_wapi.properties ${webappsFolder}/cas/WEB-INF/classes/conf/casserver_wapi.properties
#CM
cp ${confFolder}/CM0100/CM0100.properties ${webappsFolder}/CM0100/WEB-INF/classes/conf/CM0100.properties
#connectimages
#Nothing to be backup...
#probeconnect
#cp ${confFolder}/probeconnect/connect_master_config.properties ${webappsFolder}/probeconnect/WEB-INF/classes/conf/connect_master_config.properties
#SM
cp ${confFolder}/SM0100/SM0100.properties ${webappsFolder}/SM0100/WEB-INF/classes/conf/SM0100.properties
#tableservice
cp ${confFolder}/tableservice/wbxcts0100.properties ${webappsFolder}/tableservice/WEB-INF/classes/conf/wbxcts0100.properties
#tal
#cp ${confFolder}/tal/cts.properties ${webappsFolder}/tal/WEB-INF/classes/conf/cts.properties
#cp ${confFolder}/tal/tableserviceapplicationlayer.properties ${webappsFolder}/tal/WEB-INF/classes/conf/tableserviceapplicationlayer.properties
cp ${confFolder}/tal/tal.properties ${webappsFolder}/tal/WEB-INF/classes/conf/tal.properties
cp ${confFolder}/tal/wapi.properties ${webappsFolder}/tal/WEB-INF/classes/conf/wapi.properties
cp ${confFolder}/tal/wbxcts0100.properties ${webappsFolder}/tal/WEB-INF/classes/conf/wbxcts0100.properties
cp ${confFolder}/tal/wbxtal0100.properties ${webappsFolder}/tal/WEB-INF/classes/conf/wbxtal0100.properties

#wbxconnect
cp ${confFolder}/wbxconnect/activemq.xml ${webappsFolder}/wbxconnect/WEB-INF/classes/conf/activemq.xml
cp ${confFolder}/wbxconnect/wapiConfig.xml ${webappsFolder}/wbxconnect/WEB-INF/classes/conf/wapiConfig.xml
cp ${confFolder}/wbxconnect/wbxconnect0100.properties ${webappsFolder}/wbxconnect/WEB-INF/classes/conf/wbxconnect0100.properties
cp ${confFolder}/wbxconnect/clientServerConfig.xml ${webappsFolder}/wbxconnect/WEB-INF/classes/conf/clientServerConfig.xml
#wbxcpip
cp ${confFolder}/wbxcpip/cpip.properties ${webappsFolder}/wbxcpip/WEB-INF/classes/conf/cpip.properties
#wbxcsuper
cp ${confFolder}/wbxcsuper/wbxsuperserver.properties ${webappsFolder}/wbxcsuper/WEB-INF/conf/wbxsuperserver.properties
#wbxdms
#cp ${confFolder}/wbxdms/wbxdms0100.properties ${webappsFolder}/wbxdms/WEB-INF/classes/conf/wbxdms0100.properties
#wikiservice
cp ${confFolder}/wikiservice/wbxwiki0100.properties ${webappsFolder}/wikiservice/WEB-INF/classes/conf/wbxwiki0100.properties
}

restoreConfigFile
