# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'fileutils'
require 'rest_client'

# DIRS
RESOURCE_DIR  = ".sources"
DOWNLOADS_DIR = ".devenv_downloads"
SCRIPTS_DIR   = "./scripts"
# FILES
PY3_ZIP       = 'Python-3.5.3.tgz'
GET_PIP       = 'get-pip.py'
DATASTAX_REPO = 'datastax.repo'

PY3_URL       = 'https://www.python.org/ftp/python/3.5.3/Python-3.5.3.tgz'
PIP_URL       = 'https://bootstrap.pypa.io/get-pip.py'

PRIVATE_IP    = '192.168.100.100'

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  config.vm.box_check_update = false

  
  ## make Cassandra available from the host OS on the standard client ports
  config.vm.network "forwarded_port", guest: 9042, host: 9160
  config.vm.network "forwarded_port", guest: 9160, host: 9160


  config.vm.network "private_network", ip: PRIVATE_IP
  config.vm.hostname = "devenv-is"
  config.hostsupdater.aliases = ["devenv-cassandra"]

  config.vm.synced_folder SCRIPTS_DIR, "/devenv_scripts"
  config.vm.synced_folder RESOURCE_DIR, "/devenv_sources"
  config.vm.synced_folder "configurations", "/devenv_configurations"
  config.vm.synced_folder "certs", "/devenv_certs"
  config.vm.synced_folder "~/#{DOWNLOADS_DIR}", "/devenv_downloads"

  # Download PY3 zip
  download_source(PY3_ZIP, PY3_URL)
  download_source(GET_PIP, PIP_URL)

  config.vm.provision :shell, :path => "scripts/install-prereqs.sh"
end


def download_source(file_name, url)
  devenv_downloads_dir = File.join(File.expand_path('~'), DOWNLOADS_DIR)
  zip = File.join(devenv_downloads_dir, file_name)
  unless File.exists?(zip)
    print "Downloading #{zip}...\n"
    file = File.open(zip, 'wb' ) do |output|
      output.write RestClient.get("#{url}")
    end
  end
end

    
