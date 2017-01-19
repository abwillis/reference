REM Install JnJ
@echo Installing JnJ
copy *.lnk "c:%HOMEPATH%\desktop"
IF NOT exist "c:%HOMEPATH%\Application DATA\ICAClient" md "c:%HOMEPATH%\Application DATA\ICAClient"
copy ICAClient\* "c:\%HOMEPATH%\Application Data\ICAClient"
type jnj-hosts.txt >>c:\windows\system32\drivers\etc\hosts
cd \msocache\mso
call unzip mso.zip
cd \accounts\jnj
REM rexx jnj-office.orx 
@echo Installation complete