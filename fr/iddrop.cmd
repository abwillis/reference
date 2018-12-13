@echo on
:: Healthnet ID drop tool  version 1.0  1/27/2012
:: Envisioned, designed and written by Andy Willis
@echo "Please make sure that you have detached the ID file to the 'I:\ID Drops' folder"
Set /P Domain=Enter X for HNCorp or Y for FS 
Set /P Location=Enter City or Location 
Set /P empnum=Enter the employee number (CID or AID) 
Set /P idfile=Enter Notes ID filename (without the .id) 
If NOT exist %Domain%:\%Location%\%empnum%\notes mkdir %Domain%:\%Location%\%empnum%\notes
If NOT exist %Domain%:\%Location%\%empnum%\notes\data mkdir %Domain%:\%Location%\%empnum%\notes\data
If exist %Domain%:\%Location%\%empnum%\notes\data\*%idfile%* del %Domain%:\%Location%\%empnum%\notes\data\*%idfile%*
copy "I:\ID Drops\%idfile%.id" %Domain%:\%Location%\%empnum%\notes\data
if exist N:\%empnum% copy "I:\ID Drops\%idfile%.id" N:\%empnum%\notes\data
echo copy I:\notes\data\%idfile%.id "c:\documents and settings\%empnum%\local settings\application data\lotus\notes\data">%Domain%:\%Location%\%empnum%\notes\data\moveit.cmd
@ping -n 5 -w 1 127.0.0.1 >Nul