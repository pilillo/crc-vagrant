# crc-vagrant

This provides a disposable vagrant environment running a code-ready-container Openshift distro.

## Vagrant Setup

You can install Vagrant using your OS package manager or by downloading a suitable version at [this](https://www.vagrantup.com/downloads) page.
I unzipped it to /opt/vagrant-latest and created a symbolic link from /usr/bin/vagrant-latest.

Most Vagrant installations rely on virtualbox as default virtualization manager, which however does not support nested virtualization.
Please read [here](https://ostechnix.com/how-to-use-vagrant-with-libvirt-kvm-provider/) on how to run libvirt and kvm.
You need to install libvirt, KVM and the vagrant-libvirt plugin:

```
vagrant-latest plugin install vagrant-kvm
vagrant-latest plugin install vagrant-libvirt
```
However, vagrant version 2.2.14 suffers [this bug](https://github.com/hashicorp/vagrant/issues/12202) with libvirt and kvm, so make sure to run the latest version.

You can then run:

```
vagrant-latest up --provider=libvirt
```

or directly set it as default:

```
export VAGRANT_DEFAULT_PROVIDER=libvirt
vagrant-latest up
```

And directly verify you are using kvm, with:
```
virsh list
```

You can also install [vagrant-mutate](https://github.com/sciurus/vagrant-mutate) to convert vagrant boxes across different providers:
```
vagrant-latest plugin install vagrant-mutate
```

To solve the following error:
```
ip6tables v1.8.7 (legacy): can't initialize ip6tables table `filter': Table does not exist (do you need to insmod?)
Perhaps ip6tables or your kernel needs to be upgraded.
```

I checked [iptables](https://wiki.archlinux.org/index.php/Iptables) was installed and made sure ip6tables was enabled and started:
```
systemctl enable ip6tables
systemctl start ip6tables
journalctl -xeu ip6tables.service
```

## Vagrant Quickstart

Create an ssh key to use to connect to the nodes:  
``ssh-keygen -t rsa -b 4096 -f key -N ""``
The key is automatically loaded by the provisioner, and added to `~/.ssh/authorized_keys`.

To start the node:  
``vagrant up``
``vagrant up <host-name>``

To show the status:  
``vagrant global-status``

To run the provision on running nodes:  
``vagrant provision``

To run the provision on a stopped machine:  
``vagrant up --provision``

To reboot a machine and run the provisioner:  
``vagrant reload --provision``  

To ssh on a node:  
``vagrant ssh <node-name>``

To stop the nodes:  
``vagrant halt``

To destroy the node:  
``vagrant destroy``
