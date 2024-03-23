#!/bin/bash
#CHRISTIAN SOSA SCRIPT
echo -n APLICANDO REGLAS...




##[] [STEP 1] - edit /etc/netplan/01-network-manager-all.yaml and add/replace entries below

## ENTRY 1 START

# /etc/netplan/01-network-manager-all.yaml
# Let NetworkManager manage all devices on this system
# network:
  # version: 2
  # renderer: NetworkManager

#  20240323 - Added by Naresh Seegobin for General use
  # ethernets:
      # wlp1s0:
        # dhcp4: yes
      # enx00e04c6804f9:
        # dhcp4: yes
          

## ENTRY 1 END

## ENTRY 2 START - SWAP AS REQURED
#  20231004 - Added by Naresh Seegobin for UWI INEGI
  # ethernets:
      # wlp1s0:
        # dhcp4: yes
      # enx00e04c6804f9:
        # addresses:
          # - 10.217.105.1/24

## ENTRY 2 END - SWAP AS REQURED





##[] [STEP 2] - execute command below

# netplan apply





##[] [STEP 3] - edit /etc/sysctl.conf and add entry below

# /etc/sysctl.conf
# net.ipv4.ip_forward=1





##[] [STEP 4] - execute command below

# sysctl -p





##[] [STEP 5] - execute command below

# apt install iptables-persistent




##[] [STEP 6] - START BLOCK - execute command in the block below

# INTERFACES
##EXTERNA="enp0s3"
##INTERNA="enp0s8"

EXTERNA="wlp1s0"
## Change Internal depending on your NIC adapter
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
## AND Allow DNS, see https://www.linuxquestions.org/questions/linux-security-4/iptables-dns-not-working-4175673577/
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


##[] [STEP 6] - END BLOCK - execute command in the block above







##[] [STEP 7] - execute command in the block below, remove comments

#### sudo su
#### sudo iptables-save > /etc/iptables/rules.v4

sudo cat /etc/iptables/rules.v4





##[] [STEP 8] - END - References

### Reference links


## https://www.networkreverse.com/2020/06/how-to-build-linux-router-with-ubuntu.html
## https://www.linuxquestions.org/questions/linux-security-4/iptables-dns-not-working-4175673577/














