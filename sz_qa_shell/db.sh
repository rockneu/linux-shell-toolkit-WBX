#!/bin/sh
dbTnsName=cnctadb
#dbUser=wapi
dbPass=pass
listFile=/usr/local/apache-tomcat/webapps/wbxconnect/dbpatch.lst
tmpFile1=/tmp/1.lst
tmpFile2=/tmp/2.lst
getVersionList()
{
echo "$1" >> $listFile
echo "=======================" >> $listFile
sqlplus $1/$dbPass@$dbTnsName <<EOF
spool $tmpFile1
select releaseNumber,finishTime from wbxcDatabaseHistory order by releaseNumber desc, finishTime desc;
spool off;
exit
EOF
#cat $tmpFile|sed '/^-/d;/^[a-zA-Z]/d;/^$/d'|sed '$d'|awk '{print $1,$2}'| sed '$!N; /^\(.*\)\n\1$/!P; D'> $listFile
cat $tmpFile1|sed '/^-/d;/^[a-zA-Z]/d;/^$/d'|sed '$d'|awk '{print $1,$2}' >> $tmpFile2
perl /spare/bin/1.pl $tmpFile2 >> $listFile
echo "" >> $listFile
rm -rf $tmpFile1 $tmpFile2
}
rm -rf $listFile
for v in wapi dms act tbs
do
getVersionList $v
done
chmod 777 $listFile
chown nobody:nobody $listFile 
