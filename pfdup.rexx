/* Find duplicate mef files */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.1.1  1/26/2017 */
rc = SysLoadFuncs()
home = directory()

rc = SysFileDelete(dupcheck.csv)
rc = SysFileTree('*.mef3','file','FO')
if (file.0 == 0) then call finish
do k = 1 to file.0
/* Parse Var file.1 'Something'|'Something'|'device' */
invfile = file.k
text = LineIn(invfile,1,1)
Parse Upper Var text Something'|'Something'|'device'|'Something
rc = stream(invfile, 'c', 'close')
checkfile = '*'device'*.mef3'
rc = SysFileTree(checkfile,'howm','FO')
if (howm.0 == 0) then call endit
if (howm.0 > 1) then call names
endit:
end
call finish

names:
do x = 1 to howm.0
listfile = howm.x
say listfile 
rc = lineout('dupcheck.csv',listfile)
end
return

finish:
