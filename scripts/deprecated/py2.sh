#!/usr/bin/env bash
# python 2
sudo yum -y install python-setuptools
sudo yum -y install python-devel
sudo easy_install pip

# Cassandra python driver
sudo pip install cassandra-driver
