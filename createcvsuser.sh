
echo $CVSROOT
pwdfile="passwd"
if [ -d $CVSROOT ];then
pwdfile=$CVSROOT"/CVSROOT/"$pwdfile
fi

echo $pwdfile

if [ $# != 3 ];then
echo  "USAGE: $0 USERNAME PASSWORD linux_user_name"
echo " e.g. : $0 lilei 123456 wireless_group2"
exit 1;
fi
username=$1
password=$2
linuxUserName=$3
if [ ! -f "$pwdfile" ];then
echo "" > $pwdfile
fi


htpasswd -b $pwdfile $username   $password

sed -i "s/$username:.*/&:$linuxUserName/" $pwdfile
