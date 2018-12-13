#!/bin/sh
start=`pwd`
gpointing-device-settings
firefox http://w3.ibm.com
system-config-date
/opt/ibm/c4eb/sabayon/sabayon-switch.py
/usr/lib/ibm-additional-repositories/ibm-additional-repositories enable
/usr/lib/ibm-additional-repositories-ea/ibm-additional-repositories-ea enable
cp Linuxstuff.zip ~/Downloads
cd ~/Downloads
unzip Linuxstuff.zip
cp ca.pem ~
echo 'Intradiem'
cd /opt
echo password1 | sudo -S  tar xvzf ~/Downloads/intradiemclient.tgz
cd intradiemclient
echo 'Enter 1'
./configureIntradiemClient.sh
echo 'Replace “$USER” with your full Intradiem ID'
echo password1 | sudo -S  gedit runintradiemclient.sh
cd ~
/usr/lib/ibm-additional-repositories-ea/ibm-additional-repositories-ea enable
echo password1 | sudo -S  yum -y update
echo password1 | sudo -S  yum -y update
echo password1 | sudo -S  yum -y install ibm-config-toxsocks
echo password1 | sudo -S  yum -y install shutter
echo password1 | sudo -S  yum -y install oorexx
echo password1 | sudo -S  yum -y install kdeadmin
echo password1 | sudo -S  yum -y install parcellite
echo password1 | sudo -S  yum -y install fluendo-dvd
echo password1 | sudo -S  yum -y install oneplay-gstreamer-codecs-pack -y
echo password1 | sudo -S  yum -y install schroedinger
echo password1 | sudo -S  yum -y install seamonkey
echo password1 | sudo -S  yum -y install keepassx
echo password1 | sudo -S  yum -y install xclip
echo password1 | sudo -S  yum -y install samba-client
echo password1 | sudo -S  yum -y install lrzip
echo password1 | sudo -S  yum -y install telnet
echo password1 | sudo -S  yum -y install ibm-config-firejail
echo password1 | sudo -S  yum -y install lock-keys-applet
echo password1 | sudo -S  yum -y update
echo password1 | sudo -S  yum -y update
cd ~/Downloads
echo password1 | sudo -S  cp addtrustexternalcaroot.crt /opt/Citrix/ICAClient/keystore/cacerts
echo 'Claim Assistant'
cd ~
unzip "Downloads/IBM Claim Assistant 2.0 Linux.zip"
cd "IBM Claim Assistant 2.0 Linux"
./ICA_Installer
cd ~/Downloads
echo password1 | sudo -S  cp inventory.sh /usr/bin
echo password1 | sudo -S  chmod 755 /usr/bin/inventory.sh
echo password1 | sudo -S  cat /etc/anacrontab > cronhold.txt
echo password1 | sudo -S  cat cron.txt >> cronhold.txt
echo password1 | sudo -S  mv cronhold.txt /etc/anacrontab
cd ~/Downloads
echo "-Djava.net.preferIPv4Stack=true"
ControlPanel
rm *
cd "$start"
cp restore.sh ~/
`/usr/lib/openclient-welcome-center/launch /usr/bin/python /usr/lib/openclient-welcome-center/get-windows-wizard.py WIN7`
echo password1 | sudo -S cp images/MWSD* /var/lib/libvirt/images
rm $HOME/.firstlogin
echo "finished"
sleep 20
