#!/bin/bash

## Program Name:	Download and install Hadoop, Pig, Hive and Spark
## Compiled by Naresh Seegobin naresh.seegobin@gmail.com
## Version History:
## 20190207 1444 - Initial version
## 20190208 0840 - added https://hadoop.apache.org/
## 20190211 1319 - added Hadoop execution scripts.      
##                 NB: Run java installation in another shell script as root. Everyhting here is supposed to be executed in userland.


## https://wiki.apache.org/hadoop/HadoopJavaVersions
## https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-ubuntu-18-04
## https://linuxconfig.org/how-to-install-java-on-ubuntu-18-04-bionic-beaver-linux

## root elsewhere: add-apt-repository ppa:webupd8team/java --yes
## root elsewhere: apt update --yes

## https://askubuntu.com/questions/190582/installing-java-automatically-with-silent-option

## root elsewhere: echo debconf shared/accepted-oracle-license-v1-1 select true | \
## root elsewhere: sudo debconf-set-selections
## root elsewhere: echo debconf shared/accepted-oracle-license-v1-1 seen true | \
## root elsewhere: sudo debconf-set-selections

## https://linuxconfig.org/how-to-install-java-on-ubuntu-18-04-bionic-beaver-linux
## root elsewhere: apt install oracle-java8-set-default --yes




## https://hadoop.apache.org/releases.html
## https://www-us.apache.org/dist/hadoop/common/hadoop-3.1.2/hadoop-3.1.2.tar.gz

## https://hive.apache.org/
## https://www-us.apache.org/dist/hive/hive-3.1.1/apache-hive-3.1.1-bin.tar.gz

## https://pig.apache.org/
## https://www-us.apache.org/dist/pig/pig-0.17.0/pig-0.17.0.tar.gz

## https://spark.apache.org/
## https://www-us.apache.org/dist/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz



mkdir ./Hadoop-et-al
cd ./Hadoop-et-al
wget -c https://www-us.apache.org/dist/hadoop/common/hadoop-3.1.2/hadoop-3.1.2.tar.gz
wget -c https://www-us.apache.org/dist/hive/hive-3.1.1/apache-hive-3.1.1-bin.tar.gz
wget -c https://www-us.apache.org/dist/pig/pig-0.17.0/pig-0.17.0.tar.gz
wget -c https://www-us.apache.org/dist/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz

tar -xvf ./hadoop-3.1.2.tar.gz
tar -xvf ./apache-hive-3.1.1-bin.tar.gz
tar -xvf ./pig-0.17.0.tar.gz
tar -xvf ./spark-2.4.0-bin-hadoop2.7.tgz


## https://hadoop.apache.org/docs/r3.1.2/hadoop-project-dist/hadoop-common/SingleCluster.html

## root elsewhere: apt install openssh-server --yes
## root elsewhere: apt-get install pdsh --yes

## https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-ubuntu-18-04
## https://linuxize.com/post/install-java-on-ubuntu-18-04/#set-the-java-home-environment-variable
## JAVA_HOME="/usr/lib/jvm/java-8-oracle/"
export JAVA_HOME="/usr/lib/jvm/java-8-oracle/"

cd ./hadoop-3.1.2
bin/hadoop
mkdir input
cp etc/hadoop/*.xml input
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.1.2.jar grep input output 'dfs[a-z.]+'
cat output/*


## Use the following:
## etc/hadoop/core-site.xml:

## <configuration>
##     <property>
##         <name>fs.defaultFS</name>
##         <value>hdfs://localhost:9000</value>
##     </property>
## </configuration>
## etc/hadoop/hdfs-site.xml:

## <configuration>
##     <property>
##         <name>dfs.replication</name>
##         <value>1</value>
##     </property>
## </configuration>

## https://stackoverflow.com/questions/44979985/replace-xml-tag-using-sed
sed ':a;N;$!ba; s|<configuration>.*<\/configuration>|<configuration\/>|g' etc/hadoop/core-site.xml


echo y | ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

## 1. Format the filesystem:
bin/hdfs namenode -format

## 2. Start NameNode daemon and DataNode daemon:
sbin/start-dfs.sh

## 3. Browse the web interface for the NameNode; by default it is available at:
## NameNode - http://localhost:9870/
/usr/bin/firefox http://localhost:9870/ &

## 4. Make the HDFS directories required to execute MapReduce jobs:
bin/hdfs dfs -mkdir /user
bin/hdfs dfs -mkdir /user/<username>

## 5. Copy the input files into the distributed filesystem:
bin/hdfs dfs -mkdir input
bin/hdfs dfs -put etc/hadoop/*.xml input


## 6. Run some of the examples provided:
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.1.2.jar grep input output 'dfs[a-z.]+'

## 7. Examine the output files: Copy the output files from the distributed filesystem to the local filesystem and examine them:
bin/hdfs dfs -get output output
cat output/*

## 7. OR View the output files on the distributed filesystem:
bin/hdfs dfs -cat output/*

## 8. When you’re done, stop the daemons with:
sbin/stop-dfs.sh








