:: Machine inventory batch file installer version 2.2 25/Aug/2012
@echo off
c:
cd \
if not exist c:\temp md c:\temp
@echo :: Machine inventory batch file version 3.00 15/Jun/2012 >c:\temp\inv.cmd
@echo @echo off>>c:\temp\inv.cmd
@echo @echo "Inventory script">>c:\temp\inv.cmd
@echo @echo "Please connect to IBM network... do not close window">>c:\temp\inv.cmd
@echo:>>c:\temp\inv.cmd
@echo :: Make sure Grace is not mapped>>c:\temp\inv.cmd
@echo net use \\9.17.50.92 /y /delete 1^>^>NUL 2^>^&1 >>c:\temp\inv.cmd
@echo net use \\9.17.50.92\latest /y /delete 1^>^>NUL 2^>^&1 >>c:\temp\inv.cmd
@echo net use \\9.17.50.92\inventory /y /delete 1^>^>NUL 2^>^&1 >>c:\temp\inv.cmd
@echo net use \\9.17.50.92\IPC$ /y /delete 1^>^>NUL 2^>^&1 >>c:\temp\inv.cmd
@echo net use \\9.17.50.92\burn /y /delete 1^>^>NUL 2^>^&1 >>c:\temp\inv.cmd
@echo net use \\grace.boulder.ibm.com /y /delete 1^>^>NUL 2^>^&1 >>c:\temp\inv.cmd
@echo net use \\grace.boulder.ibm.com /y /delete 1^>^>NUL 2^>^&1 >>c:\temp\inv.cmd
@echo net use \\grace.boulder.ibm.com /y /delete 1^>^>NUL 2^>^&1 >>c:\temp\inv.cmd
@echo net use \\grace.boulder.ibm.com\IPC$ /y /delete 1^>^>NUL 2^>^&1 >>c:\temp\inv.cmd
@echo net use \\grace.boulder.ibm.com\burn /y /delete 1^>^>NUL 2^>^&1 >>c:\temp\inv.cmd
@echo net use k: /delete /y 1^>^>NUL 2^>^&1 >>c:\temp\inv.cmd
@echo:>>c:\temp\inv.cmd
@echo :startit>>c:\temp\inv.cmd
@echo :: Create share>>c:\temp\inv.cmd
@echo net use k: \\grace.boulder.ibm.com\inventory /user:inventoryagent inventorytool /persistent:no 1^>^>Nul 2^>^&1 >>c:\temp\inv.cmd
@echo IF ERRORLEVEL 1 GOTO Wait>>c:\temp\inv.cmd
@echo:>>c:\temp\inv.cmd
@echo :: Update>>c:\temp\inv.cmd
@echo If not exist "C:\program files (x86)" goto winxp>>c:\temp\inv.cmd
@echo if not exist "C:\programdata" goto winxp>>c:\temp\inv.cmd
@echo ::win7>>c:\temp\inv.cmd
@echo If not exist "%%userprofile%%\inventory" md "%%userprofile%%\inventory">>c:\temp\inv.cmd
@echo IF exist k:\updates\inv.cmd copy k:\updates\inv.cmd "%%userprofile%%\inventory\inv.cmd">>c:\temp\inv.cmd
@echo goto either>>c:\temp\inv.cmd
@echo :winxp>>c:\temp\inv.cmd
@echo IF exist k:\updates\inv.cmd copy k:\updates\inv.cmd "C:\Documents and Settings\All Users\Start Menu\Programs\Startup\inv.cmd">>c:\temp\inv.cmd
@echo :either>>c:\temp\inv.cmd
@echo:>>c:\temp\inv.cmd
@echo :: Need Serial number of Machine>>c:\temp\inv.cmd
@echo for /f "tokens=1 delims=serialnumber " %%%%a in ('wmic bios get serialnumber') do IF "%%%%a" GTR "" set SN=%%%%a>>c:\temp\inv.cmd
@echo:
@echo :: Need machine model type>>c:\temp\inv.cmd
@echo for /f "tokens=1 delims=name " %%%%a in ('wmic csproduct get name') DO IF "%%%%a" Gtr "" set MTM=%%%%a>>c:\temp\inv.cmd
@echo:>>c:\temp\inv.cmd
@echo if not exist k:\%%SN%% mkdir k:\%%SN%%>>c:\temp\inv.cmd
@echo :: mkdir k:\working\%%SN%%>>c:\temp\inv.cmd
@echo if exist "C:\program files\wst" copy "c:\program files\wst\email.htm" k:\%%SN%%>>c:\temp\inv.cmd
@echo if exist "C:\program files (x86)\wst" copy "c:\program files (x86)\wst\email.htm" k:\%%SN%%>>c:\temp\inv.cmd
@echo :: copy "c:\program files\wst\email.htm" k:\working\%%SN%%>>c:\temp\inv.cmd
@echo:>>c:\temp\inv.cmd
@echo IF exist k:\%%SN%%\*.txt goto :end>>c:\temp\inv.cmd
@echo:>>c:\temp\inv.cmd
@echo :: Unmap drive to clear number of consecutive users>>c:\temp\inv.cmd
@echo net use k: /delete /y 1^>^>NUL 2^>^&1 >>c:\temp\inv.cmd
@echo:>>c:\temp\inv.cmd
@echo :: Check for Office installations>>c:\temp\inv.cmd
@echo if exist "c:\program files\microsoft Office\office10\msaccess.exe" set access=1 >>c:\temp\inv.cmd
@echo if exist "c:\program files\microsoft Office\office10\excel.exe" set OfficeXP=1 >>c:\temp\inv.cmd
@echo if exist "c:\program files\microsoft Office\office11\excel.exe" set Office2003=1 >>c:\temp\inv.cmd
@echo if exist "c:\program files\microsoft Office\office12\excel.exe" set Office2007=1 >>c:\temp\inv.cmd
@echo if exist "c:\program files\microsoft Office\office13\excel.exe" set Office2010=1 >>c:\temp\inv.cmd
@echo if exist "c:\program files\microsoft Office\office14\excel.exe" set Office2010=1 >>c:\temp\inv.cmd
@echo if exist "c:\Program Files (x86)\microsoft Office\office10\msaccess.exe" set access=1 >>c:\temp\inv.cmd
@echo if exist "c:\Program Files (x86)\microsoft Office\office10\excel.exe" set OfficeXP=1 >>c:\temp\inv.cmd
@echo if exist "c:\Program Files (x86)\microsoft Office\office11\excel.exe" set Office2003=1 >>c:\temp\inv.cmd
@echo if exist "c:\Program Files (x86)\microsoft Office\office12\excel.exe" set Office2007=1 >>c:\temp\inv.cmd
@echo if exist "c:\Program Files (x86)\microsoft Office\office13\excel.exe" set Office2010=1 >>c:\temp\inv.cmd
@echo if exist "c:\Program Files (x86)\microsoft Office\office14\excel.exe" set Office2010=1 >>c:\temp\inv.cmd
@echo:>>c:\temp\inv.cmd
@echo :: Need user's name>>c:\temp\inv.cmd
@echo Set /P Name=Enter your full name and hit enter >>c:\temp\inv.cmd
@echo:>>c:\temp\inv.cmd
@echo ::User's email>>c:\temp\inv.cmd
@echo Set /P email=Enter you email address and hit enter >>c:\temp\inv.cmd
@echo:>>c:\temp\inv.cmd
@echo :: Need User's Bldg>>c:\temp\inv.cmd
@echo set /P Bldg=Enter your building number (22W, 22E, 25) and hit enter >>c:\temp\inv.cmd
@echo:>>c:\temp\inv.cmd
@echo :: Need user's office/cube>>c:\temp\inv.cmd
@echo set /P cube=Enter your office or cube number and hit enter >>c:\temp\inv.cmd
@echo:>>c:\temp\inv.cmd
@echo :: Need User's Account>>c:\temp\inv.cmd
@echo set /P account=Enter your primary Account and hit enter >>c:\temp\inv.cmd
@echo:>>c:\temp\inv.cmd
@echo :: Need user's serial number>>c:\temp\inv.cmd
@echo set /P USN=Enter your employee serial number and hit enter >>c:\temp\inv.cmd
@echo:>>c:\temp\inv.cmd
@echo :: Not many but some secondary machines are in use.>>c:\temp\inv.cmd
@echo @echo "If you don't know the answer to this next one then it is probably Primary">>c:\temp\inv.cmd
@echo set /P Primary=Enter whether this is your Primary or a Secondary machine and hit enter >>c:\temp\inv.cmd
@echo:>>c:\temp\inv.cmd
@echo :: Date>>c:\temp\inv.cmd
@echo FOR /F "tokens=*" %%%%A IN ('DATE/T') DO FOR %%%%B IN (%%%%A) DO SET Today=%%%%B>>c:\temp\inv.cmd
@echo:>>c:\temp\inv.cmd
@echo @echo "%%SN%%","%%MTM%%","%%Name%%","%%email%%","%%USN%%","%%Bldg%% Cube %%cube%%","%%account%%","%%Primary%%","%%OfficeXP%%","%%Office2003%%","%%Office2007%%","%%Office2010%%","%%access%%","%%Today%%"^>"%%temp%%"\"%%Name%%-%%SN%%.txt">>c:\temp\inv.cmd
@echo:>>c:\temp\inv.cmd
@echo :mapit>>c:\temp\inv.cmd
@echo :: Create share>>c:\temp\inv.cmd
@echo net use k: \\grace.boulder.ibm.com\inventory /user:inventoryagent inventorytool /persistent:no 1^>^>Nul 2^>^&1 >>c:\temp\inv.cmd
@echo IF ERRORLEVEL 1 GOTO Wait1 >>c:\temp\inv.cmd
@echo:>>c:\temp\inv.cmd
@echo copy "%%temp%%"\"%%Name%%-%%SN%%.txt" k:\%%SN%%>>c:\temp\inv.cmd
@echo :: copy "%%temp%%"\"%%Name%%-%%SN%%.txt" k:\working\%%SN%%>>c:\temp\inv.cmd
@echo:>>c:\temp\inv.cmd
@echo :end>>c:\temp\inv.cmd
@echo net use k: /delete /y 1^>^>NUL 2^>^&1 >>c:\temp\inv.cmd
@echo exit>>c:\temp\inv.cmd
@echo:>>c:\temp\inv.cmd
@echo :Wait>>c:\temp\inv.cmd
@echo :: Ping to wait for 15 seconds for network connection to become available>>c:\temp\inv.cmd
@echo net use k: /delete 1^>^>NUL 2^>^&1 >>c:\temp\inv.cmd
@echo @ping -n 10 -w 1 127.0.0.1 ^>Nul>>c:\temp\inv.cmd
@echo Goto startit>>c:\temp\inv.cmd
@echo:>>c:\temp\inv.cmd
@echo :Wait1 >>c:\temp\inv.cmd
@echo :: Ping to wait for 15 seconds>>c:\temp\inv.cmd
@echo net use k: /delete 1^>^>NUL 2^>^&1 >>c:\temp\inv.cmd
@echo @ping -n 10 -w 1 127.0.0.1 ^>Nul>>c:\temp\inv.cmd
@echo Goto mapit>>c:\temp\inv.cmd

:: WinXP or Win7
If not exist "C:\program files (x86)" goto winxp
if not exist "C:\programdata" goto winxp
::win7
If not exist "%userprofile%\inventory" md "%userprofile%\inventory"
copy c:\temp\inv.cmd "%userprofile%\inventory"
:: inventory.xml
@echo ^<?xml version="1.0" encoding="UTF-16"?^>>c:\temp\inventory.xml
@echo ^<Task version="1.2" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task"^>>>c:\temp\inventory.xml
@echo   ^<Triggers^>>>c:\temp\inventory.xml
@echo     ^<TimeTrigger^>>>c:\temp\inventory.xml
@echo       ^<Repetition^>>>c:\temp\inventory.xml
@echo         ^<Interval^>PT5H^</Interval^>>>c:\temp\inventory.xml
@echo         ^<StopAtDurationEnd^>false^</StopAtDurationEnd^>>>c:\temp\inventory.xml
@echo       ^</Repetition^>>>c:\temp\inventory.xml
@echo       ^<StartBoundary^>2012-06-15T12:35:00^</StartBoundary^>>>c:\temp\inventory.xml
@echo       ^<Enabled^>true^</Enabled^>>>c:\temp\inventory.xml
@echo     ^</TimeTrigger^>>>c:\temp\inventory.xml
@echo   ^</Triggers^>>>c:\temp\inventory.xml
@echo   ^<Principals^>>>c:\temp\inventory.xml
@echo     ^<Principal id="Author"^>>>c:\temp\inventory.xml
@echo       ^<LogonType^>InteractiveToken^</LogonType^>>>c:\temp\inventory.xml
@echo       ^<RunLevel^>HighestAvailable^</RunLevel^>>>c:\temp\inventory.xml
@echo     ^</Principal^>>>c:\temp\inventory.xml
@echo   ^</Principals^>>>c:\temp\inventory.xml
@echo   ^<Settings^>>>c:\temp\inventory.xml
@echo     ^<MultipleInstancesPolicy^>StopExisting^</MultipleInstancesPolicy^>>>c:\temp\inventory.xml
@echo     ^<DisallowStartIfOnBatteries^>false^</DisallowStartIfOnBatteries^>>>c:\temp\inventory.xml
@echo     ^<StopIfGoingOnBatteries^>false^</StopIfGoingOnBatteries^>>>c:\temp\inventory.xml
@echo     ^<AllowHardTerminate^>true^</AllowHardTerminate^>>>c:\temp\inventory.xml
@echo     ^<StartWhenAvailable^>true^</StartWhenAvailable^>>>c:\temp\inventory.xml
@echo     ^<RunOnlyIfNetworkAvailable^>true^</RunOnlyIfNetworkAvailable^>>>c:\temp\inventory.xml
@echo     ^<IdleSettings^>>>c:\temp\inventory.xml
@echo       ^<StopOnIdleEnd^>true^</StopOnIdleEnd^>>>c:\temp\inventory.xml
@echo       ^<RestartOnIdle^>false^</RestartOnIdle^>>>c:\temp\inventory.xml
@echo     ^</IdleSettings^>>>c:\temp\inventory.xml
@echo     ^<AllowStartOnDemand^>true^</AllowStartOnDemand^>>>c:\temp\inventory.xml
@echo     ^<Enabled^>true^</Enabled^>>>c:\temp\inventory.xml
@echo     ^<Hidden^>false^</Hidden^>>>c:\temp\inventory.xml
@echo     ^<RunOnlyIfIdle^>false^</RunOnlyIfIdle^>>>c:\temp\inventory.xml
@echo     ^<WakeToRun^>false^</WakeToRun^>>>c:\temp\inventory.xml
@echo     ^<ExecutionTimeLimit^>PT0S^</ExecutionTimeLimit^>>>c:\temp\inventory.xml
@echo     ^<Priority^>7^</Priority^>>>c:\temp\inventory.xml
@echo   ^</Settings^>>>c:\temp\inventory.xml
@echo   ^<Actions Context="Author"^>>>c:\temp\inventory.xml
@echo     ^<Exec^>>>c:\temp\inventory.xml
@echo       ^<Command^>%%userprofile%%\inventory\inv.cmd^</Command^>>>c:\temp\inventory.xml
@echo     ^</Exec^>>>c:\temp\inventory.xml
@echo   ^</Actions^>>>c:\temp\inventory.xml
@echo ^</Task^>>>c:\temp\inventory.xml
cd c:\temp
schtasks /create  /TN Inventory /xml c:\temp\inventory.xml /f
goto either
:winxp
copy c:\temp\inv.cmd "C:\Documents and Settings\All Users\Start Menu\Programs\Startup\inv.cmd"
:either
@echo Complete
@ping -n 7 -w 1 127.0.0.1 ^>Nul>>c:\temp\inv.cmd