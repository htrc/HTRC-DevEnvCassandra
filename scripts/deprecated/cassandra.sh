#!/usr/bin/env bash

# setup cassandra repo
sudo cp /devenv_configurations/datastax.repo /etc/yum.repos.d/datastax.repo

# install cassandra
sudo yum -y install dsc20
# set cassandra runlevels
sudo chkconfig --add cassandra
sudo chkconfig --levels 2345 cassandra on

# start up cassandra
sudo service cassandra start
sudo service cassandra status
