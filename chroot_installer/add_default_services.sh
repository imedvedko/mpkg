#!/bin/sh
SYS_SERVICE_LIST="sysfs udev"
DEF_SERVICE_LIST="consolefont \
	hald \
	dbus \
	sshd \
	alsasound \
	acpid \
	cupsd \
	cron \
	gdm \
	kdm \
	networkmanager"

for i in $SYS_SERVICE_LIST ; do
	chroot $NODE rc-update add $i sysinit
done

for i in $DEF_SERVICE_LIST ; do
	chroot $NODE rc-update add $i default
done

