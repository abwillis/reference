@REM Create directories based on account and year.  Creates directories for all 4 quarters.
@REM Version 2.8 24Apr2018
@echo off
if /I "%1" == "" goto usage
if /I "%1" == "genpar" goto usage
if /I "%2" == "" goto usage
if /I "%2" == "genpar" goto usage
if /I "%1" == "." goto dotted
if not exist \accounts md \accounts
cd \accounts
if exist %1 goto next
md %1
:next
cd %1
:dotted
for %%G IN (1Q%2 2Q%2 3Q%2 4Q%2) do (
  if not exist %%G md %%G
  if not exist %%G\data md %%G\data
  if not exist %%G\evidence md %%G\evidence
  if not exist %%G\extra md %%G\extra
  if not exist %2\hold md %2\hold
  if not exist %2\rem md %2\rem
  if not exist %2\recon md %2\recon
)
if "%3" == "" goto skipped
for %%G IN (1Q%2 2Q%2 3Q%2 4Q%2) do (
  if not exist %%G\csvcur md %%G\csvcur
  if not exist %%G\csvprev md %%G\csvprev
  if not exist %%G\mefcur md %%G\mefcur
  if not exist %%G\mefprev md %%G\mefprev
  if not exist %%G\doneprev md %%G\doneprev
  if not exist %%G\donecurr md %%G\donecurr
  if not exist %%G\delta md %%G\delta  
)
:skipped
if /I "%1" == "." goto current
cd ..
:current
goto end
:usage
@echo Usage:  diryear account year genpar
@echo Where account is the account name using underscore instead of space (use no spaces)
@echo If in the directory where you want the quarters built, you can use a dot instead of account name
@echo Where year is 2 digit year e.g. 17
@echo Where genpar is optional if account is URT, it creates directories for genpar.
@echo e.g.   diryear newaccount 17 genpar  :  diryear newaccount 17  :
@echo        diryear . 17 genpar  :  diryear . 17
:end
@echo on
