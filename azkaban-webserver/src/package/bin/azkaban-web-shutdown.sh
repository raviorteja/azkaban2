azkaban_dir=$(dirname $0)/..

#!/bin/bash
proc=`cat $azkaban_dir/currentpid`

if ! [ "$proc" ]; then
    ps -ef |grep "java.*azkaban-web-server" | grep -v grep
    proc=`ps -ef |grep "java.*azkaban-web-server" | grep -v grep | sed 's/  */ /g' | cut -d' ' -f2`
fi

echo "killing AzkabanWebServer $proc"
if [ "$proc" ]; then
    kill $proc
fi

cat /dev/null > $azkaban_dir/currentpid
