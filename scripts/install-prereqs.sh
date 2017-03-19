#!/bin/sh -eux


#!/usr/bin/env bash

# take the hit and update all.
sudo yum -y update 

sudo yum -y install java
sudo yum -y install emacs
sudo yum -y install git

# python3 /usr/local/bin/python3
sudo yum install yum-utils
sudo yum -y install wget


sudo yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel

sudo yum -y install mlocate
sudo updatedb


