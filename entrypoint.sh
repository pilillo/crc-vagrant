#!/usr/bin/env bash

set -e
set -o pipefail

sudo gpasswd -a $(whoami) libvirt
sudo gpasswd -a $(whoami) kvm

sudo gpasswd -a root libvirt
sudo gpasswd -a root kvm
sudo chown root:kvm /dev/kvm

# create the bridge for networking
#ip link add name virt0 type bridge
#ip link set dev virt0 up
#bridge link
#ip addr add dev virt0 172.20.0.1/16
#iptables -t nat -A POSTROUTING -s 172.20.0.1/16 -j MASQUERADE

#function systemctl {
#  service $2 $1
#  case $1 in
#    start|stop)
#    service $2 $1
#    ;;
#    *)
#    # noop
#    echo $@
#    ;;
#  esac
#}

sudo systemctl start libvirtd
sudo systemctl start virtlogd
# WARN No active (running) libvirtd systemd unit could be found - make sure one of libvirt systemd units is enabled so that it's autostarted at boot time.
#sudo service libvirtd start
#sudo service virtlogd start

#exec virtlogd --daemon &
#exec libvirtd --daemon &

crc_folder=$(ls -d crc*-amd64 | tail -n 1 | xargs realpath)
alias crc="${crc_folder}/crc"

crc config set consent-telemetry no
crc setup
