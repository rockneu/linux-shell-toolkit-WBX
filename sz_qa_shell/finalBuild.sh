#!/bin/sh
echo -e "Do you want to specify the build numbers?y/n[n]\c"
read userWantSpecify
echo ""
if [ "X$userWantSpecify" = "Xy" -o "X$userWantSpecify" = "XY" ]
then
./specifyBuild.sh
else
./autoBuild.sh
fi
