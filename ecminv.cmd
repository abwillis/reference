REM Version 0.9 ECM csv Inventory cleanup
@echo off
del newfile.csv
del complete.csv
for /f "skip=3 delims=*" %%a in (%1) do (
echo %%a >>newfile.csv   
)
setlocal enableextensions enabledelayedexpansion
SET /A COUNT=0
for /F "tokens=*" %%A in (newfile.csv) do (
    set LINE="%%A"
    set /A COUNT+=1
    for /F "tokens=2-7,21,26,32 delims=;" %%a in (!LINE!) do (
        set row[0]=%%a
        set row[1]=%%b
        set row[2]=%%c
        set row[3]=%%d
        set row[4]=%%e
        set row[5]=%%f
		set row[6]=%%g
		set row[7]=%%h
		set row[8]=%%i
)
        echo !row[0]!;!row[1]!;!row[2]!;!row[3]!;!row[4]!;!row[5]!;!row[6]!;!row[7]!;!row[8]!;  >>complete.csv
)
endlocal