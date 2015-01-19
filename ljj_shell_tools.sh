GetMemcachedStatsValuesByKeys()
{
if [ $# != 2 ] ; then 
echo "USAGE: $0 'SERVERIP PORT' 'key1 key2 key 3'  " 
echo " e.g.: $0 '127.0.0.1 11211 ' 'key1 key2 key3' " 
exit 1; 
fi

IP_PORT=$1
KEYS=$2
keyss=""
#echo $KEYS
#echo $IP_PORT 

for key in $KEYS;
do
keyss=$keyss" -e "$key
done;

value=`(sleep 2;echo stats ;sleep 1; echo quit) | telnet ${IP_PORT} | grep ${keyss} | awk '{ print $3}'`
ifsuccess=`echo ${#value}`
if [ ${ifsuccess} -eq 0 ];then
     result="@NULL"
else
     result="$value"
fi
#echo "1--------------"
echo $result
#echo "2--------------"
return $result
}
