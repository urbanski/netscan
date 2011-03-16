#!/bin/bash
PORTPATH="/opt/netscan/ports.lst"
SQLFILE=`date +%s`
SQLOUT="/tmp/$SQLFILE.sqlout"
for port in $(cat $PORTPATH) ; do
	TEMPFILE=`date +%s | md5sum | awk -F" " '{print $1}'`
	TEMPPATH="/tmp/history-$TEMPFILE.sql"
	SQLCOUNT="SELECT COUNT(*) FROM hosts WHERE HostPort='$port'"
	echo $SQLCOUNT > $TEMPPATH
	COUNT=`mysql -uDB_USER -pDB_PASS -hDB_HOST -D DB_NAME < $TEMPPATH | tail -n 1 `

	SQLINSERT="INSERT INTO \`history\` (\`HistoryDate\`,\`HistoryPort\`,\`HistoryCount\`) VALUES(CURDATE(),'$port','$COUNT');"
	echo $SQLINSERT >> $SQLOUT
done
mysql -uDB_USER -pDB_PASS -hDB_HOST -D DB_NAME < $SQLOUT
