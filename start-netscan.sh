#!/bin/bash

PORTFILE="/opt/netscan/ports.lst"
range=$1

for port in $(cat $PORTFILE); do
	echo "Scanning $range for $port"
	/opt/netscan/scan-for-port.sh $range $port
done
