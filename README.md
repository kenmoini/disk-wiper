# DANGER: Wiper ISO

The purpose of this ISO is to ensure existing disk partitions and filesystems are removed to ensure that a new OpenShift/ODF installation won't find any trace of old installs. Only strictly necessary to use this on recycled hardware or when installing over an existing cluster (eg for testing).

Using a bootable ISO to do this automatically is dangerous, but avoids the need to put IP addresses on machines simply to wipe the disks etc.

> **Warning**
>  Obviously, this script and the resulting ISO will cause data loss. Do not boot this or run this on any server you don't intend to wipe. Does NOT do secure erasure of data.

> **Note**
> If you ever change the contents of `danger_wiper.ign` based on `danger-wiper.sh` then edit line 1 in the script to read `#!/bin/bash` instead of `#!/bin/donnotrun`.

## How to build the ISO

> **Note**
> Always ensure the word "danger" is in the file name of the resulting ISO to help ensure it isn't used by mistake.

1) Download the 4.12 RHCOS ISO from Red Hat:

```bash
cd ./danger-wiper       # Or whether the repo is cloned
wget https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.12/latest/rhcos-live.x86_64.iso
```


2) Use the container image version of coreos-installer to embed the ignition into the ISO (ensure danger_wiper.ign is in the current directory):

```bash
podman run --rm --tty --interactive --volume ${PWD}:/data:z --workdir /data quay.io/coreos/coreos-installer:release iso customize \
  ./rhcos-live.x86_64.iso --live-ignition ./danger_wiper.ign --output danger_wiper.iso
```

3) Only ever boot the ISO on a machine you want to wipe!
