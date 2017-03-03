/* Fix mef file customer environment. */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.0  1/12/2017 */
rc = SysLoadFuncs()
home = directory()
Parse ARG oldenv newenv
if (oldenv == 'help') then call help
rc = SysFileTree(oldenv'*','file','FO')
direc = Directory()
if (file.0 == 0) then call finish
do k = 1 to file.0
invfilec = file.k
invfile = changestr(direc'\',invfilec,'')
newfile = changestr(oldenv,invfile,'')
renfile = newenv||newfile
/* ADDRESS CMD ren invfile renfile */
do while lines(invfile)
	words = linein(invfile)
	newwords = changestr(oldenv,words,newenv)
	rc = lineout(renfile,newwords)
end	
rc = lineout(invfile)


ADDRESS CMD del invfile
end

rc = SysFileTree(newenv'*','file','FO')
direc = Directory()
call finish

help:
say "This was primarily written to correct name environment issues."
say "Usage:  fixmef oldenv newenv"
say "fixmef help   This screen"
say "If the only change is the case, currently it will need to be run twice,"
say "the first time with a temp name for the newenv and the second time it"
say "the temp name will be the oldenv."


finish: