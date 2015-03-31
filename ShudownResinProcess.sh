watch_dog_pid=`sudo sh $0 status | grep pid | awk -F ':' '{print $2+0}' | head -n 1`
echo "===="$watch_dog_pid
process_pid=`  sudo sh $0 status | grep pid | awk -F ':' '{print $2+0}' | tail -n 1`
echo "===="$process_pid
sudo kill -9 $watch_dog_pid
sudo kill -9 $process_pid
