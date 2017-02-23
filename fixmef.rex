/* Fix mef file customer environment. */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.0  1/12/2016 */
rc = SysLoadFuncs()
home = directory()
Parse ARG oldenv newenv
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

finish:
