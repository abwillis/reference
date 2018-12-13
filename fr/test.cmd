echo off
FOR /F "tokens=*" %%A IN ('DATE/T') DO FOR %%B IN (%%A) DO SET Today=%%B
echo %Today%
for /f "delims=" %%D in ('dir *data* /a:d /b') do echo %%~fD
FOR /F "tokens=*" %%A IN ('DATE/T') DO FOR %%B IN (%%A) DO SET Today=%%B
SET result=%Today:*/=%
SET year=%result:*/=%
CALL SET intermediate=%%result:%year%=%%
SET day=%intermediate:/=%
SET first=%Today:*/=%
CALL SET intermediate=%%Today:%first%=%%
set month=%intermediate:/=%
set tmonth=%month%
echo %day%
echo %year%
echo %test%
echo %month%
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
echo %month%
echo validatemefs_%day%%month%%year%_REPORT.csv

set track=Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec
echo %tmonth%
echo %track%
rem setlocal enableextensions enabledelayedexpansion
set track="Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec"
for /F "tokens=%tmonth% delims=," %%z in (%track%) do (
	echo %%z from for loop
	)
rem endlocal