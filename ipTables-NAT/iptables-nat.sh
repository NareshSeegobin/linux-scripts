#!/bin/bash
#CHRISTIAN SOSA SCRIPT
echo -n APLICANDO REGLAS...


# /etc/netplan/01-network-manager-all.yaml
# Let NetworkManager manage all devices on this system
# network:
  # version: 2
  # renderer: NetworkManager

#  20231004 - Added by Naresh Seegobin for UWI INEGI
  # ethernets:
      # wlp1s0:
        # dhcp4: yes
      # enx00e04c6804f9:
        # addresses:
          # - 10.217.105.1/24


# netplan apply




# /etc/sysctl.conf
# net.ipv4.ip_forward=1

# sysctl -p



# apt install iptables-persistent



# INTERFACES
##EXTERNA="enp0s3"
##INTERNA="enp0s8"

EXTERNA="wlp1s0"
INTERNA="enx00e04c6804f9"


# ROUTING
echo "1" > /proc/sys/net/ipv4/ip_forward

# DELETE PREVIOUS RULES
iptables -t filter -F
iptables -t nat -F

# DEFAULT POLICY (DROP)
##NS## iptables -P INPUT DROP
##NS## iptables -P OUTPUT DROP
##NS## iptables -P FORWARD DROP

# LOOPBACK
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT



# ALLOW TCP & UDP PROTOCOL & Proxy
iptables -t filter -A FORWARD -i $INTERNA -p udp --dport 53 -j ACCEPT
iptables -t filter -A FORWARD -i $INTERNA -p tcp --dport 53 -j ACCEPT
iptables -t filter -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
##iptables -t filter -A INPUT -i $INTERNA -p tcp --dport 3128 -j ACCEPT
iptables -t filter -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT



# ALLOW NAT
iptables -t nat -A POSTROUTING -o $EXTERNA -j MASQUERADE

# FORCE CLIENTS TO USE THE PROXY
#iptables -t nat -A PREROUTING -i $INTERNA -p tcp -m multiport --dports 80,443 -j REDIRECT --to-port 3128

# SSH (PORT:22555).
iptables -t filter -A INPUT -i $INTERNA -p tcp --dport 22555 -j ACCEPT
iptables -t filter -A OUTPUT -p tcp --sport 22555 -m state --state ESTABLISHED,RELATED -j ACCEPT

# FTP
iptables -t filter -A INPUT -i $INTERNA -p tcp --dport 20:21 -j ACCEPT
iptables -t filter -A OUTPUT -o $INTERNA -p tcp --sport 20 -m state --state ESTABLISHED,RELATED -j ACCEPT

# ICMP
iptables -A FORWARD -p icmp --icmp-type echo-request -j ACCEPT
iptables -t filter -A INPUT -p icmp --icmp-type 8 -j ACCEPT
iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-reply -j ACCEPT
iptables -t filter -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT



echo " "
iptables --list

echo " "
iptables-save


#### sudo su
#### sudo iptables-save > /etc/iptables/rules.v4

sudo cat /etc/iptables/rules.v4

