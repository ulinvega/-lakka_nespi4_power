#!/bin/bash

# Step 1) Check if root ####################################
if [[ $EUID -ne 0 ]]; then
   echo "Please execute script as root." 
   exit 1
fi

#-----------------------------------------------------------

# Step 2) Go to the right folder ###########################
cd /storage/

#-----------------------------------------------------------

#Step 3) Download this repository with all files needed ----

wget "https://github.com/marcelonovaes/lakka_nespi_power/archive/master.zip"

#-----------------------------------------------------------

#Step 4) Unpack files --------------------------------------

unzip -o master.zip
cd lakka_nespi_power-master/
cp -R lib/ /storage/
mkdir -p /storage/scripts
cp -R scripts/* /storage/scripts/


if [ ! -f /storage/.config/autostart.sh ]; then
    echo "python /storage/scripts/shutdown.py &" >> /storage/.config/autostart.sh
fi

if grep -Fxq "shutdown.py" /storage/.config/autostart.sh 
then
	echo "not found"
    echo "python /storage/scripts/shutdown.py &" >> /storage/.config/autostart.sh
else
    echo "SUCCESS! Shutdown Script configured!"
	echo "Installation done. Will now reboot after 3 seconds."
	sleep 3
	reboot
fi
