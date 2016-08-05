#!/bin/sh -e

##
## Periodic task for Apache Kafka topics configuration
## Started by cron.
##

CFG="/etc/kafka/topics.conf"

FLAG="/var/lib/kafka/configure-topics.flag"

if test ! -f "$CFG"; then
    # no config - nothing to do
    exit 0
fi
if test -f "$FLAG" -a "$FLAG" -nt "$CFG"; then
    # flag file is exists and is older than config - skip
    exit 0
fi
if ! systemctl status zookeeper > /dev/null; then
    # Zookeeper is not alive - skip
    exit 0
fi

echo "`date '+%Y-%m-%d %H:%M:%S %z'` *** woke up"

# parse config file and configure topics

# Format of the config file is: '<topic_name> <max_size_in_megabytes>'
# All empty lines and lines started with '#' sign are ignored.

egrep -v '^\s*$|^\s*#.*$' "$CFG" | \
   while LINE=`line`; do
      TOPIC=`echo "$LINE" | awk '{print$1}'`
      MEGS=`echo "$LINE" | awk '{print$2}'`
      BYTES=`expr "$MEGS" \* 1024 \* 1024`
      kafka-topics --alter --config "retention.bytes=$BYTES" --topic "$TOPIC" --zookeeper 127.0.0.1:2181
   done

# all configurations were applied successfully
touch "$FLAG"
