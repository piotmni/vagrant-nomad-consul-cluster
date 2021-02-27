# -*- mode: ruby -*-
# vi: set ft=ruby :



Vagrant.require_version ">= 1.6.0"
VAGRANT_API_VERSION = "2"

require 'yaml'

servers = YAML.load_file(File.join(File.dirname(__FILE__), 'cluster.yml'))


Vagrant.configure(VAGRANT_API_VERSION) do |config|

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  servers.each do |servers|
    config.vm.define servers["name"] do |srv|
      srv.vm.hostname = servers["name"]
      srv.vm.box = servers["box"]
      if servers["name"] =~ /haproxy/
        srv.vm.network "private_network", type: "dhcp"
      end  
      srv.vm.network "private_network", ip: servers["ip"],
        virtualbox__intnet: "cluster_network"
      #srv.vm.network "forwarded_port", guest: 4646, host: servers["port"], host_ip: servers["ip"]
      if servers["name"] =~ /server/
        srv.vm.provision :shell, path: "script.sh", args: "server"
      elsif servers["name"] =~ /client/
        srv.vm.provision :shell, path: "script.sh", args: "client"
      end
      srv.vm.provider :virtualbox do |vb|
        vb.name = servers["name"]
        vb.memory = servers["ram"]
      end
    end
  end  
end
