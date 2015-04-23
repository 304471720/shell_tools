 

nohup  zcat -f `sudo find /logs/soufunapp.3g.soufun.com/ /logs/soufunappesf.3g.soufun.com.log/ /logs/soufunappzf.3g.soufun.com.log/ -name *20150417*`| awk '{if($7~/messagename/){print $7}}'| awk -F'&|=|?' '{for(i=2;i<=NF;i++){if( $i == "messagename") printf("%s\t%s\n",$i,$(i+1)) };}' | sort | uniq -c|sort -k1,1nr  >> ~/fang_`date "+%Y-%m-%d_%H_%M_%S"`.txt /dev/null 2>&1 &

统计messagename种类数量，并按照倒序排列

DAYS="0618 0619 0620 0621 0622 0623"
echo "---------------------" > house.log
for day in $DAYS
do
echo "2014"$day >> house.log
#for messagename in $(cat messagenametmp.txt)
#do 
#echo $messagename >> house.log
#zcat -f `sudo find /logs/agentapphouse.3g.soufun.com/ /logs/agentappnew.3g.soufun.com/ -name *2014$day*` |sed -n '/21:30:00/,/22:30:00/p' | grep messagename=$messagen
ame | wc -l  >> house.log
#done 
#zcat -f `sudo find /logs/agentapphouse.3g.soufun.com/ /logs/agentappnew.3g.soufun.com/ -name *2014$day*` |sed -n '/21:30:00/,/22:30:00/p' | awk '{if($7~/messagename/)
{print $7}}'| awk -F'&|=|?' '{for(i=2;i<=NF;i++){if( $i == "messagename")printf $i"\t"$(i+1)"\n"};}' | uniq -c | sort -r >> house.log
#zcat -f `sudo find /logs/agentapphouse.3g.soufun.com/ /logs/agentappnew.3g.soufun.com/ -name *2014$day*` |sed -n '/21:30:00/,/22:30:00/p' | awk '{if($7~/messagename/)
{print $7}}'| awk -F'&|=|?' '{for(i=2;i<=NF;i++){if( $i == "messagename")printf $i"\t"$(i+1)"\n"};}'| sort | uniq -c|sort -k1,1nr|head -30 >> house.log

zcat -f `sudo find /logs/agentapphouse.3g.soufun.com/ /logs/agentappnew.3g.soufun.com/ -name *2014$day*` |sed -n '/21:30:00/,/22:30:00/p' | awk '{if($7~/messagename/){
print $7}}'| awk -F'&|=|?' '{for(i=2;i<=NF;i++){if( $i == "messagename")printf $i"\t"$(i+1)"\n"};}'| sort | uniq -c|sort -k1,1nr >> house.log
done


