#!/bin/sh
# Target 
#Plan to use this script to download WAPI, CAS, UserService, OOB Widget and other tricon app like NS, GS from WebEx FTP

# Method
# 1 determin to download which kind of App package from user input
# 2 determin to download which version of App from user input
# 3 initiate an array by assigning the array the package and doc names
# 4 download related files with the array elements

# Precondition
# need to run this shell with ROOT

# FTP info here
ftpIP=10.224.114.246
ftpUser=webex_us
ftpPass=awk159
ftpFolder=/home/webex_us/client/us

#------------------------------------
# debug info here
#ftpIP=10.224.101.168#ftpUser=rock#ftpPass=pass#ftpFolder=test/
#------------------------------------

# get WBX application type from user input
echo ""
echo ""
echo "Welcome to download WBX Application with this Shell!"
echo ""

echo "1-CAS, 2-UserService, 3-WAPI, 4-OOB_Widget, 5-WebIM, 6-IMDS"
read -p "Please input your choice:"  appType

# get application version info from user input
read -p "Please input the version number of application: " appVern
# [Protection] need to check user input here
# [Initiation] need to initiate buildDest, array info here
if [ $appType -eq "1" ]
then
	appDest=/build/C65/cas/
	echo $appDest
	szAppFile=("install-CAS1_0_0-$appVern.sh" "readme-CAS1_0_0-$appVern.doc" "WBXcas-CAS1_0_0-$appVern.tar")
	echo ${szAppFile[0]}
elif [ $appType -eq "2" ]
then
	appDest=/build/C65/userService/
	echo $appDest
	szAppFile=("install-USERSERVICE1_0_0-$appVern.sh" "readme-USERSERVICE1_0_0-$appVern.doc" "WBXuserservice-USERSERVICE1_0_0-$appVern.tar")
elif [ $appType -eq "3" ]
then
	appDest=/build/C65/wapi/
	echo $appDest	
	szAppFile=("WBXwapi_all-WAPI-$appVern.tar" "WBXcwclient-WAPI-$appVern.tar" "ConnectConfiguration-WAPI-$appVern.doc" "installSA-WAPI-$appVern.sh")
	echo ${szAppFile[0]}
elif [ $appType -eq "4" ]
then
	appDest=/build/C65/oob-widget/
	echo $appDest	
	szAppFile=("WBXwidget_all-WIDGET-$appVern.tar" "installwgt-WIDGET-$appVern.sh" "approvewgt-WIDGET-$appVern.sh" "readme-WIDGET-$appVern.txt")
elif [ $appType -eq "5" ]
then
	appDest=/build/C65/webim/
	echo $appDest
	szAppFile=("WBX-WEBIM2_0_0-$appVern.tar")
elif [ $appType -eq "6" ]
then
	appDest=/build/C65/imds/
        echo $appDest
        szAppFile=("WBXimds-IMDS1_0_0-$appVern.rpm")
else
	echo "Invalid input!"
	echo "Bye Bye!"
fi

# need to check if this directory is mounted or not before downloading
if [ -d $appDest$appVern ]
then
	# package directory already exists
	echo ""
	echo "The directory already exists - "$appDest$appVern
	echo ""
else
	mkdir $appDest$appVern
	echo ""
	echo "Created a directory - "$appDest$appVern
	echo ""
fi

getWBXAppfromFTP(){
#// need to go to the target directory
	cd $appDest$appVern
	echo $appDest$appVern
#echo "WAPI related package is starting!"
ftp -ni<<EOF
open $ftpIP
user $ftpUser $ftpPass
cd $ftpFolder
binary
get ${szAppFile[0]}
get ${szAppFile[1]}
get ${szAppFile[2]}
get ${szAppFile[3]}
bye
EOF
}
echo ""
echo "Starting to download ... !"
echo ""
echo ""

# used to test if the first file exists
#ftp -ni 192.168.1.102 >ftp.err <<EOF 
#user rock pass
#size 11.txt
#bye
#EOF


getWBXAppfromFTP
echo ""
echo ""
echo "Downloading is finished!"
echo ""
echo "The package is placed at "$appDest$appVern
echo ""
echo ""
