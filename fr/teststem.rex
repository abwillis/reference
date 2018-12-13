/* Find which mef3 files are missing */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.8  4/11/2017 */
rc = SysLoadFuncs()
home = directory()
Parse ARG fileinv

rc = SysFileDelete(dupcheck.csv)
rc = SysFileDelete(nomefs.csv)
rc = SysFileTree('*.mef3','file','FO')
if (file.0 == 0) then call finish
dev1 = "something"
device.0 = 0
do m = 1 to file.0
invfile = file.m
rc = stream(invfile,"c","open")
text = LineIn(invfile,1,1)
Parse Upper Var text Something'|'Something'|'device1'|'Something
Parse var device1 device.m'.'Something
rc = lineout(invfile)
device.0 = device.0 + 1
end

do n = 1 to device.0
  say device.n
end

finish: