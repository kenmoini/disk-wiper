# DANGER: Wiper ISO

The purpose of this ISO is to ensure existing disk partitions and filesystems are removed to ensure that a new OpenShift/ODF installation won't find any trace of old installs. Only strictly necessary to use this on recycled hardware or when installing over an existing cluster (eg for testing).

Using a bootable ISO to do this automatically is dangerous, but avoids the need to put IP addresses on machines simply to wipe the disks etc.

> **Warning**
>  Obviously, this script and the resulting ISO will cause data loss. Do not boot this or run this on any server you don't intend to wipe. Does NOT do secure erasure of data.

> **Note**
> If you ever change the contents of `danger_wiper.ign` based on `danger-wiper.sh` then edit line 1 in the script to read `#!/bin/bash` instead of `#!/bin/donnotrun`.  The `create-iso.sh` script does this for you.

## How to build the ISO

```bash
./create-iso.sh
```

Then boot systems that you want to wipe drives - maybe via something like [Ansible to boot server via Redfish](https://github.com/kenmoini/ansible-redfish).