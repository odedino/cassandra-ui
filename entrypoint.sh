#!/bin/bash
set -eu
set +x

#HOST IP
if [[ ! -v CASSANDRA_HOST_IP ]]; then
  CASSANDRA_HOST_IP="127.0.0.1"
else
  HOST_IP="${CASSANDRA_HOST_IP}"
fi

#PORT
if [[ ! -v CASSANDRA_PORT ]]; then
  CASSANDRA_PORT="9042"
else
  CASSANDRA_PORT="${CASSANDRA_PORT}"
fi

#USERNAME
if [[ ! -v CASSANDRA_USERNAME ]]; then
  CASSANDRA_USERNAME="cassandra"
else
  CASSANDRA_USERNAME="${CASSANDRA_USERNAME}"
fi

#PASSWORD
if [[ ! -v CASSANDRA_PASSOWRD ]]; then
  CASSANDRA_PASSOWRD="cassandra"
else
  CASSANDRA_PASSOWRD="${CASSANDRA_PASSOWRD}"
fi

for i in $(echo $CASSANDRA_HOST | sed "s/,/ /g")
do
    # call your procedure/other scripts here below
    echo "address is $i"
    dig +short $i
    ips=$(dig +short $i)
    echo "resolved ips: $ips"
    single_line_ips=$(echo $ips)
    echo "single_line ips: $single_line_ips"
    CASSANDRA_HOST_IP=${single_line_ips// /,}
    echo "CASSANDRA_HOST_IP : $CASSANDRA_HOST_IP"
    a=$a,$CASSANDRA_HOST_IP
done

CASSANDRA_HOST_IP=$(echo ${a:1})
echo "CASSANDRA_HOST_IP : $CASSANDRA_HOST_IP"

COMMAND="cassandra-web --hosts $CASSANDRA_HOST_IP --port $CASSANDRA_PORT --username $CASSANDRA_USERNAME --password $CASSANDRA_PASSOWRD"

echo $COMMAND

exec $COMMAND