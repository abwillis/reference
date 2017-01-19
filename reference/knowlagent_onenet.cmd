:: Knowlagent setup/cleanup script OneNet V2.3 Sep/20/2011
@echo off
c:
:: Delete Startup folder icon
del "C:\Documents and Settings\All Users\Start Menu\Programs\Startup\KnowlAgent.lnk" 1>>NUL 2>&1
:: Add hosts file entry
find /C /I "ibm-eus-ag.knowlagentondemand.com" c:\windows\system32\drivers\etc\hosts 1>>NUL 2>&1
if %ERRORLEVEL% == 0 ( 
type c:\windows\system32\drivers\etc\hosts | findstr /V ibm-eus-ag.knowlagentondemand.com>c:\windows\system32\drivers\etc\hosts2.sav
echo:>>c:\windows\system32\drivers\etc\hosts2.sav
echo 67.208.39.116    ibm-eus-ag.knowlagentondemand.com>>c:\windows\system32\drivers\etc\hosts2.sav
attrib -s -h -r c:\windows\system32\drivers\etc\hosts
copy c:\windows\system32\drivers\etc\hosts2.sav c:\windows\system32\drivers\etc\hosts
attrib +r c:\windows\system32\drivers\etc\hosts 
) else (
attrib -s -h -r c:\windows\system32\drivers\etc\hosts
if not exist "c:\windows\system32\drivers\etc\hosts" echo 127.0.0.1     localhost>c:\windows\system32\drivers\etc\hosts
type c:\windows\system32\drivers\etc\hosts>c:\windows\system32\drivers\etc\hosts1.sav
copy c:\windows\system32\drivers\etc\hosts1.sav c:\windows\system32\drivers\etc\hosts
echo:>>c:\windows\system32\drivers\etc\hosts
echo 67.208.39.116    ibm-eus-ag.knowlagentondemand.com>>c:\windows\system32\drivers\etc\hosts
attrib +r c:\windows\system32\drivers\etc\hosts
)
:: Add Knowlagent to Run line in Registry for startup
mkdir c:\tmp 1>>NUL 2>&1
echo Windows Registry Editor Version 5.00> c:\tmp\knowlagent.reg
echo:>>c:\tmp\knowlagent.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run]>>c:\tmp\knowlagent.reg
echo "KnowlAgent"=->>c:\tmp\knowlagent.reg
echo:>>c:\tmp\knowlagent.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run]>>c:\tmp\knowlagent.reg
:: echo "KnowlAgent"="wscript /b \"c:\\Program Files\\KnowlAgent\\StartKnowDev.vbs\"">>c:\tmp\knowlagent.reg
echo "KnowlAgent" = "c:\\Program Files\\Internet Explorer\\iexplore http://poknatknowlagent.iespc.ibm.com">>c:\tmp\knowlagent.reg
echo:>>c:\tmp\knowlagent.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run]>>c:\tmp\knowlagent.reg
echo "KnowlAagent"=->>c:\tmp\knowlagent.reg
echo:>>c:\tmp\knowlagent.reg
regedit /s c:\tmp\knowlagent.reg
:: Create Favorite
:: For WinXP
if exist "c:\documents and settings" Goto WinXP
:return
if exist "C:\users" Goto Win7
:return1
::Create Favorite for new users via Default User
if not exist "c:\documents and settings\default user\Favorites\IBM" md "c:\documents and settings\default user\Favorites\IBM"
echo [DEFAULT]> "c:\documents and settings\default user\Favorites\IBM\Knowlagent.url"
echo BASEURL=http://poknatknowlagent.iespc.ibm.com/>> "c:\documents and settings\default user\Favorites\IBM\Knowlagent.url"
echo [InternetShortcut]>> "c:\documents and settings\default user\Favorites\IBM\Knowlagent.url"
echo URL=http://poknatknowlagent.iespc.ibm.com/>> "c:\documents and settings\default user\Favorites\IBM\Knowlagent.url"
echo IDList=>> "c:\documents and settings\default user\Favorites\IBM\Knowlagent.url"
echo [{000214A0-0000-0000-C000-000000000046}]>> "c:\documents and settings\default user\Favorites\IBM\Knowlagent.url"
:: Uninstall old knowlagent
if exist "c:\program files\knowlagent" cd "\program files\knowlagent"
if exist "C:\program files\knowlagent\unwise.exe" unwise /S "c:\program files\knowlagent\install.log"
if exist "c:\program files\knowlagent\KACommControl85\KACommControlFTC.ocx" del KACommControl85\KACommControlFTC.ocx
if exist "c:\program files\knowlagent\KACommControl85" rd "c:\program files\knowlagent\KACommControl85"
if exist "c:\program files\knowlagent" del /Q "c:\program files\knowlagent\*"
if exist "c:\program files\knowlagent" cd ..
if exist "c:\program files\knowlagent" rd "c:\program files\knowlagent"
:: Additional Cleanup may be required
if exist "C:\Documents and Settings\All Users\Start Menu\Programs\Knowlagent" del /Q "C:\Documents and Settings\All Users\Start Menu\Programs\Knowlagent\*"
if exist "C:\Documents and Settings\All Users\Start Menu\Programs\Knowlagent" rd "C:\Documents and Settings\All Users\Start Menu\Programs\Knowlagent"
Goto Complete
:WinXP
FOR /D %%G in ("C:\documents and settings\*") Do (
if not exist "%%G\Favorites\IBM" md "%%G\Favorites\IBM"
echo [DEFAULT]> "%%G\Favorites\IBM\Knowlagent.url"
echo BASEURL=http://poknatknowlagent.iespc.ibm.com/>> "%%G\Favorites\IBM\Knowlagent.url"
echo [InternetShortcut]>> "%%G\Favorites\IBM\Knowlagent.url"
echo URL=http://poknatknowlagent.iespc.ibm.com/>> "%%G\Favorites\IBM\Knowlagent.url"
echo IDList=>> "%%G\Favorites\IBM\Knowlagent.url"
echo [{000214A0-0000-0000-C000-000000000046}]>> "%%G\Favorites\IBM\Knowlagent.url"
)
::Create Favorite for new users via Default User
if not exist "c:\documents and settings\default user\Favorites\IBM" md "c:\documents and settings\default user\Favorites\IBM"
echo [DEFAULT]> "c:\documents and settings\default user\Favorites\IBM\Knowlagent.url"
echo BASEURL=http://poknatknowlagent.iespc.ibm.com/>> "c:\documents and settings\default user\Favorites\IBM\Knowlagent.url"
echo [InternetShortcut]>> "c:\documents and settings\default user\Favorites\IBM\Knowlagent.url"
echo URL=http://poknatknowlagent.iespc.ibm.com/>> "c:\documents and settings\default user\Favorites\IBM\Knowlagent.url"
echo IDList=>> "c:\documents and settings\default user\Favorites\IBM\Knowlagent.url"
echo [{000214A0-0000-0000-C000-000000000046}]>> "c:\documents and settings\default user\Favorites\IBM\Knowlagent.url"
Goto return
:WIn7
FOR /D %%G in ("C:\users\*") Do (
if not exist "%%G\Favorites\IBM" md "%%G\Favorites\IBM"
echo [DEFAULT]> "%%G\Favorites\IBM\Knowlagent.url"
echo BASEURL=http://poknatknowlagent.iespc.ibm.com/>> "%%G\Favorites\IBM\Knowlagent.url"
echo [InternetShortcut]>> "%%G\Favorites\IBM\Knowlagent.url"
echo URL=http://poknatknowlagent.iespc.ibm.com/>> "%%G\Favorites\IBM\Knowlagent.url"
echo IDList=>> "%%G\Favorites\IBM\Knowlagent.url"
echo [{000214A0-0000-0000-C000-000000000046}]>> "%%G\Favorites\IBM\Knowlagent.url"
)
::Create Favorite for new users via Default User
if not exist "c:\users\default\Favorites\IBM" md "c:\users\default\Favorites\IBM"
echo [DEFAULT]> "c:\users\default\Favorites\IBM\Knowlagent.url"
echo BASEURL=http://poknatknowlagent.iespc.ibm.com/>> "c:\users\default\Favorites\IBM\Knowlagent.url"
echo [InternetShortcut]>> "c:\users\default\Favorites\IBM\Knowlagent.url"
echo URL=http://poknatknowlagent.iespc.ibm.com/>> "c:\users\default\Favorites\IBM\Knowlagent.url"
echo IDList=>> "c:\users\default\Favorites\IBM\Knowlagent.url"
echo [{000214A0-0000-0000-C000-000000000046}]>> "c:\users\default\Favorites\IBM\Knowlagent.url"
goto return1
:Complete
@echo Complete
:: Ping to wait for 4 seconds to show Complete message
@ping -n 3 -w 1 127.0.0.1 >Nul
@echo on
