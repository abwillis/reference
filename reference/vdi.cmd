@echo off
: OCT292010 - v1.0 - updated user ID and password for the AG domain
: NOV102010 - v1.1 - corrected comment delimiter
: NOV102010 - v1.2 - changed install from server to copy to local and install
c:
net use q: \\9.17.50.72\SBDBackup /user:sbdbackupuser Welcome2IBM /persistent:no >nul
@echo Installing VDI_Blaster
@echo Do not close window, you will be prompted when installation is complete.
c:
cd \
attrib -s -h -r boot.ini
IF NOT EXIST boot.ini.orig copy boot.ini boot.ini.orig
IF NOT EXIST c:\casper\filesystem.squashfs call copy q:\datastore-capped\vdi\vdiblaster-701-20100430-winstaller.exe c:\temp
IF NOT EXIST c:\casper\filesystem.squashfs call c:\temp\vdiblaster-701-20100430-winstaller /S
copy q:\datastore-capped\VDI\filesystem.squashfs c:\casper
attrib -s -h -r boot.ini
IF NOT EXIST boot.ini.vdi copy boot.ini boot.ini.vdi
copy boot.ini.orig boot.ini
attrib +s +h +r boot.ini
cd %userprofile%\desktop\
echo cd \ > VDI-ready.cmd
echo attrib -s -h -r boot.ini >> VDI-ready.cmd
echo copy boot.ini.vdi boot.ini >> VDI-ready.cmd
echo attrib +s +h +r boot.ini >> VDI-ready.cmd
echo cd \ > VDI-done.cmd
echo attrib -s -h -r boot.ini >> VDI-done.cmd
echo copy boot.ini.orig boot.ini >> VDI-done.cmd
echo attrib +s +h +r boot.ini >> VDI-done.cmd
net use q: /delete
@echo VDI-ready.cmd on the Desktop will be used to set the virtual image as default once pilot has commenced.
@echo VDI-done.cmd on the Desktop will turn off using the virtual image when pilot is complete.
Pause
@echo VDI_Blaster install complete
