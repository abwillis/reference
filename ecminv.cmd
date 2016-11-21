@REM Version 2.5 ECM csv Inventory cleanup
@echo off
set filename=%1
if [%1]==[] set /P filename=Enter filename 

del newfile.csv
del Storage_complete_Inventory.csv
for /f "skip=3 delims=*" %%a in (%filename%) do (
echo %%a >>newfile.csv   
)
setlocal enableextensions enabledelayedexpansion
for /F "tokens=*" %%A in (newfile.csv) do (
    set LINE="%%A"
    for /F "tokens=2-7,21,26,* delims=;" %%a in (!LINE!) do (
		for /F "tokens=6 delims=;" %%Z in ("%%i") do (
			set column[8]=%%Z
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
        FOR /F "tokens=*" %%A IN ('DATE/T') DO FOR %%B IN (%%A) DO SET Today=%%B
			SET result=%Today:*/=%
			SET year=%result:*/=%
			CALL SET intermediate=%%result:%year%=%%
			SET day=%intermediate:/=%
			SET first=%Today:*/=%
			CALL SET intermediate=%%Today:%first%=%%
			set tmonth=%intermediate:/=%
			set track="Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec"
			for /F "tokens=%tmonth% delims=," %%y in (%track%) do (
				set month=%%y
			)
			echo !column[0]!;!column[1]!;!column[2]!;!column[3]!;!column[4]!;!column[5]!;!column[6]!;!column[7]!;!column[8]!;  >>Storage_complete_Inventory.csv
)
set /P Account=Account Name 
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
echo %day%
if exist %Account%_Storage_%day%%month%%year%_Inventory.csv ren %Account%_Storage_%day%%month%%year%_Inventory.csv %Account%_Storage_%day%%month%%year%_Inventory-%RANDOM%.csv
ren Storage_complete_Inventory.csv %Account%_Storage_%day%%month%%year%_Inventory.csv
IF EXIST "c:\Program Files (x86)\OpenOffice 4\program\scalc.exe" "c:\Program Files (x86)\OpenOffice 4\program\scalc.exe" %Account%_Storage_%day%%month%%year%_Inventory.csv
IF NOT EXIST "c:\Program Files (x86)\OpenOffice 4\program\scalc.exe" start "C:\Program Files (x86)\Microsoft Office\root\Office16\excel.exe" %Account%_Storage_%day%%month%%year%_Inventory.csv
endlocal