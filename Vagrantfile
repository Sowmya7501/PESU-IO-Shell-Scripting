# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "centos7"
  config.vm.define "test1" do |test1|
    test1.vm.network "private_network", ip: "10.9.8.5"
  end

  config.vm.define "test2" do |test2|
    test2.vm.network "private_network", ip: "10.9.8.6"
  end
  # SHELL
end
