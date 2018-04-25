@REM Create Directories based on account and quarter/year.
@REM Version 2.9 25Apr2018
@echo off
if /I "%1" == "" goto usage
if /I "%1" == "genpar" goto usage
if /I "%2" == "" goto usage
if /I "%2" == "genpar" goto usage
if /I "%1" == "." goto dotted
cd \accounts
if exist %1 goto next
md %1
:next
cd %1
:dotted
if not exist %2 md %2
if not exist %2\data md %2\data
if not exist %2\evidence md %2\evidence
if not exist %2\extra md %2\extra
if not exist %2\hold md %2\hold
if not exist %2\rem md %2\rem
if not exist %2\recon md %2\recon
if not exist %2\reports md %2\reports
if /I "%3" == "" goto skipped
if not exist %2\csvcur md %2\csvcur
if not exist %2\csvprev md %2\csvprev
if not exist %2\mefcur md %2\mefcur
if not exist %2\mefprev md %2\mefprev
if not exist %2\doneprev md %2\doneprev
if not exist %2\donecurr md %2\donecurr
if not exist %2\delta md %2\delta 
:skipped
if /I "%1" == "." goto current 
cd ..
:current
goto end
:usage
@echo Usage:  dircode account quarter/year genpar
@echo Where account is the account name using underscore instead of space
@echo If in the directory where you want the quarter built, you can use a dot instead of account name
@echo Where quarter/year is in as e.g. 1Q17
@echo Where genpar is optional if account is URT, it creates directories for genpar.
@echo e.g.   dircode newaccount 1Q17 genpar  :  diryear newaccount 2Q17  :
@echo        diryear . 3Q17 genpar  :  diryear . 4Q17
:end
