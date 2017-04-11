/* Find extra mef files */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.2  4/11/2017 */
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

rc = SysFileDelete('extramef.csv')
rc = SysFileTree('*.mef3','file','FO')
if (file.0 == 0) then call finish
dev1 = "something"


do k = 1 to file.0
  invfile = file.k
  text = LineIn(invfile,1,1)
  Parse Upper Var text Something'|'Something'|'device'|'Something
  rc = stream(invfile, 'c', 'close')
  match = 0
  Do While Lines(fileinv)
    inven = LineIn(fileinv)
    Parse Upper Var inven '"'dev1'"'TheRest
    if (dev1 == "") then Parse Upper Var inven dev1','TheRest
	if (TheRest == "") then Parse Upper Var inven dev1':'TheRest
    if (TheRest == "") then Parse Upper Var inven dev1';'TheRest
    if (TheRest == "") then Parse Upper Var inven dev1'|'TheRest
    if (dev1 == device) then match = 1
  end
 
 if (match == 0) then call names
  rc = stream(fileinv, 'c', 'close')
end
call finish

names:
say device 
rc = lineout('extramef.csv',device)
return

finish:





