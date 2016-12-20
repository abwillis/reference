@REM Create directories based on account and year.  Creates directories for all 4 quarters.
@REM Version 1.2
@echo off
if /I "%1" == "" goto usage
if /I "%2" == "" goto usage
if /I "%1" == "." goto dotted
if not exist c:\accounts md c:\accounts
cd c:\accounts
if exist %1 goto next
md %1
:next
cd %1
:dotted
for %%G IN (1Q%2 2Q%2 3Q%2 4Q%2) do (
  if not exist %%G md %%G
  if not exist %%G\data md %%G\data
  if not exist %%G\evidence md %%G\evidence
)
::for %%G IN (1Q%2 2Q%2 3Q%2 4Q%2) do if not exist %%G md %%G
::for %%G IN (1Q%2 2Q%2 3Q%2 4Q%2) do if not exist %%G\data md %%G\data
::for %%G IN (1Q%2 2Q%2 3Q%2 4Q%2) do if not exist %%G\evidence md %%G\evidence
if /I "%1" == "." goto current
cd ..
:current
goto end
:usage
@echo "Usage:  diryear account year"
@echo "Where account is the account name using underscore instead of space (use no spaces)"
@echo "If in the directory where you want the quarters built, you can use a dot instead of account name"
@echo "Where year is 2 digit year e.g. 16"
:end
@echo on