@echo off
: OCT292010 - v1.0 - updated ID and Password to the AG domain
: NOV102010 - v1.1 - corrected comment delimiter
:
@echo Backup commencing
net use /delete q: 2>nul >nul
net use q: \\9.17.50.72\sbdbackup /user:sbdbackupuser Welcome2IBM /persistent:no >nul
q:
cd "DataStore-UnCapped"
Call SBDIC_Backup.exe
c:
net use q: /delete
@echo Backup complete
