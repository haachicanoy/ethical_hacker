#!/bin/bash

# Const
suffix="mon"

# Select the interface
echo "Type the interface name"
echo 
i=1
for item in `ls /sys/class/net`
do
	echo "$i) $item"
	i=$(($i+1))
done
echo 
read interface

# Custom mac
mac="00:11:22:33:44:55"
custom=
while [ "$custom" != "y" ] && [ "$custom" != "n" ]
do
	echo
	echo "Do you want a custom address? y/n"
	read custom
done
if  [ "$custom" = "y" ]
then
	echo "Type a custom mac address. e.g: $mac"
	read mac
fi

# Changing the mac address
`ifconfig $interface down`
`macchanger -m $mac $interface`
`ifconfig $interface up`
`macchanger -s $interface`

# Monitoring
`airmon-ng start $interface$suffix`


