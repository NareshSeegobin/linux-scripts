#!/bin/bash

## Program Name:	Download and install Hadoop, Pig, Hive and Spark
## Compiled by Naresh Seegobin naresh.seegobin@gmail.com
## Version History:
## 20190207 1444 - Initial version
## 20190208 0840 - added https://hadoop.apache.org/
## 20190211 1319 - added Hadoop execution scripts.      
##                 NB: Run java installation in another shell script as root. Everyhting here is supposed to be executed in userland.
## 20190211 1457 - Issue with executign the server as user. Run everyhting as root  --> sudo su    
##                 As this is a VM, it is ok for now.
## 20190212 0900 - Hadoop works.     Need to add JAVA_HOME in etc/hadoop/hadoop-env.sh file

## Good Hadoop config primer:
## http://www.michael-noll.com/tutorials/running-hadoop-on-ubuntu-linux-single-node-cluster/

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


### ============================Standalone Operation    =============================================

## cd ./hadoop-3.1.2
## bin/hadoop
## mkdir input
## cp etc/hadoop/*.xml input
## bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-3.1.2.jar grep input output 'dfs[a-z.]+'
## cat output/*

##   =================== NB: Once the above works, the standalone works. ===========================


##  ========================================================================================
### ==================    Pseudo-Distributed Operation ==================

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
## https://stackoverflow.com/questions/23560215/replace-xml-value-with-sed
## DO NOT USE: ## sed ':a;N;$!ba; s|<configuration>.*<\/configuration>|<configuration\/>|g' etc/hadoop/core-site.xml
## TO DO LATER: sed -i -e '/<property>/,/<\/property>/ s|<name>[0-9a-z.]\{1,\}</name>|<name>dfs.replication</name>|g' etc/hadoop/core-site.xml
## TO DO LATER: sed -i -e '/<property>/,/<\/property>/ s|<value>[0-9a-z.]\{1,\}</value>|<value>hdfs://localhost:9000</value>|g' etc/hadoop/core-site.xml





echo y | ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys

export JAVA_HOME="/usr/lib/jvm/java-8-oracle/"
cd ./hadoop-3.1.2
bin/hadoop
mkdir input
cp etc/hadoop/*.xml input

## 1. Format the filesystem:
echo y | bin/hdfs namenode -format

## 2. Start NameNode daemon and DataNode daemon:
### DO NOT USE: sudo -E bash -c 'echo $HTTP_PROXY'
### DO NOT USE: sudo -E bash -c 'export JAVA_HOME="/usr/lib/jvm/java-8-oracle/"'

## https://stackoverflow.com/questions/48129029/hdfs-namenode-user-hdfs-datanode-user-hdfs-secondarynamenode-user-not-defined
export HDFS_NAMENODE_USER="root"
export HDFS_DATANODE_USER="root"
export HDFS_SECONDARYNAMENODE_USER="root"
export YARN_RESOURCEMANAGER_USER="root"
export YARN_NODEMANAGER_USER="root"

### NB: DO NOT USE PDSH
### apt remove pdsh --yes
## https://stackoverflow.com/questions/48189954/hadoop-start-dfs-sh-connection-refused
## https://unix.stackexchange.com/questions/76722/pdsh-command-failed-with-connection-refused/77112#77112
## DO NOT USE: ##export PDSH_RCMD_TYPE=ssh


## https://stackoverflow.com/questions/21533725/hadoop-2-2-0-fails-running-start-dfs-sh-with-error-java-home-is-not-set-and-cou

sbin/start-dfs.sh

############        add JAVA_HOME in etc/hadoop/hadoop-env.sh file


## 3. Browse the web interface for the NameNode; by default it is available at:
## NameNode - http://localhost:9870/
## /usr/bin/firefox http://localhost:9870/ &

## 4. Make the HDFS directories required to execute MapReduce jobs:
bin/hdfs dfs -mkdir /user
## bin/hdfs dfs -mkdir /user/<username>
## change root to correct username
bin/hdfs dfs -mkdir /user/root

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


### Hadoop Home and bin
## https://www.tutorialspoint.com/hadoop/hadoop_enviornment_setup.htm

export HADOOP_HOME=/home/student/Hadoop-et-al/hadoop-3.1.2
export HADOOP_MAPRED_HOME=$HADOOP_HOME 
export HADOOP_COMMON_HOME=$HADOOP_HOME 

export HADOOP_HDFS_HOME=$HADOOP_HOME 
export YARN_HOME=$HADOOP_HOME 
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native 
export HADOOP_INSTALL=$HADOOP_HOME 

export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib"

export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin 


### Apache Hive

## https://www.edureka.co/blog/apache-hive-installation-on-ubuntu

cd ../
cd ./apache-hive-3.1.1-bin

# Set HIVE_HOME
export HIVE_HOME=/home/student/Hadoop-et-al/apache-hive-3.1.1-bin
export PATH=$PATH:/home/student/Hadoop-et-al/apache-hive-3.1.1-bin/bin

## Step 4: Check hive version.
hive --version

## Step 5:  Create Hive directories within HDFS. The directory ‘warehouse’ is the location to store the table or data related to hive.
hdfs dfs -mkdir -p /user/hive/warehouse
hdfs dfs -mkdir /tmp

## Step 6: Set read/write permissions for table.
hdfs dfs -chmod g+w /user/hive/warehouse
hdfs dfs -chmod g+w /tmp


## Step 7:  Set Hadoop path in hive-env.sh
##cd apache-hive-2.1.0-bin/
### 
### export HADOOP_HOME=/home/student/Hadoop-et-al/hadoop-3.1.2
### export HADOOP_HEAPSIZE=512
### 
### export HIVE_CONF_DIR=/home/student/Hadoop-et-al/apache-hive-3.1.1-bin/conf


cp conf/hive-env.sh.template conf/hive-env.sh
## chmod 755 conf/hive-env.sh
echo export HADOOP_HOME=/home/student/Hadoop-et-al/hadoop-3.1.2 >> conf/hive-env.sh
echo export HADOOP_HEAPSIZE=512 >> conf/hive-env.sh
echo export HIVE_CONF_DIR=/home/student/Hadoop-et-al/apache-hive-3.1.1-bin/conf >> conf/hive-env.sh



## Step 8: Edit hive-site.xml
## Command: gedit conf/hive-site.xml
wget -c https://raw.githubusercontent.com/nseegobin/linux-scripts/master/hive-site.xml
mv hive-site.xml conf/hive-site.xml

## Step 9: By default, Hive uses Derby database. Initialize Derby database.

bin/schematool -initSchema -dbType derby


## Step 10: Launch Hive.
hive


## Step 11: Run few queries in Hive shell.
show databases;
create table employee (id string, name string, dept string) row format delimited fields terminated by ‘\t’ stored as textfile;
show tables;

## Step 12: To exit from Hive:
exit;









