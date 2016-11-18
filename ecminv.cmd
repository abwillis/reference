@REM Version 1.5 ECM csv Inventory cleanup
@echo off
set filename=%1
if [%1]==[] set /P filename=Enter filename 

del newfile.csv
del complete.csv
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
        echo !column[0]!;!column[1]!;!column[2]!;!column[3]!;!column[4]!;!column[5]!;!column[6]!;!column[7]!;!column[8]!;  >>complete.csv
)
endlocal