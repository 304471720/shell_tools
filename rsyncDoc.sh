#!/bin/bash
if [ $# != 2 ] ; then
echo "USAGE: $0 'rsysnc_ip1' 'rsysnc_ip2'  " 
echo " e.g.: $0 '192.168.5.154 ' '192.168.7.231' " 
exit 1;
fi

username=`whoami`

localIp=`cat /etc/sysconfig/network-scripts/ifcfg-eth1 | grep IPADDR | awk '-F=' '{print $2}'`
for index in  "$@"
do
if [ "$index" != "$localIp" ] ; then
  #echo $index
  #echo $localIp
  sourcedir="/sourceDir/*"
  destdir="$username@$index:/destDir/"
  echo $sourcedir 
  echo $destdir 
  rsync -e 'ssh -p 33777'  -avzu --progress $sourcedir   $destdir
fi
done
