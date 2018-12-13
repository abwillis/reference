:: Knowlagent removal script V1.1 13/Jun/2011
@echo off
C:
:: Uninstall old knowlagent
if exist "c:\program files\knowlagent" cd "\program files\knowlagent"
if exist "C:\program files\knowlagent\unwise.exe" unwise /S "c:\program files\knowlagent\install.log"
if exist "c:\program files\knowlagent\KACommControl85\KACommControlFTC.ocx" del "c:\program files\knowlagent\KACommControl85\KACommControlFTC.ocx"
if exist "c:\program files\knowlagent\KACommControl85" rd "c:\program files\knowlagent\KACommControl85"
if exist "c:\program files\knowlagent" del /Q "c:\program files\knowlagent\*"
if exist "c:\program files\knowlagent" cd ..
if exist "c:\program files\knowlagent" rd "c:\program files\knowlagent"
:: Additional Cleanup may be required
if exist "C:\Documents and Settings\All Users\Start Menu\Programs\Knowlagent" del /Q "C:\Documents and Settings\All Users\Start Menu\Programs\Knowlagent\*"
if exist "C:\Documents and Settings\All Users\Start Menu\Programs\Knowlagent" rd "C:\Documents and Settings\All"
:: Delete Startup folder icon
del "C:\Documents and Settings\All Users\Start Menu\Programs\Startup\KnowlAgent.lnk" 1>>NUL 2>&1
:: Remove Knowlagent from Run line in Registry for startup
mkdir c:\tmp 1>>NUL 2>&1
echo Windows Registry Editor Version 5.00> c:\tmp\knowlagent.reg
echo:>>c:\tmp\knowlagent.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run]>>c:\tmp\knowlagent.reg
echo "KnowlAgent"=->>c:\tmp\knowlagent.reg
echo:>>c:\tmp\knowlagent.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run]>>c:\tmp\knowlagent.reg
echo "KnowlAagent"=->>c:\tmp\knowlagent.reg
echo:>>c:\tmp\knowlagent.reg
regedit /s c:\tmp\knowlagent.reg
