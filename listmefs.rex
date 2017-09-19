/* Create a list of devices found in mef3 files */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.0  4/10/2017 */
rc = SysLoadFuncs()
home = directory()

rc = SysFileDelete('listmefs.csv')
rc = SysFileDelete('listmefs-nh.csv')
rc = SysFileTree('*.mef3','file','FO')
if (file.0 == 0) then call finish

do k = 1 to file.0
invfile = file.k
rc = stream(invfile,"c","open")
text = LineIn(invfile,1,1)
Parse Var text Something'|'Something'|'device1'|'Something
Parse var device1 device'.'Something
rc = lineout(invfile) 
rc = lineout('listmefs.csv',device1)
rc = lineout('listmefs-nh.csv',device)
end

/* rc = stream(fileinv, "c", "close") :::: This will cause segmentation fault on Linux if run many times */
finish:





