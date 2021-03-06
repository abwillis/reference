#! /usr/bin/rexx
/* Fix mef file customer environment. */
/* Envisioned, designed and written by Andy Willis */
/* Version 2.1.01  19Sep2017 */
rc = SysLoadFuncs()
home = directory()
Parse ARG oldenv newenv

if (oldenv == '') then call help

rc = SysFileTree(oldenv'*','file','FOI')
direc = Directory()
if (file.0 == 0) then call finish

do k = 1 to file.0
  invfilec = file.k
  invfile1 = changestr(direc'\',invfilec,'')
  invfile = changestr(direc'/',invfile1,'')
  newfile = strip(invfile,'l',oldenv)
  renfile = newenv||newfile

  do while lines(invfile)
	words = linein(invfile)
    Parse var words holdit'|'TheRest
    newwords = newenv'|'TheRest
	if TheRest <> '' then rc = lineout(renfile,newwords)
  end	
  rc = lineout(invfile)

  rc = SysFileDelete(invfile)
end

/*
rc = SysFileTree(newenv'*','file','FO')
direc = Directory()
*/
call finish

help:
say "This was primarily written to correct name environment issues."
say "Usage:  fixmef oldenv newenv"
say "fixmef with no arguments --  This screen"
say "If the only change is the case, currently it will need to be run twice,"
say "the first time with a temp name for the newenv and the second time with"
say "the temp name as the oldenv."



finish:
