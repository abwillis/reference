if /I "%1" == "" goto usage
if /I "%2" == "" goto usage
cd c:\accounts
if exist %1 goto next
md %1
:next
cd %1
if not exist %2 md %2
if not exist %2\data md %2\data
if not exist %2\evidence md %2\evidence
cd ..
goto end
:usage
echo "Usage:  dircode account quarter/year"
echo "Where account is the account name using underscore instead of space"
echo "Where quarter/year is in as e.g. 4Q16"
:end