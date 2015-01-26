#!/usr/bin/expect

set timeout 20

## connect
spawn telnet 192.168.0.102

## loging
expect "AMP12 login:"
send -- "root\r"
expect "Enter 'help' for a list of built-in commands."

## find lost disk
send -- "rmmod ehci_hcd\r"
sleep 120

## check that the disk appeared
send -- "mount\r"
expect "/dev/scsi/host2/bus0/target0/lun0/part2 on /tmp/usbmounts/sda2 type ext3 (ro,recovery)" 

## remount as RW disk
send -- "umount /tmp/usbmounts/sda2\r"
send -- "mount -t ext3 /dev/scsi/host2/bus0/target0/lun0/part2 /tmp/usbmounts/sda2\r"

## verify mounting as RW
send -- "mount\r"
expect "/dev/scsi/host2/bus0/target0/lun0/part2 on /tmp/usbmounts/sda2 type ext3 (ro,recovery)"

interact
