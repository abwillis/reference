:: install inventory script next boot
@echo off
echo Windows Registry Editor Version 5.00>setreg.reg
echo:>>setreg.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run]>>setreg.reg
echo "setinv"="c:\\accounts\\base\\inv-install.cmd">>setreg.reg
regedit /s setreg.reg
del setreg.reg