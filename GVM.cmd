@echo off
REM Copyright Andy Willis Licensed to IBM 
REM Version 1.5.1
if exist validatemefs.vbs del validatemefs.vbs
if exist info.txt del info.txt
if exist %USERPROFILE%\Downloads\validatemefs.vbs del %USERPROFILE%\Downloads\validatemefs.vbs
"c:\program files (x86)\mozilla firefox\firefox" https://w3-connections.ibm.com/wikis/form/api/wiki/50f89124-0fdc-4f7b-a7e4-00f0fa10fe6d/page/b7c8909b-a444-4cc8-8966-4a0002a1409f/attachment/b92caab9-0b85-4b7b-8d38-1c1785eeb66c/media/ValidateMefs.vbs
Set /P Enter=Hit Enter when download is complete
if exist %USERPROFILE%\Downloads\validatemefs.vbs copy %USERPROFILE%\Downloads\validatemefs.vbs .
if exist *inventory*.xls dir /b *inventory*.xls >info.txt
if exist *inventory*.xlsx dir /b *inventory*.xlsx >>info.txt
if exist *inventory*.csv dir /b *inventory*.csv >>info.txt
goto Date
:back
for /f "delims=" %%D in ('dir *evidence* /a:d /b') do echo %%~fD >>info.txt
REM dir /s/b *evidence* >>info.txt
start notepad info.txt
cscript validatemefs.vbs
Choice /M "Do you want to open the csv file? (Y/N)"
IF %ERRORLEVEL% == 2 goto nocsv
FOR /F "tokens=*" %%A IN ('DATE/T') DO FOR %%B IN (%%A) DO SET Today=%%B
SET result=%Today:*/=%
SET year=%result:*/=%
CALL SET intermediate=%%result:%year%=%%
SET day=%intermediate:/=%
SET first=%Today:*/=%
CALL SET intermediate=%%Today:%first%=%%
set month=%intermediate:/=%
if %month%==1 set month=Jan
if %month%==2 set month=Feb
if %month%==3 set month=Mar
if %month%==4 set month=Apr
if %month%==5 set month=May
if %month%==6 set month=Jun
if %month%==7 set month=Jul
if %month%==8 set month=Aug
if %month%==9 set month=Sep
if %month%==10 set month=Oct
if %month%==11 set month=Nov
if %month%==12 set month=Dec
findstr /I NOMEFS validatemefs_%day%%month%%year%_REPORT.csv
if %ERRORLEVEL%==0 echo NOMEFS were found
"C:\Program Files (x86)\Microsoft Office\root\Office16\excel.exe" validatemefs_%day%%month%%year%_REPORT.csv
:nocsv
goto end

:Date
@echo off
REM Public Domain Date subtraction code
set yyyy=

set $tok=1-3
for /f "tokens=1 delims=.:/-, " %%u in ('date /t') do set $d1=%%u
if "%$d1:~0,1%" GTR "9" set $tok=2-4
for /f "tokens=%$tok% delims=.:/-, " %%u in ('date /t') do (
 for /f "skip=1 tokens=2-4 delims=/-,()." %%x in ('echo.^|date') do (
    set %%x=%%u
    set %%y=%%v
    set %%z=%%w
    set $d1=
    set $tok=))

if "%yyyy%"=="" set yyyy=%yy%
if /I %yyyy% LSS 100 set /A yyyy=2000 + 1%yyyy% - 100

set CurDate=%mm%/%dd%/%yyyy%

set dayCnt=%1

if "%dayCnt%"=="" set dayCnt=30

REM Substract your days here
set /A dd=1%dd% - 100 - %dayCnt%
set /A mm=1%mm% - 100

:CHKDAY

if /I %dd% GTR 0 goto DONE

set /A mm=%mm% - 1

if /I %mm% GTR 0 goto ADJUSTDAY

set /A mm=12
set /A yyyy=%yyyy% - 1

:ADJUSTDAY

if %mm%==1 goto SET31
if %mm%==2 goto LEAPCHK
if %mm%==3 goto SET31
if %mm%==4 goto SET30
if %mm%==5 goto SET31
if %mm%==6 goto SET30
if %mm%==7 goto SET31
if %mm%==8 goto SET31
if %mm%==9 goto SET30
if %mm%==10 goto SET31
if %mm%==11 goto SET30
REM ** Month 12 falls through

:SET31

set /A dd=31 + %dd%

goto CHKDAY

:SET30

set /A dd=30 + %dd%

goto CHKDAY

:LEAPCHK

set /A tt=%yyyy% %% 4

if not %tt%==0 goto SET28

set /A tt=%yyyy% %% 100

if not %tt%==0 goto SET29

set /A tt=%yyyy% %% 400

if %tt%==0 goto SET29

:SET28

set /A dd=28 + %dd%

goto CHKDAY

:SET29

set /A dd=29 + %dd%

goto CHKDAY

:DONE

if /I %mm% LSS 10 set mm=0%mm%
if /I %dd% LSS 10 set dd=0%dd%

echo %mm%/%dd%/%yyyy% >>info.txt
goto back
:end