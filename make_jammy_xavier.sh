#!/bin/bash
#
#This script will create a ubuntu 22.04 "jammy" rootfs for the Nvidia Jetson AGX Xavier.
#It uses the nvidia samplefs scripts from l4t 36.4.3 to create the jammy rootfs then extracts the rootfs into your specified
#rootfs directory. (Should be something like Linux_for_Tegra/rootfs, the script will ask for your specific path)
#
#

printf "%s" "This script requires root privilages to run the nv_build_samplefs script and will prompt for it"
printf "\n%s\n" "What version of the base system would you like?"
printf "\n%s\n" "Options are: basic, desktop and minimal"
read systemver
printf "\n%s\n" "Version chosen is: $systemver"


pushd ./samplefs > /dev/null 2>&1 #change to working directory of nvidia scripts
currentdir=$(pwd) #sanity check
echo "$currentdir"

#run nvidia script with selected options
sudo bash nv_build_samplefs.sh --abi aarch64 --distro ubuntu --flavor $systemver --version jammy

sleep 5

printf "\n%s\n" "nv_build_samplefs script finished, would you like to extract the new rootfs tarball?"

read -p "(Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
printf "\n%s\n" "Enter path to your Linux_for_Tegra/rootfs/ directory"
read pathtol4t
sudo tar xpvf sample_fs.tbz2 -C $pathtol4t  

popd > /dev/null

