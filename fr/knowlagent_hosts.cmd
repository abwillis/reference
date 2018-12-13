:: Add Knowlagent hosts file entry 1.0 27/May/2011
@echo off
c:
find /C /I "ibm-eus-ag.knowlagentondemand.com" c:\windows\system32\drivers\etc\hosts 1>>NUL 2>&1
if %ERRORLEVEL% == 0 ( echo ibm-eus-ag.knowlagentondemand.com is already in hosts - NO CHANGE
) else (
attrib -r c:\windows\system32\drivers\etc\hosts
echo:>>c:\windows\system32\drivers\etc\hosts
echo 9.49.248.149    ibm-eus-ag.knowlagentondemand.com>>c:\windows\system32\drivers\etc\hosts
attrib +r c:\windows\system32\drivers\etc\hosts
)
@echo Done
:: Ping to wait for 4 seconds
@ping -n 3 -w 1 127.0.0.1 >Nul
@echo on