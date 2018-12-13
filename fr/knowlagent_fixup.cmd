:: Knowlagent setup/cleanup script BlueZone V3.50 17/Jun/2012
@echo off
c:
:: Delete Startup folder icon
del "C:\Documents and Settings\All Users\Start Menu\Programs\Startup\KnowlAgent.lnk" 1>>NUL 2>&1
:: Add hosts file entry
find /C /I "ibm-eus-ag.knowlagentondemand.com" c:\windows\system32\drivers\etc\hosts 1>>NUL 2>&1
if %ERRORLEVEL% == 0 (
type c:\windows\system32\drivers\etc\hosts | findstr /V ibm-eus-ag.knowlagentondemand.com>c:\windows\system32\drivers\etc\hosts2.sav
echo:>>c:\windows\system32\drivers\etc\hosts2.sav
echo 9.49.248.149    ibm-eus-ag.knowlagentondemand.com>>c:\windows\system32\drivers\etc\hosts2.sav
attrib -s -h -r c:\windows\system32\drivers\etc\hosts
copy c:\windows\system32\drivers\etc\hosts2.sav c:\windows\system32\drivers\etc\hosts
attrib +r c:\windows\system32\drivers\etc\hosts
) else (
attrib -s -h -r c:\windows\system32\drivers\etc\hosts
if not exist "c:\windows\system32\drivers\etc\hosts" echo 127.0.0.1     localhost>c:\windows\system32\drivers\etc\hosts
type c:\windows\system32\drivers\etc\hosts>c:\windows\system32\drivers\etc\hosts1.sav
copy c:\windows\system32\drivers\etc\hosts1.sav c:\windows\system32\drivers\etc\hosts
echo:>>c:\windows\system32\drivers\etc\hosts
echo 9.49.248.149    ibm-eus-ag.knowlagentondemand.com>>c:\windows\system32\drivers\etc\hosts
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
:: echo "KnowlAgent" = "c:\\Program Files\\Internet Explorer\\iexplore http://poknatknowlagent.iespc.ibm.com">>c:\tmp\knowlagent.reg
echo:>>c:\tmp\knowlagent.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run]>>c:\tmp\knowlagent.reg
echo "KnowlAagent"=->>c:\tmp\knowlagent.reg
echo:>>c:\tmp\knowlagent.reg
regedit /s c:\tmp\knowlagent.reg
if not exist "C:\program files (x86)" goto either
if not exist "C:\programdata" goto either
@echo Windows Registry Editor Version 5.00>c:\tmp\trusted.reg
@echo: >>c:\tmp\trusted.reg
@echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\9.56.200.23]>>c:\tmp\trusted.reg
@echo "http"=dword:00000002 >>c:\tmp\trusted.reg
@echo: >>c:\tmp\trusted.reg
@echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\ibm-eus-ag.knowlagentondemand.com]>>c:\tmp\trusted.reg
@echo "http"=dword:00000002>>c:\tmp\trusted.reg
@echo: >>c:\tmp\trusted.reg
@echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\poknatknowlagent.iespc.ibm.com]>>c:\tmp\trusted.reg
@echo "http"=dword:00000002>>c:\tmp\trusted.reg
@echo: >>c:\tmp\trusted.reg
regedit /s c:\tmp\trusted.reg
:: Knowlagent trusted sites zone
@echo Windows Registry Editor Version 5.00>c:\tmp\zones.reg
@echo:>>c:\tmp\zones.reg
@echo [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2]>>c:\tmp\zones.reg
@echo "2001"=dword:00000000>>c:\tmp\zones.reg
@echo "2004"=dword:00000000>>c:\tmp\zones.reg
@echo @="">>c:\tmp\zones.reg
@echo "DisplayName"="Trusted sites">>c:\tmp\zones.reg
@echo "PMDisplayName"="Trusted sites [Protected Mode]">>c:\tmp\zones.reg
@echo "Description"="This zone contains websites that you trust not to damage your computer or data.">>c:\tmp\zones.reg
@echo "Icon"="inetcpl.cpl#00004480">>c:\tmp\zones.reg
@echo "LowIcon"="inetcpl.cpl#005424">>c:\tmp\zones.reg
@echo "CurrentLevel"=dword:00000000>>c:\tmp\zones.reg
@echo "Flags"=dword:00000043>>c:\tmp\zones.reg
@echo "1200"=dword:00000000>>c:\tmp\zones.reg
@echo "1400"=dword:00000000>>c:\tmp\zones.reg
@echo "2007"=dword:00010000>>c:\tmp\zones.reg
@echo "1001"=dword:00000000>>c:\tmp\zones.reg
@echo "1004"=dword:00000000>>c:\tmp\zones.reg
@echo "1201"=dword:00000000>>c:\tmp\zones.reg
@echo "1206"=dword:00000000>>c:\tmp\zones.reg
@echo "1207"=dword:00000000>>c:\tmp\zones.reg
@echo "1208"=dword:00000000>>c:\tmp\zones.reg
@echo "1209"=dword:00000000>>c:\tmp\zones.reg
@echo "120A"=dword:00000003>>c:\tmp\zones.reg
@echo "120B"=dword:00000000>>c:\tmp\zones.reg
@echo "1402"=dword:00000000>>c:\tmp\zones.reg
@echo "1405"=dword:00000000>>c:\tmp\zones.reg
@echo "1406"=dword:00000000>>c:\tmp\zones.reg
@echo "1407"=dword:00000000>>c:\tmp\zones.reg
@echo "1408"=dword:00000000>>c:\tmp\zones.reg
@echo "1409"=dword:00000003>>c:\tmp\zones.reg
@echo "1601"=dword:00000000>>c:\tmp\zones.reg
@echo "1604"=dword:00000000>>c:\tmp\zones.reg
@echo "1605"=dword:00000000>>c:\tmp\zones.reg
@echo "1606"=dword:00000000>>c:\tmp\zones.reg
@echo "1607"=dword:00000000>>c:\tmp\zones.reg
@echo "1608"=dword:00000000>>c:\tmp\zones.reg
@echo "1609"=dword:00000000>>c:\tmp\zones.reg
@echo "160A"=dword:00000000>>c:\tmp\zones.reg
@echo "1800"=dword:00000000>>c:\tmp\zones.reg
@echo "1802"=dword:00000000>>c:\tmp\zones.reg
@echo "1803"=dword:00000000>>c:\tmp\zones.reg
@echo "1804"=dword:00000000>>c:\tmp\zones.reg
@echo "1809"=dword:00000003>>c:\tmp\zones.reg
@echo "1A00"=dword:00000000>>c:\tmp\zones.reg
@echo "1A02"=dword:00000000>>c:\tmp\zones.reg
@echo "1A03"=dword:00000000>>c:\tmp\zones.reg
@echo "1A04"=dword:00000000>>c:\tmp\zones.reg
@echo "1A05"=dword:00000000>>c:\tmp\zones.reg
@echo "1A06"=dword:00000000>>c:\tmp\zones.reg
@echo "1C00"=dword:00030000>>c:\tmp\zones.reg
@echo "2000"=dword:00000000>>c:\tmp\zones.reg
@echo "2005"=dword:00000000>>c:\tmp\zones.reg
@echo "2100"=dword:00000000>>c:\tmp\zones.reg
@echo "2101"=dword:00000000>>c:\tmp\zones.reg
@echo "2102"=dword:00000000>>c:\tmp\zones.reg
@echo "2103"=dword:00000000>>c:\tmp\zones.reg
@echo "2104"=dword:00000000>>c:\tmp\zones.reg
@echo "2105"=dword:00000000>>c:\tmp\zones.reg
@echo "2106"=dword:00000000>>c:\tmp\zones.reg
@echo "2200"=dword:00000000>>c:\tmp\zones.reg
@echo "2201"=dword:00000000>>c:\tmp\zones.reg
@echo "2300"=dword:00000000>>c:\tmp\zones.reg
@echo "2301"=dword:00000003>>c:\tmp\zones.reg
@echo "2400"=dword:00000000>>c:\tmp\zones.reg
@echo "2401"=dword:00000000>>c:\tmp\zones.reg
@echo "2402"=dword:00000000>>c:\tmp\zones.reg
@echo "2600"=dword:00000000>>c:\tmp\zones.reg
@echo "2700"=dword:00000003>>c:\tmp\zones.reg
@echo "1805"=dword:00000000>>c:\tmp\zones.reg
@echo "1806"=dword:00000000>>c:\tmp\zones.reg
@echo "1807"=dword:00000000>>c:\tmp\zones.reg
@echo "1808"=dword:00000000>>c:\tmp\zones.reg
@echo "1A10"=dword:00000000>>c:\tmp\zones.reg
@echo "180A"=dword:00000003>>c:\tmp\zones.reg
@echo "180C"=dword:00000000>>c:\tmp\zones.reg
@echo "180D"=dword:00000000>>c:\tmp\zones.reg
@echo "2107"=dword:00000000>>c:\tmp\zones.reg
@echo "2500"=dword:00000003>>c:\tmp\zones.reg
@echo "2708"=dword:00000000>>c:\tmp\zones.reg
@echo "2709"=dword:00000000>>c:\tmp\zones.reg
@echo: >>c:\tmp\zones.reg
regedit /s c:\tmp\zones.reg
:either
:: Add startup script
if exist "C:\program files (x86)\internet explorer\iexplore.exe" echo start c:\progra~2\intern~1\iexplore http://poknatknowlagent.iespc.ibm.com >"C:\programdata\microsoft\windows\start menu\programs\startup\knowlagent_startup.cmd"
if exist "C:\program files (x86)\internet explorer\iexplore.exe" echo start c:\progra~2\intern~1\iexplore http://poknatknowlagent.iespc.ibm.com >"%userprofile%\desktop\knowlagent_startup.cmd"
if not exist "C:\program files (x86)\internet explorer\iexplore.exe" echo start c:\progra~1\intern~1\iexplore http://poknatknowlagent.iespc.ibm.com >"%userprofile%\desktop\knowlagent_startup.cmd"
if not exist "C:\program files (x86)\internet explorer\iexplore.exe" echo start c:\progra~1\intern~1\iexplore http://poknatknowlagent.iespc.ibm.com >"c:\documents and settings\all users\Start Menu\Programs\Startup\knowlagent_startup.cmd"
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
