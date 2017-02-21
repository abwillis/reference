@REM Version 1.0 21Feb2017 ECM csv Inventory cleanup OS
@REM Works off of IDMCOMP customer overview file
@echo off
if exist *IDCOMP* dir /b IDMCOMP* >files.txt
if exist *Cust* dir /b Cust* >>files.txt
echo %cd%>>files.txt
set filename=%1
if [%1]==[] start notepad files.txt
if [%1]==[] set /P filename=Enter filename 

if exist newfile.csv del newfile.csv
if exist storage_complete_inventory.csv del Storage_complete_Inventory.csv
for /f "skip=3 delims=*" %%a in (%filename%) do (
echo %%a>>newfile.csv   
)
setlocal enableextensions enabledelayedexpansion
for /F "tokens=*" %%A in (newfile.csv) do (
    set LINE="%%A"
    for /F "tokens=2-9,* delims=;" %%a in (!LINE!) do (
		for /F "tokens=13,17,18,23,24,29 delims=;" %%J in ("%%i") do (
			set column[8]=%%J
			set column[9]=%%L
			set column[10]=%%N
			set column[11]=%%K
			set column[12]=%%M
			set column[13]=%%O
		)
        set column[0]=%%a
        set column[1]=%%b
        set column[2]=%%c
        set column[3]=%%d
        set column[4]=%%e
        set column[5]=%%f
		set column[6]=%%g
		set column[7]=%%h
)

			echo !column[0]!,!column[1]!,!column[2]!,!column[3]!,!column[4]!,!column[5]!,!column[6]!,!column[7]!,!column[8]!,!column[9]!,!column[10]!,!column[11]!,!column[12]!,!column[13]!,comments,>>Storage_complete_Inventory.csv
)
@REM for account to be set as an argument then the filename must be given as the first argument as account must be argument #2.
set Account=%2
if [%2]==[] set /P Account=Account Name 
        FOR /F "tokens=*" %%A IN ('DATE/T') DO FOR %%B IN (%%A) DO SET Today=%%B
			SET result=%Today:*/=%
			SET year=%result:*/=%
			CALL SET intermediate=%%result:%year%=%%
			SET day=%intermediate:/=%
			SET first=%Today:*/=%
			CALL SET intermediate=%%Today:%first%=%%
			set tmonth=%intermediate:/=%
			set track="Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec"
			for /F "tokens=%tmonth% delims=," %%y in (%track%) do set month=%%y
if exist %Account%_%day%%month%%year%_Inventory.csv ren %Account%_%day%%month%%year%_Inventory.csv %Account%_%day%%month%%year%_Inventory-%RANDOM%.csv
ren Storage_complete_Inventory.csv %Account%_%day%%month%%year%_Inventory.csv
if exist newfile.csv del newfile.csv
if [%1]==[] taskkill /fi "WINDOWTITLE eq files.txt*" >nul
if [%2]==[] taskkill /fi "WINDOWTITLE eq files.txt*" >nul
del files.txt
IF EXIST "c:\Program Files (x86)\OpenOffice 4\program\scalc.exe" start "" "c:\Program Files (x86)\OpenOffice 4\program\scalc.exe" %Account%_%day%%month%%year%_Inventory.csv
IF NOT EXIST "c:\Program Files (x86)\OpenOffice 4\program\scalc.exe" start "" "C:\Program Files (x86)\Microsoft Office\root\Office16\excel.exe" %Account%_%day%%month%%year%_Inventory.csv
endlocal
