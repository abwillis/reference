@REM Version 2.0 ECM csv Inventory cleanup
@echo off
set filename=%1
if [%1]==[] set /P filename=Enter filename 

del newfile.csv
for /f "skip=3 delims=*" %%a in (%filename%) do (
echo %%a >>newfile.csv   
)
setlocal enableextensions enabledelayedexpansion
for /F "tokens=*" %%A in (newfile.csv) do (
    set LINE="%%A"
	set test=""
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
			echo !column[0]!;!column[1]!;!column[2]!;!column[3]!;!column[4]!;!column[5]!;!column[6]!;!column[7]!;!column[8]!;  >>Storage_%day%%month%%year%Inventory.csv
)
set /P Account=Account Name 
ren Storage_%day%%month%%year%Inventory.csv %Account%_Storage_%day%%month%%year%_Inventory.csv
IF EXIST "\Program Files (x86)\OpenOffice 4\program\scalc.exe" Start "\Program Files (x86)\OpenOffice 4\program\scalc.exe" %Account%_Storage_%day%%month%%year%_Inventory.csv
IF NOT EXIST "\Program Files (x86)\OpenOffice 4\program\scalc.exe" start "C:\Program Files (x86)\Microsoft Office\root\Office16\excel.exe" %Account%_Storage_%day%%month%%year%_Inventory.csv
endlocal