# -*- mode: ruby -*-
# vi: set ft=ruby :

# see https://github.com/dotless-de/vagrant-vbguest/issues/64
require 'vagrant-vbguest' unless defined? VagrantVbguest::Config
class CloudUbuntuVagrant < VagrantVbguest::Installers::Ubuntu
  def install(opts=nil, &block)
    communicate.sudo("apt-get -y -q purge virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11", opts, &block)
    super
  end
end

Vagrant.configure("2") do |config|
  config.vm.box = "ecm"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-i386-vagrant-disk1.box"
  config.vbguest.installer = CloudUbuntuVagrant

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :forwarded_port, guest: 8080, host: 8080

  config.ssh.forward_agent = true

  config.vm.provider :virtualbox do |vb|
  #  # Don't boot with headless mode
  #  vb.gui = true
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # View the documentation for the provider you're using for more
  # information on available options.

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  config.vm.provision :chef_solo do |chef|
    config.berkshelf.enabled = true

    chef.add_recipe "git"
    chef.add_recipe "zsh"
    chef.add_recipe "tmux"
    chef.add_recipe "vim"

    chef.add_recipe "rvm"
    chef.add_recipe "lein"

    chef.add_recipe "node"
    chef.add_recipe "phantomjs"
    chef.add_recipe "ruby"
    chef.add_recipe "python"

    chef.add_recipe "postgres"
    chef.add_recipe "mongodb"
    chef.add_recipe "mysql"
    chef.add_recipe "redis"
    chef.add_recipe "memcached"
    chef.add_recipe "elasticsearch"
    chef.add_recipe "rabbitmq"

    chef.add_recipe "git-config"
    chef.add_recipe "zsh-config"
    chef.add_recipe "tmux-config"
    chef.add_recipe "autoupdate"
  end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision :chef_client do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # If you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
end
