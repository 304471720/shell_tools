#!/bin/bash
source  ljj_shell_tools.sh
if [ $# != 2 ] ; then
echo "USAGE: $0 'notice telphone' 'threshold'" 
echo " e.g.: $0 '13121309xxx' '0.7'" 
exit 1;
fi
if [[ ! $1 =~ ^[0-9]{11}$ ]]
  then
        echo "USAGE: $0 'notice telphone' 'threshold'" 
        echo " e.g.: $0 '13121309xxx' '0.7'" 
  exit
fi

if [[ ! $2 =~ ^0\.[0-9]+$ ]]
  then
	echo "USAGE: $0 'threshold'" 
	echo " e.g.: $0 '0.7'" 
  exit
fi
#exit 
result1=$(GetMemcachedStatsValuesByKeys '192.168.5.172 11204' 'bytes limit_maxbytes get_hits get_misses')
memoryUsageRate=$(echo $result1 | awk '{print $1/$2}')
itemRate=$(echo $result1 | awk '{print $3/($4+$3)}')
echo $memoryUsageRate
echo $itemRate
tel=$1
alarmValue=$2
#if [ "$memoryUsageRate" -gt "0.6" ];then
result=$(expr $memoryUsageRate \> $alarmValue)

if [ $result -eq 1 ];then
	SendMsg  $tel  "memcache 使用率超过预警值:$alarmValue, 达到$memoryUsageRate,命中率:$itemRate   "  'wireless.soufun.com/sms_validate/sendsms.do' test test
fi
echo $result1

