/* Find servers to match ID/labels in mapfile */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.5  4/14/2017 */
rc = SysLoadFuncs()
home = directory()
Parse ARG fileinv
if fileinv="" then do
rc = SysFileTree('..\*.csv','init','FOI')
  do c = 1 to init.0
    say init.c
  end
  say "Inventory filename?"
  pull fileinv
end
rc = directory(home)
rc = SysFileDelete('UIDLAB.csv')

rc = SysFileTree('*.mef3','file','FOI')
if (file.0 == 0) then call finish

combined.0 = 0
n = 1
rc = stream(fileinv,"c","open")
Do While Lines(fileinv)
  inven = LineIn(fileinv)
  Parse Var inven UID2','LAB2','.
  combined.n = changestr("'",UID2,'')','changestr('"',LAB2,'')
  n = n + 1
  combined.0 = combined.0 + 1
end  
rc = lineout(fileinv)

do m = 1 to file.0
  invfile = file.m
  do while lines(invfile)
    text = LineIn(invfile)
    Parse Var text .'|'.'|'hostname'|'OS'|'UID'|'.'|'label'|'.
	check = UID','label
	if (UID <> 'NOTaRealID-IEM') then 
    do n = 1 to combined.0
      Parse Var combined.n UIDLAB1
	  UIDLAB = changestr('"',UIDLAB1,'')
      if (check == UIDLAB) then rc = lineout('UIDLAB.csv',OS','hostname','UIDLAB)
	end
  end
  say m/file.0 * 100
end
rc = lineout(fileinv)

finish:

