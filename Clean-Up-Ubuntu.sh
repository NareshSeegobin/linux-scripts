#!/bin/bash

## Compiled by Naresh Seegobin naresh.seegobin@gmail.com
## Version History:
## 20190207 1444 - Initial version
## 20190208 0840 - added https://www.osboxes.org/ubuntu/

## https://www.osboxes.org/ubuntu/

## Cleanup Unbuntu

## https://www.techradar.com/how-to/how-to-speed-up-ubuntu-1804

## https://www.omgubuntu.co.uk/2016/08/5-ways-free-up-space-on-ubuntu

sudo su

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

