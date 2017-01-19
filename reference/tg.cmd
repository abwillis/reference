/* Delete Directory tool */
/* Define Rexx Functions */
n = SETLOCAL()
p = VALUE('deldir','','OS2ENVIRONMENT')
call RxFuncAdd 'SysFileTree', 'RexxUtil', 'SysFileTree'
call RxFuncAdd 'SysRmDir', 'RexxUtil', 'SysRmDir'
call RxFuncAdd 'SysFileDelete', 'RexxUtil', 'SysFileDelete'
call RxFuncAdd 'SysGetKey', 'RexxUtil', 'SysGetKey'
/* Make sure that this is truly what you want */
say "Is this TRULY what you want?  (Y/N)"
sure:
key = SysGetKey(noecho)	
select
 	when key = 'n'
		then exit
	when key = 'N'
		then exit
	when key <> 'y' 
		then If key <> 'Y'
			then signal sure
Otherwise
end

/* Check to make sure that the current directory (or previous or root) is not being deleted and that there is an argument */

select	
	when Arg(1) = ""
		then signal bye	
	when Arg(1) = '.'
		then signal bye
	when Arg(1) = '..'
		then signal bye
	when Arg(1) = '\'
		then signal bye
Otherwise  
End

/* Delete Directory */

MyArg = Arg(1)
If Left( MyArg,1 ) = '"' then 
Parse var MyArg '"' MyArg
If right( MyArg,1 ) = '"' then
Parse var MyArg MyArg '"'

rc = SysRmDir(MyArg)
/* check to make sure directory to be deleted is deleteable */
If rc = 0
	Then call SysRmDir MyArg
Else	   	
     if rc = 3 then signal bye
Else
	If rc = 5  /* Attempts to remove any readonly bits then deletes files and finally rd directories */
		Then
		Do
			call SysFileTree MyArg'\*.*', 'file', 'BSO', '***+*', '***-*'  /* removes readonly bit */
			call SysFileTree MyArg'\*.*', 'file', 'FSO'
				do i=1 to file.0
					call SysFileDelete file.i  /* deletes files in directories */
				end
			call SysFileTree MyArg'\*.*', 'direct', 'SDO'
			i = direct.0
			 
			do while i<>0
				call SysRmDir direct.i /* deletes directories in tree in necessary order */
				i = i - 1
			end 
			call SysRmDir MyArg /* deletes initial directory */
		end
 n = endlocal()	 
Exit

bye:
	say 'Invalid or nonexistent directory'
n = endlocal()
exit