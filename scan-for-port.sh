#!/bin/bash
echo "Scanning $1 for open port $2"

TEMPFILE=`date | md5sum | awk -F" " '{print $1}'`
TEMPPATH="/tmp/$TEMPFILE.scan-results"
IPPATH="/tmp/$TEMPFILE.scan-ips"
SQLPATH="/tmp/$TEMPFILE.sql"
PORT=$2

nmap -PN -sS --open --min-hostgroup 256 -T4 -p$2 -oG $TEMPPATH $1

grep -v "#" $TEMPPATH | grep "$PORT/open" | awk -F" " '{print $2}' > $IPPATH

for line in $(cat $IPPATH) ; do
	echo "$line has open port $2"

	#prepare mysql insert
	SQLDELETE="delete from hosts where HostPort='$2' and HostIP='$line';"
	SQLINSERT="INSERT INTO hosts (\`HostIP\`,\`HostPort\`,\`HostDateIdentified\`) VALUES('$line','$2',CURDATE());"
	echo $SQLDELETE >> $SQLPATH
	echo $SQLINSERT >> $SQLPATH

done

#do mysql heavy lifting
mysql -u DB_USER -p DB_PASS -h DB_SERVER -D netscan < $SQLPATH
