#!/bin/bash
if [ "$#"  -ne 3 ]
then
    echo "First  parameter is output port"
    echo "Second parameter is input  port"
    echo "Third parameter is client@client_ipaddress"
    exit 1
fi

ssh -fNTL $1:localhost:$2 -o GatewayPorts=yes $3
exit 0

