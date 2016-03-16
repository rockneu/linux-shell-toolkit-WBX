#!/bin/sh
applyTime=`date '+%Y%m%d-%H:%M:%S'`
buildFolder=/build/C6/last
widgetFolder=$buildFolder/wig
widgetConfList=/spare/conf/widgetConf.lst
widgetBuildName=`ls -l $buildFolder/ | awk '{print $9}'|grep WBXwidget`
installShellName=`ls -l $buildFolder/ | awk '{print $9}'|grep installwgt`
approveShellName=`ls -l $buildFolder/ | awk '{print $9}'|grep approvewgt`

handleWidget()
{
echo "===$1===$1==="
./$1 2&>1 << EOF



pass


$2
EOF
echo ""
}

#handle Widget build in wig folder
mkdir -p $widgetFolder
cp $buildFolder/$widgetBuildName $widgetFolder
cp $buildFolder/$installShellName $widgetFolder
cp $buildFolder/$approveShellName $widgetFolder
cd $widgetFolder
chmod +x *.sh

for v in `cat $widgetConfList|awk -F: '{print $2}'`
do
handleWidget $installShellName $v
done

for v in `cat $widgetConfList|awk -F: '{print $1}'`
do
handleWidget $approveShellName $v
done

rm -rf $widgetFolder
