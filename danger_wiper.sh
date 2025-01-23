#!/bin/donnotrun
# Disk wiper script - DANGER: will remove partition table etc from all disks in a system
# NOTE: Does not perform secure data erasure.

for DISK in $(ls /dev/sd[a-z] 2>/dev/null; ls /dev/vd[a-z] 2>/dev/null; ls /dev/nvme[0-9]n[1-9] 2>/dev/null);
do
	echo $DISK
	wipefs -af $DISK
        sleep 1
done

sleep 2

sync

sleep 2
shutdown -h now

