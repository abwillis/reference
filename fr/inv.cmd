:: Machine inventory batch file version 3/Mar/2011
@echo off
setLocal

@echo "Inventory script"
@echo "Please connect to IBM network... do not close window"

:: Make sure Younger is not mapped
net use \\9.17.50.72 /delete 1>>NUL 2>&1
net use \\9.17.50.72\latest /delete 1>>NUL 2>&1
net use \\9.17.50.72\inventory /delete 1>>NUL 2>&1
net use \\9.17.50.72\IPC$ /delete 1>>NUL 2>&1
net use k: /delete 1>>NUL 2>&1

:startit
:: Create share
net use k: \\9.17.50.72\inventory /user:inventoryagent inventorytool /persistent:no 1>>Nul 2>&1
IF ERRORLEVEL 1 GOTO Wait

:: Update
IF exist k:\updates\inv.cmd copy k:\updates\inv.cmd "C:\Documents and Settings\All Users\Start Menu\Programs\Startup\inv.cmd"

:: Need Serial number of Machine
for /f "tokens=1 delims=serialnumber " %%a in ('wmic bios get serialnumber') do (
set SN=%%a
)

mkdir k:\%SN%
:: mkdir k:\working\%SN%
copy "c:\program files\wst\email.htm" k:\%SN%
:: copy "c:\program files\wst\email.htm" k:\working\%SN%

IF exist k:\%SN%\*.txt goto :end

:: Unmap drive to clear number of consecutive users
net use k: /delete 1>>NUL 2>&1

:: Need user's name
Set /P Name=Enter your full name and hit enter 

::User's email
Set /P email=Enter you email address and hit enter 

:: Need User's Bldg
set /P Bldg=Enter your building number (22W, 22E, 25) and hit enter 

:: Need user's office/cube
set /P cube=Enter your office or cube number and hit enter 

:: Need User's Account
set /P account=Enter your primary Account and hit enter 

:: Need user's serial number
set /P USN=Enter your employee serial number and hit enter 

:: Need machine model type
for /f "tokens=1 delims=Name " %%a in ('wmic csproduct get name') do (
set MTM=%%a
)

:: Not many but some secondary machines are in use.
@echo "If you don't know the answer to this next one then it is probably Primary"
set /P Primary=Enter whether this is your Primary or a Secondary machine and hit enter 

:: Date
FOR /F "tokens=*" %%A IN ('DATE/T') DO FOR %%B IN (%%A) DO SET Today=%%B

@echo "%Name%","%email%","%USN%","%SN%","%MTM%","%Bldg% Cube %cube%","%account%","%Primary%","%Today%">"%temp%"\"%Name%-%SN%.txt"

:mapit
:: Create share
net use k: \\9.17.50.72\inventory /user:inventoryagent inventorytool /persistent:no 1>>Nul 2>&1
IF ERRORLEVEL 1 GOTO Wait1

copy "%temp%"\"%Name%-%SN%.txt" k:\%SN%
:: copy "%temp%"\"%Name%-%SN%.txt" k:\working\%SN%

:end
net use k: /delete 1>>NUL 2>&1
exit

:Wait
:: Ping to wait for 15 seconds for network connection to become available
net use k: /delete 1>>NUL 2>&1
@ping -n 10 -w 1 127.0.0.1 >Nul
Goto startit

:Wait1
:: Ping to wait for 15 seconds
net use k: /delete 1>>NUL 2>&1
@ping -n 10 -w 1 127.0.0.1 >Nul
Goto mapit
