#!/bin/sh
sn=`dmidecode -s system-serial-number`
cd ~/lotus/notes/data
smbclient //grace.boulder.ibm.com/inventory inventorytool -U inventoryagent <<EOC
mkdir $sn
cd $sn
put notes.ini
EOC
cd /var/opt/ibmsam
smbclient //grace.boulder.ibm.com/inventory inventorytool -U inventoryagent <<EOC
cd $sn
put registry.ini
put wamdatal.csv.ini
EOC

