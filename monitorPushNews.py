#coding=utf-8
#! /usr/bin/env python
import MySQLdb
import time
import urllib2
import urllib
from urllib import quote
import os,sys,inspect
import smtplib

def sendmail(fromwho='from@email.com',towho='to@email.com',subject='no subject',msgcont='no content'):
   smtp = smtplib.SMTP()
   smtp.connect("smtp_url", "25")
   emails=[fromwho,towho,subject,msgcont]
   msgcont='''From: %s\r\nTo: %s\r\nSubject: %s\r\n\r\n%s''' % tuple(emails)
   smtp.sendmail(fromwho,towho,msgcont)
   smtp.quit()

   

def getCurrentTime(flag='h'):
    if(flag=='h'):
        timestr=time.strftime('%H',time.localtime(time.time()))
        print timestr
        return timestr
    elif(flag=='a'):
        timestr=time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time()))
        print timestr
        return timestr

def sendSms(tel,msgcont):
    if( msgcont != ''):
    	url = 'sms_url&dst='+tel+'&msg='+quote(msgcont)
    	result = urllib2.urlopen(url).read()
    	return result 
def script_path():
    caller_file=inspect.stack()[1][1] # caller's filename
    return os.path.abspath(os.path.dirname(caller_file))# path

def getSelfFilePath(flag='a'):
    if flag=='a':
	print script_path()
	tmptuple=[script_path(),__file__]
	tmp='%s/%s' % tuple(tmptuple)
    elif flag=='l':
	tmptuple=[script_path(),os.path.splitext(__file__)[0],'txt']
        tmp= '%s/%s.%s' % tuple(tmptuple)
    return tmp

def wireFile(str,filename=getSelfFilePath('l')):
    fileHandle = open (filename, 'a')
    fileHandle.write ( str )
    fileHandle.close()
def reafFile(filenames=getSelfFilePath('l')):
    if os.path.exists(filenames):
    	fileHandle = open (filenames) 
    	content=fileHandle.read()
    	fileHandle.close()
    	print content
    else:
	content=""
    return content
def getCountFromStr(str):
    tmp=str.split('#')
    return tmp


def mainMonitor():
    try:
    	conn=MySQLdb.connect(host='mysql_ip',user='dbusername',passwd='dbpassword',db='SouFunAPP_3G',port=3331)
    	currentHour=getCurrentTime('h')
    	gettimesql='''  SELECT inserttime FROM xxxxx ORDER BY inserttime DESC LIMIT 1  '''
    	cur=conn.cursor()
    	cur.execute(gettimesql)
    	for data in cur.fetchall():
            #print '  %s ' % data
	    currentTime='%s' % data
   
    	print currentTime
 
    	timeStrs=[currentHour,currentHour,currentTime]

    	sqlstr='''
	SELECT  COUNT(*) AS query_count  FROM xxxx  WHERE  xxxx%sxxxxx%sxxxx'%s'  ''' % tuple(timeStrs)
    	print sqlstr
    	cur=conn.cursor()
    	cur.execute(sqlstr)
    	for data in cur.fetchall():
    	    currentCount='%s' % data
    	print currentCount
    	currenttimes=getCurrentTime('a')
    	tmp=[currentCount,currenttimes]
    	writerecords='#%s;%s' % tuple(tmp)

    	allrecordstr=reafFile()
    	readrecords=getCountFromStr(allrecordstr)
	if len(readrecords)>=1:
    	    lastValue=readrecords[len(readrecords)-1]
    	    print lastValue
            lastcount=lastValue.split(';')[0]
	else:
	    lastcount=''
        wireFile(writerecords)
	if lastcount!='':    
    	    interval=eval(currentCount+'-'+lastcount)
    	    msgtuple=[currenttimes,currentCount,interval]
            msg='%sxxxxxxxxxxxxxxx%s,xxxxxxxxxxxxxxxxxxxxxxxxx%d' % tuple(msgtuple)
	    print msg
	    tem='%d' %interval
	    sendSms('tel_number',msg)
	    sendmail('monitorPushNews@soufun.com','lijia-wy@163.com','monitor',msg)
    	cur.close()
    	conn.close()
    except MySQLdb.Error,e:
        print "Mysql Error %d: %s" % (e.args[0], e.args[1])


if __name__=="__main__":
    print("main")
    currenttimes=getCurrentTime('a')
    hour=getCurrentTime('h')
    
    #if(int(hour) >= 8 and int(hour)<=12):
    mainMonitor()
    #print script_path()
    #print getSelfFilePath('a')
    #print getSelfFilePath('l')


