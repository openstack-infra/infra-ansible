# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

  # vagrant box to sanity check setup_env.sh
  config.vm.define :trusty64, autostart: false do |trusty|
    trusty.vm.box = "ubuntu/trusty64"
    trusty.vm.provision "shell", :inline => "apt-get update -y"
    trusty.vm.provision "shell", :inline => "cd /vagrant ; ./setup_env.sh"
  end

  # vagrant box to sanity check setup_env.sh
  config.vm.define :centos7, autostart: false do |centos|
    centos.vm.box = "centos/7"
    centos.vm.provision "shell", :inline => "cd /home/vagrant/sync ; ./setup_env.sh"
  end
end
