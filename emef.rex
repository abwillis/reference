/* Find extra mef files */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.4  4/11/2017 */
rc = SysLoadFuncs()
home = directory()
Parse ARG fileinv
if fileinv="" then do
  rc = SysFileTree('..\*.csv','init','FO')
  if (init.0 == 0) then rc = SysFileTree('../*.csv','init','FOI')
  do c = 1 to init.0
    say init.c
  end
  say "Inventory filename?"
  pull fileinv
end

dev1.0 = 0
c1 = 1
Do While Lines(fileinv)
    inven = LineIn(fileinv)
    Parse Upper Var inven '"'dev1.c1'"'TheRest
    if (dev1.c1 == "") then Parse Upper Var inven dev1.c1','TheRest
	if (TheRest == "") then Parse Upper Var inven dev1.c1':'TheRest
    if (TheRest == "") then Parse Upper Var inven dev1.c1';'TheRest
    if (TheRest == "") then Parse Upper Var inven dev1.c1'|'TheRest
	c1 = c1 + 1
    dev1.0 = dev1.0 + 1
end
rc = lineout(fileinv)

rc = SysFileDelete('extramef.csv')
rc = SysFileTree('*.mef3','file','FOI')
if (file.0 == 0) then call finish
dev1 = "something"


do k = 1 to file.0
  invfile = file.k
  text = LineIn(invfile,1,1)
  Parse Upper Var text Something'|'Something'|'device'|'Something
  rc = stream(invfile, 'c', 'close')
  match = 0
  
  Do m = 1 to dev1.0
    if (dev1.m == device) then match = 1
  end
 
 if (match == 0) then call names
end
call finish

names:
say device 
rc = lineout('extramef.csv',device)
return

finish:





