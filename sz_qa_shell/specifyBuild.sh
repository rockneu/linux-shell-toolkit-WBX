#!/bin/sh
appList=/spare/conf/down.lst
newBuildList=/spare/conf/new.lst
echo "Please specify required build numbers..."
rm -f $newBuildList
for v in `cat $appList|sed '/^#/d'|awk -F: '{print $2}'`
do
echo -e "$v...\c"
read buildNumber
echo "$v$buildNumber.tar" >>$newBuildList
echo ""
done
clear
echo "The following are the build list you want to download:"
echo "------------------------------------------------------"
echo ""
cat $newBuildList
echo ""
echo "------------------------------------------------------"
echo ""
