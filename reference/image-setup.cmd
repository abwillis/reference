:: get ready for image
@echo off
echo Windows Registry Editor Version 5.00>setreg.reg
echo:>>setreg.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce]>>setreg.reg
echo "setcompname"="c:\\accounts\\base\\isetup.cmd">>setreg.reg
echo:>>setreg.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\IGS\ISSI\ISSI Installer]>>setreg.reg
echo "usernameenc"=->>setreg.reg
regedit /s setreg.reg
del setreg.reg