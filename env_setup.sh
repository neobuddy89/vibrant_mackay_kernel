#!/bin/bash

# location
if [ "${1}" != "" ]; then
	export KERNELDIR=`readlink -f ${1}`;
else
	export KERNELDIR=`readlink -f .`;
fi;

export PARENT_DIR=`readlink -f ${KERNELDIR}/..`;
export INITRAMFS_SOURCE=`readlink -f ${KERNELDIR}/../Mackay-initramfs`;
export INITRAMFS_TMP=${KERNELDIR}/tmp/initramfs_source;

rm source;
ln -s ${KERNELDIR} source;

# check if parallel installed, if not install
if [ ! -e /usr/bin/parallel ]; then
	echo "You must install 'parallel' by this script to continue.";
	sudo dpkg -i ${KERNELDIR}/utilities/parallel_20120422-1_all.deb
fi

# kernel
export ARCH=arm;
export USE_SEC_FIPS_MODE=true;
export KERNEL_CONFIG="mackay_vibrantmtd_defconfig";

# build script
export USER=`whoami`
export TMPFILE=`mktemp -t`;

# system compiler
# export CROSS_COMPILE=$PARENT_DIR/arm-cortex_a8-linux-gnueabi-linaro_4.8.2-2013.10/bin/arm-cortex_a8-linux-gnueabi-;
export CROSS_COMPILE=$PARENT_DIR/linaro-toolchain-4.8-2013.10/bin/arm-eabi-;

export NUMBEROFCPUS=`grep 'processor' /proc/cpuinfo | wc -l`;

# Colorize and add text parameters
export red=$(tput setaf 1)             #  red
export grn=$(tput setaf 2)             #  green
export blu=$(tput setaf 4)             #  blue
export cya=$(tput setaf 6)             #  cyan
export txtbld=$(tput bold)             # Bold
export bldred=${txtbld}$(tput setaf 1) #  red
export bldgrn=${txtbld}$(tput setaf 2) #  green
export bldblu=${txtbld}$(tput setaf 4) #  blue
export bldcya=${txtbld}$(tput setaf 6) #  cyan
export txtrst=$(tput sgr0)             # Reset

