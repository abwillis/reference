@REM Create directories based on account and year.  Creates directories for all 4 quarters.
@REM Version 1.0.01
@echo off
if /I "%1" == "" goto usage
if /I "%2" == "" goto usage
cd c:\accounts
if exist %1 goto next
md %1
:next
cd %1
for %%G IN (1Q%2 2Q%2 3Q%2 4Q%2) do (
  if not exist %%G md %%G
  if not exist %%G\data md %%G\data
  if not exist %%G\evidence md %%G\evidence
)
::for %%G IN (1Q%2 2Q%2 3Q%2 4Q%2) do if not exist %%G md %%G
::for %%G IN (1Q%2 2Q%2 3Q%2 4Q%2) do if not exist %%G\data md %%G\data
::for %%G IN (1Q%2 2Q%2 3Q%2 4Q%2) do if not exist %%G\evidence md %%G\evidence
cd ..
goto end
:usage
@echo "Usage:  diryear account year"
@echo "Where account is the account name using underscore instead of space"
@echo "Where year is 2 digit year e.g. 16"
:end
@echo on