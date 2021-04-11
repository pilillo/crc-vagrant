VAGRANTFILE_API_VERSION = "2"

# libvirt
PROVIDER="libvirt"
#BOX="peru/ubuntu-20.04-desktop-amd64"
#BOX_VERSION="20210401.01"
BOX="archlinux/archlinux"
BOX_VERSION="20210401.18564"

# virtualbox
#PROVIDER="virtualbox"
#BOX="ubuntu/focal64"
#BOX_VERSION

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # make sure the plugin is installed
  config.vagrant.plugins = "vagrant-libvirt"

  # if false every box shares the same key: https://github.com/hashicorp/vagrant/blob/master/keys/vagrant.pub
  config.ssh.insert_key = true

  config.vm.provider PROVIDER do |v|
    v.driver = "kvm"
    # https://github.com/vagrant-libvirt/vagrant-libvirt#domain-specific-options
    #v.name = "crc"
    v.memory = 12000
    v.cpus = 2
    # enable nested virtualization
    v.nested = true
    #v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    #v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    v.video_type = "virtio"
    # https://github.com/vagrant-libvirt/vagrant-libvirt
    #v.management_network_name = "vagrant-libvirt"
    #v.management_network_address = "192.168.121.0/24"
    #v.management_network_mode="none"
    #v.management_network_autostart=true
  end

  #config.vm.network :forwarded_port, host: 6443, guest: 6443, auto_correct: true
  #config.vm.network :forwarded_port, host: 80, guest: 80, auto_correct: true
  #config.vm.network :forwarded_port, host: 443, guest: 443, auto_correct: true

  config.vm.define "crc" do |node|
    node.vm.box = BOX
    node.vm.box_version = BOX_VERSION
    node.vm.hostname = "crc"
    node.vm.network "private_network",ip: "192.168.50.10"
  end

  config.vm.provision "file", source: "key.pub", destination: "~/.ssh/authorized_keys__"
 
  # install any node dependency needed
  config.vm.provision "shell", path: "bootstrap.sh", privileged: false
end
