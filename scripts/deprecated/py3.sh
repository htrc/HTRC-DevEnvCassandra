#!/usr/bin/env bash

cd /devenv_downloads
tar xzvf Python-3.5.3.tgz
cd Python-3.5.3
./configure
make
sudo make install
cd /devenv_downloads
# install python3 pip and setuptools
sudo /usr/local/bin/python3 /devenv_downloads/get-pip.py

sudo /usr/local/bin/python3 -m pip install cassandra-driver

