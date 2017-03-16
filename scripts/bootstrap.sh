#!/usr/bin/env bash

# take the hit and update all.
sudo yum -y update 

sudo yum -y install java
sudo yum -y install emacs
sudo yum -y install git

# python 2
sudo yum -y install python-setuptools
sudo yum -y install python-devel
sudo easy_install pip

# python3 /usr/local/bin/python3
sudo yum install yum-utils
sudo yum -y install wget
sudo yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel
wget --no-clobber  "https://www.python.org/ftp/python/3.5.3/Python-3.5.3.tgz"
tar xzvf Python-3.5.3.tgz
cd Python-3.5.3
./configure
make
sudo make install
cd
# install python3 pip and setuptools
wget --no-clobber "https://bootstrap.pypa.io/get-pip.py" 
sudo /usr/local/bin/python3 get-pip.py


sudo yum -y install mlocate
sudo updatedb

# setup cassandra repo
cat <<EOF > /etc/yum.repos.d/datastax.repo
[datastax]
name = DataStax Repo for Apache Cassandra
baseurl = http://rpm.datastax.com/community
enabled = 1
gpgcheck = 0

EOF

# install cassandra
yum -y install dsc20
# set cassandra runlevels
sudo chkconfig --add cassandra
sudo chkconfig --levels 2345 cassandra on


# Cassandra python driver
sudo pip install cassandra-driver
sudo /usr/local/bin/python3 -m pip install cassandra-driver

# start up cassandra
sudo service cassandra start
sudo service cassandra status
