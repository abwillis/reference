/* Find which mef3 files are missing */
/* Envisioned, designed and written by Andy Willis */
/* Version 2.1.1  4Aug2017 */

rc = SysLoadFuncs()
home = directory()
Parse ARG fileinv

if fileinv="" then do
rc = directory(..)
rc = SysFileTree('*.csv','init','FOI')
rc = directory(home)
  do c = 1 to init.0
    say init.c
  end
  say "Inventory filename?"
  Parse pull fileinv
end

rc = SysFileDelete('nomefs-jh.csv')
rc = SysFileDelete('nomefs.csv')

rc = SysFileTree('*.mef3','file','FOI')
if (file.0 == 0) then call finish
dev1 = "something"
device.0 = 0

do m = 1 to file.0
  invfile = file.m
  text = LineIn(invfile,1,1)
  Parse Upper Var text .'|'.'|'device1'|'.
  Parse var device1 device.m'.'.
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

