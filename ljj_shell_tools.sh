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
#return "$result"
}

#result1=$(GetMemcachedStatsValuesByKeys '192.168.5.172 11204' 'bytes_written limit_maxbytes curr_items total_items')
#echo $result1

SendMsg()
{
	if [ $# != 5 ] ; then
		echo "USAGE: $0 ' phone number '   'msg content'  'msg url' 'account' 'password' " 
		echo " e.g.: $0 131xxxxxxxx   "testtest"  'xxx.xxx.xxx/xx/xx/xxxx.jsp' xxxx xxxxxx  " 
		exit 1;
	fi
        tel=$1
        msgcont=$(eval echo $2 | iconv -f gb2312 -t utf8)
        r=`curl  -s "http://$3?name=$4&pwd=$5&dst=$tel" -d "&msg=$msgcont" | awk '{printf $1}'`
        if [ "$r"x == "0000"x ]; then
                echo "send sms success!"
		#return 0
        else
		echo "send sms fails!"
		#$return 1
        fi
        #echo  $tel $msgcont
}

#SendMsg 13121309305   "testtest"  'wireless.soufun.com/sms_validate/sendsms.do' test test 
SendMsg 13121309305   "≤‚ ‘≤‚ ‘"  'wireless.soufun.com/sms_validate/sendsms.do' test test  





