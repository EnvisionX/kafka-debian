##
## Apache Kafka periodic tasks
##

*/10 *  * * *  root  /usr/share/kafka/configure-topics.sh >> /var/log/kafka/configure-topics.log 2>&1
