#! /usr/bin/rexx
/* Find extra mef files */
/* Envisioned, designed and written by Andy Willis */
/* Version 2.3.01  19Sep2017 */
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
  parse pull fileinv
end

deva.0 = 0
c1 = 1
Do While Lines(fileinv)
    devac = ''
	ttt = ''
	hhh = ''
	TheRest = ''
    inven = LineIn(fileinv)
	Parse Upper Var inven devac','TheRest
    if (TheRest == "") then Parse Upper Var inven devac';'TheRest
	if (TheRest == "") then Parse Upper Var inven devac':'TheRest
    if (TheRest == "") then Parse Upper Var inven devac'|'TheRest
	Parse Upper Var devac ttt'"'hhh'"'TheRest
	if (ttt <> '') then do
	  deva.c1 = ttt
	end
	else do
	  deva.c1 = hhh
	end
    deva.0 = c1
	c1 = c1 + 1
end
rc = lineout(fileinv)

rc = SysFileDelete('extramef.csv')
rc = SysFileDelete('extramef-h.csv')
rc = SysFileDelete('extramef-b.csv')

rc = SysFileTree('*.mef3','file','FOI')
if (file.0 == 0) then call finish

do k = 1 to file.0
  invfile = file.k
  text = LineIn(invfile,1,1)
  Parse Upper Var text Something'|'Something'|'device'|'Something
  rc = stream(invfile, 'c', 'close')
  match = 0
  
  Do md = 1 to deva.0
    if (device == deva.md) then do 
       match = 1
       end
       else do
       Parse var device devt'.'.
       if (devt == deva.md) then match = 1
       end
  end
 
 if (match == 0) then call names
 match = 0
end

call finish

names:
say device
rc = lineout('extramef.csv',invfile) 
rc = lineout('extramef-h.csv',device)
rc = lineout('extramef-b.csv',invfile)
rc = lineout('extramef-b.csv',device)
return

finish:





