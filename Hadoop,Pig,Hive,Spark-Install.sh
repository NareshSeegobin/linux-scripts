#!/bin/bash

## Program Name:	Download and install Hadoop, Pig, Hive and Spark
## Compiled by Naresh Seegobin naresh.seegobin@gmail.com
## Version History:
## 20190207 1444 - Initial version
## 20190208 0840 - added https://hadoop.apache.org/


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


## https://wiki.apache.org/hadoop/HadoopJavaVersions
## https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-ubuntu-18-04
## https://linuxconfig.org/how-to-install-java-on-ubuntu-18-04-bionic-beaver-linux

add-apt-repository ppa:webupd8team/java --yes
apt update --yes

## https://askubuntu.com/questions/190582/installing-java-automatically-with-silent-option

echo debconf shared/accepted-oracle-license-v1-1 select true | \
sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | \
sudo debconf-set-selections

## https://linuxconfig.org/how-to-install-java-on-ubuntu-18-04-bionic-beaver-linux
apt install oracle-java8-set-default --yes








