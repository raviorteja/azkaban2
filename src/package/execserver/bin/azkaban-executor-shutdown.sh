#!/bin/bash
azkaban_dir=$(dirname $0)/..

executorport=`cat $azkaban_dir/conf/azkaban.properties | grep executor.port | cut -d = -f 2`
echo "Shutting down current running AzkabanExecutorServer at port $executorport"

proc=`cat $azkaban_dir/currentpid`

if ! [ "$proc" ]; then
    ps -ef |grep "java.*azkaban-exec-server" | grep -v grep
    proc=`ps -ef |grep "java.*azkaban-exec-server" | grep -v grep | sed 's/  */ /g' | cut -d' ' -f2`
fi


if [ "$proc" ]; then
    kill $proc
fi

cat /dev/null > $azkaban_dir/currentpid
