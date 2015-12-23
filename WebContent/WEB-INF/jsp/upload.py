import codecs
import MySQLdb

conn=MySQLdb.connect(host='10.15.62.51',user='admin',passwd='cadal',\
                     db='sampledb',charset='utf8')
cursor=conn.cursor()