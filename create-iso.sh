#!/bin/bash

# Check for wget
if [ ! command -v wget &> /dev/null ]; then
  echo "wget could not be found, please install wget to proceed"
  exit
fi

# Check for podman
if [ ! command -v podman &> /dev/null ]; then
  echo "podman could not be found, please install podman to proceed"
  exit
fi

echo "===== Generating ignition file..."
export BASE64_ENC_SCRIPT=$(sed 's|#!/bin/donnotrun|#!/bin/bash|' danger_wiper.sh | base64)
envsubst < danger_wiper.ign.tpl > danger_wiper.ign

if [ ! -f rhcos-live.x86_64.iso ]; then
  echo "===== Downloading latest live RHCOS ISO..."
  wget -q --show-progress https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.18/latest/rhcos-live.x86_64.iso
else
  echo "===== RHCOS ISO already exists, skipping download..."
fi

echo "===== Creating new bootable RHCOS ISO..."
rm -fv danger_wiper.iso
podman run --rm --tty --interactive --volume ${PWD}:/data:z --workdir /data \
  quay.io/coreos/coreos-installer:release iso customize \
  ./rhcos-live.x86_64.iso --live-ignition ./danger_wiper.ign --output danger_wiper.iso