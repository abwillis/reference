/* Find which mef3 files are missing */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.7  4/11/2017 */
rc = SysLoadFuncs()
home = directory()
Parse ARG fileinv
if fileinv="" then pull fileinv

rc = SysFileDelete(dupcheck.csv)
rc = SysFileDelete(nomefs.csv)
rc = SysFileTree('*.mef3','file','FO')
if (file.0 == 0) then call finish
dev1 = "something"

rc = stream(fileinv,"c","open")
Do While Lines(fileinv)
inven = LineIn(fileinv)
Parse Upper Var inven dev1'|'TheRest
match = 0

do k = 1 to file.0
invfile = file.k
rc = stream(invfile,"c","open")
text = LineIn(invfile,1,1)
Parse Upper Var text Something'|'Something'|'device1'|'Something
Parse var device1 device'.'Something
if (dev1 == device) then match = 1
rc = lineout(invfile) /* The following stream close causes segmentation fault on Linux */
/* rc = stream(invfile, "c", "close") */
end

if (match == 0) then call names
end
rc = lineout(fileinv) /* The above stream close causes segmentation fault on Linux the below one did not but changing to lineout here just to be sure */
/* rc = stream(fileinv, "c", "close") */
call finish

names:
say dev1
rc = lineout('dupcheck.csv',dev1)
rc = lineout('nomefs.csv',dev1','TheRest)
return

finish:





