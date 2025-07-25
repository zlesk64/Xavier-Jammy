#!/bin/bash
#
#Cleanup after exiting chroot and unmounting sys proc and dev
#

echo "enter complete path to rootfs"
read rootfsdir
pushd "$rootfsdir" > /dev/null 2>&1

#sanity check
currentdir=$(pwd)
echo "$currentdir"

sudo umount ./sys
sudo umount ./proc
sudo umount ./dev/pts
sudo umount ./dev

popd > /dev/null
echo "all done!"
