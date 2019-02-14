#!/bin/sh
# File Author: https://bigdata.wordpress.com/2010/05/27/hadoop-cookbook-4-how-to-run-multiple-data-nodes-on-one-machine/
# This is used for starting multiple datanodes on the same machine.
# run it from hadoop-dir/ just like 'bin/hadoop' 
# Other info https://www.quora.com/Is-it-possible-to-have-multiple-data-nodes-in-pseudo-distributed-Hadoop

#Usage: run-additionalDN.sh [start|stop] dnnumber
#e.g. run-datanode.sh start 2

rm -rf /tmp/hadoop-additional-datanodes
mkdir /tmp/hadoop-additional-datanodes

## DN_DIR_PREFIX="/path/to/store/data_and_log_of_additionalDN/"
DN_DIR_PREFIX="/tmp/hadoop-additional-datanodes/"

if [ -z $DN_DIR_PREFIX ]; then
echo $0: DN_DIR_PREFIX is not set. set it to something like "/hadoopTmp/dn"
exit 1
fi

run_datanode () {
DN=$2
export HADOOP_LOG_DIR=$DN_DIR_PREFIX$DN/logs
export HADOOP_PID_DIR=$HADOOP_LOG_DIR
DN_CONF_OPTS="\
-Dhadoop.tmp.dir=$DN_DIR_PREFIX$DN\
-Ddfs.datanode.address=0.0.0.0:5001$DN \
-Ddfs.datanode.http.address=0.0.0.0:5008$DN \
-Ddfs.datanode.ipc.address=0.0.0.0:5002$DN"
bin/hadoop-daemon.sh --script bin/hdfs $1 datanode $DN_CONF_OPTS
}

cmd=$1
shift;

for i in $*
do
run_datanode  $cmd $i
done