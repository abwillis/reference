@REM Version 1.2 MGR-DEVICES cleanup OS
@echo off
if exist *MGR* dir /b *MGR* >files.txt
echo %cd%>>files.txt
set filename=%1
set account=%2
goto text

:filenames
if [%1]==[] set /P filename=Enter filename 
if [%2]==[] set /P account=Enter account  
findstr /I /V "Device Status" %filename%>hold1.txt
findstr /I /V SHID hold1.txt>hold.txt
findstr /I /V storage hold.txt>%account%-DEVICES.csv
if [%1]==[] taskkill /fi "WINDOWTITLE eq files.txt*" >nul
if [%2]==[] taskkill /fi "WINDOWTITLE eq files.txt*" >nul
del files.txt
del hold.txt
del hold1.txt
goto end



:text
if [%1]==[] start "" notepad files.txt
if [%1]==[] goto filenames
if [%2]==[] start "" notepad files.txt
goto filenames


:end