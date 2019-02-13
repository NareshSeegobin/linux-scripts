#!/bin/bash

## Compiled by Naresh Seegobin naresh.seegobin@gmail.com
## Version History:
## 20190207 1444 - Initial version
## 20190208 0840 - added https://www.osboxes.org/ubuntu/
## 20190213 1033 - Re-arranged order of scripts. Simple applications first, Java, Python, PIP, modules





## =====================================================================================
## ==================================== RUN FROM HERE ==================================

sudo su


## https://hadoop.apache.org/docs/r3.1.2/hadoop-project-dist/hadoop-common/SingleCluster.html
apt install openssh-server --yes


## https://www.dezyre.com/apache-spark-tutorial/spark-tutorial
apt install scala --yes


apt install p7zip rar unrar filezilla --yes
apt install python --yes
apt install python-pip --yes
apt install python3-pip --yes


## https://linuxconfig.org/how-to-install-java-on-ubuntu-18-04-bionic-beaver-linux
add-apt-repository ppa:webupd8team/java
apt update --yes

## https://askubuntu.com/questions/190582/installing-java-automatically-with-silent-option
echo debconf shared/accepted-oracle-license-v1-1 select true | \
sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | \
sudo debconf-set-selections

apt install oracle-java8-set-default --yes


exit
sudo -H pip install bokeh -v
sudo -H pip3 install bokeh -v
sudo -H pip install pandas -v
sudo -H pip3 install pandas -v




## ===============================================================================================================================






## https://www.osboxes.org/ubuntu/

## Cleanup Unbuntu

## https://www.techradar.com/how-to/how-to-speed-up-ubuntu-1804

## https://www.omgubuntu.co.uk/2016/08/5-ways-free-up-space-on-ubuntu

sudo su


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



## https://hadoop.apache.org/docs/r3.1.2/hadoop-project-dist/hadoop-common/SingleCluster.html
apt install openssh-server --yes

### NB: DO NOT USE PDSH
### apt remove pdsh --yes
## https://stackoverflow.com/questions/48189954/hadoop-start-dfs-sh-connection-refused
## https://unix.stackexchange.com/questions/76722/pdsh-command-failed-with-connection-refused/77112#77112
## DO NOT USE: ##export PDSH_RCMD_TYPE=ssh
## apt-get install pdsh --yes













## https://www.rosehosting.com/blog/list-all-installed-packages-with-apt-on-ubuntu/
apt list --installed

apt-get update --yes
apt-get upgrade --yes



apt-get autoremove --purge
apt-get clean all --yes
apt-get autoclean all --yes
apt-get autoremove --purge --yes


## https://help.ubuntu.com/community/Diet%20Ubuntu
apt-get remove --purge --yes mono-common, ttf-arabeyes ttf-arphic-uming ttf-indic-fonts-core ttf-kochi-gothic ttf-kochi-mincho ttf-lao ttf-malayalam-fonts ttf-thai-tlwg ttf-unfonts-core bluez-audio bluez-cups bluez-gnome bluez-utils ppp pppconfig pppoeconf wvdial gnome-orca brltty brltty-x11 gnome-accessibility-themes gnome-mag libgnome-mag2 libgtk-vnc-1.0-0 vinagre vino espeak espeak-data libespeak1 libgnome-speech7 evolution-common evolution-data-server evolution-exchange evolution-plugins evolution-webcal fortune-mod libbeagle1 contact-lookup-applet gnome-games gnome-games-data gnome-cards-data totem totem-gstreamer totem-plugins totem-common totem-mozilla rhythmbox transmission-common transmission-gtk openoffice.org-calc openoffice.org-draw openoffice.org-impress openoffice.org-writer openoffice.org-base-core

apt-get autoremove --purge
apt-get clean all
apt-get autoclean all
apt-get autoremove --purge

## apt-get install gtkorphan

apt-get install p7zip rar unrar filezilla --yes

apt-get update --yes












