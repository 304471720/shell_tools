if [ $# -ne 1 ];then
        echo "usage: $0  scriptfullpath"
        echo "eg: $0  /etc/init.d/test_AgentApp_8888.sh"
        exit
else
   path=$1
fi

for i in $(seq 10)
do
#sudo sh $path stop
sudo sh $path start
done
