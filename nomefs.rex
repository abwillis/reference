/* Find which mef3 files are missing */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.9.1  4/11/2017 */
rc = SysLoadFuncs()
home = directory()
Parse ARG fileinv
if fileinv="" then do
rc = SysFileTree('..\*.csv','init','FO')
  do c = 1 to init.0
    say init.c
  end
  say "Inventory filename?"
  pull fileinv
end
rc = directory(home)
rc = SysFileDelete(nomefs-jh.csv)
rc = SysFileDelete(nomefs.csv)
rc = SysFileTree('*.mef3','file','FO')
if (file.0 == 0) then call finish
dev1 = "something"
device.0 = 0

do m = 1 to file.0
  invfile = file.m
  text = LineIn(invfile,1,1)
  Parse Upper Var text Something'|'Something'|'device1'|'Something
  Parse var device1 device.m'.'Something
  rc = lineout(invfile)
  device.0 = device.0 + 1
end

rc = stream(fileinv,"c","open")
Do While Lines(fileinv)
  inven = LineIn(fileinv)
  Parse Upper Var inven dev1','TheRest
  match = 0

  do k = 1 to device.0
    if (dev1 == device.k) then match = 1
  end

  if (match == 0) then call names
end
rc = lineout(fileinv) /* Stream close in linux can cause segmentation fault if used "too" many times. */
/* rc = stream(fileinv, "c", "close") */

call finish

names:
say dev1
rc = lineout('nomefs-jh.csv',dev1)
rc = lineout('nomefs.csv',dev1','TheRest)
return

finish:

