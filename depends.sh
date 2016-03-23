#!/bin/bash
# ====================================================
#               Debian TF2 Dependencies
# ====================================================
# By: Cameron Munroe ~ Mun
# Purpose: Install the dependencies needed to run TF2
# 		   and now DST as well!
# 
#
# Version 1.2


dpkg --add-architecture i386

apt-get update
apt-get upgrade -y

apt-get install screen -y
apt-get install lib32gcc1 -y
apt-get install lib32z1 -y
apt-get install zlib1g -y
apt-get install lib32tinfo5 -y

# Added for support with DST
apt-get install libcurl4-gnutls-dev:i386 -y
apt-get install lib32stdc++6 -y

# Added for support for certain DST scripts
apt-get install psmisc -y