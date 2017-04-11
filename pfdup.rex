/* Find duplicate mef files */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.2  4/11/2017 */
rc = SysLoadFuncs()
home = directory()

rc = SysFileDelete(dupcheck.csv)
rc = SysFileTree('*.mef3','file','FOI')
if (file.0 == 0) then call finish
do k = 1 to file.0
/* Parse Var file.1 'Something'|'Something'|'device' */
invfile = file.k
text = LineIn(invfile,1,1)
Parse Upper Var text Something'|'Something'|'device'|'Something
rc = LineOut(invfile) /*stream close will seg fault after many uses on linux */
/* rc = stream(invfile, 'c', 'close') */
if (device == '') then signal badstuff
checkfile = '*'device'.mef3'
rc = SysFileTree(checkfile,'howm','FOI')
if (howm.0 == 0) then signal wrongstuff
else if (howm.0 > 1) then call names
end
call finish

names:
do x = 1 to howm.0
listfile = howm.x
say listfile 
rc = lineout('dupcheck.csv',listfile)
end
return


badstuff:
Say 'Something bad, empty hostname field in' 
say invfile
signal finish

wrongstuff:
Say 'Something wrong, no file found with hostname'
say invfile
signal finish

finish:
