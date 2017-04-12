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
CASS_SRC      = "HTRC-DevEnvCassandra"
CASS_REPO     = "https://jimlambrt@github.com/htrc/HTRC-DevEnvCassandra.git"

PY3_URL       = 'https://www.python.org/ftp/python/3.5.3/Python-3.5.3.tgz'
PIP_URL       = 'https://bootstrap.pypa.io/get-pip.py'

PRIVATE_IP    = '192.168.100.102'

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  config.vm.box_check_update = false

  
  ## make Cassandra available from the host OS on the standard client ports
  config.vm.network "forwarded_port", guest: 9042, host: 9160
  config.vm.network "forwarded_port", guest: 9160, host: 9160


  config.vm.network "private_network", ip: PRIVATE_IP
  config.vm.hostname = "devenv-cass"
  config.hostsupdater.aliases = ["devenv-cassandra"]

  config.vm.synced_folder SCRIPTS_DIR, "/devenv_scripts"
  config.vm.synced_folder RESOURCE_DIR, "/devenv_sources"
  config.vm.synced_folder "configurations", "/devenv_configurations"
  config.vm.synced_folder "certs", "/devenv_certs"
  config.vm.synced_folder "~/#{DOWNLOADS_DIR}", "/devenv_downloads"

  # Download PY3 zip
  download_source(PY3_ZIP, PY3_URL)
  download_source(GET_PIP, PIP_URL)
  resources_dir = File.join(File.dirname(__FILE__), RESOURCE_DIR)
  clone_update_repo(resources_dir, CASS_REPO, CASS_SRC) 
  provision_ansible(config)
  provision_cassandra(config)
end

def provision_ansible(config)
  config.vm.provision "shell", inline: <<-SHELL
    sudo yum -y install openssl-devel
    sudo yum -y install python-setuptools
    sudo yum -y install python-devel
    sudo easy_install pip
    sudo pip install ansible
  SHELL
end

def provision_cassandra(config)
    config.vm.provision "shell", inline: <<-SHELL
      ansible-playbook /devenv_sources/#{CASS_SRC}/scripts/cassandra.yml
  SHELL
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

    
def clone_update_repo(resources_dir, url_repo, source_name)
  unless File.exists?(resources_dir)
    FileUtils.mkdir_p(resources_dir)
  else
    print "#{resources_dir} directory is already there.\n"
  end

  src_dir = File.join(resources_dir, source_name)
  unless File.exists?(src_dir)
    print "Cloning #{source_name}..."
    system "bash", "-c", "pwd"
    git_cmd = <<-SHELL
      git clone #{url_repo};
    SHELL
    system "bash", "-c", "cd #{resources_dir} && #{git_cmd}"

    if $?.exitstatus > 0
        print "Failed to clone: "  + source_name
        exit 1
    end
  else
    system "bash", "-c", "cd #{src_dir} && git pull"
    if $?.exitstatus > 0
      print "Failed to pull updates from source repo: " + url_repo
      exit 1
    end
  end
end
