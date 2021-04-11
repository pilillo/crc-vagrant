#!/usr/bin/env bash

# wget and untar crc bin
wget https://mirror.openshift.com/pub/openshift-v4/clients/crc/latest/crc-linux-amd64.tar.xz
tar -xf crc-linux-amd64.tar.xz
# rm crc bin
rm ~/crc-linux-amd64.tax.xz

# get crc bin location
export crc=$(ls ~/crc*-amd64/crc)

$crc config set consent-telemetry no
$crc setup
