/* Find servers to match ID/labels in mapfile */
/* Envisioned, designed and written by Andy Willis */
/* Version 2.0  4/17/2017 */
rc = SysLoadFuncs()
home = directory()
Parse ARG fileinv
if fileinv="" then do
rc = SysFileTree('..\*.csv','init','FOI')
  do c = 1 to init.0
    say init.c
  end
  say "Inventory filename?"
  parse pull fileinv
end
rc = directory(home)
output = 'UIDLAB.csv'
rc = SysFileDelete('output')

rc = SysFileTree('*.mef3','file','FOI')
if (file.0 == 0) then call finish

combined.0 = 0
n = 1
rc = stream(fileinv,"c","open read")
Do While Lines(fileinv)
  inven = LineIn(fileinv)
  Parse Var inven UID2','LAB2','.
  combined.n = changestr("'",UID2,'')','changestr('"',LAB2,'')
  n = n + 1
  combined.0 = combined.0 + 1
end  
rc = stream(fileinv,"c","close")
rc = lineout('output','UID,Label,hostname,OS')
do m = 1 to file.0
  invfile = file.m
  do while lines(invfile)
    text = LineIn(invfile)
    Parse Var text .'|'.'|'hostname'|'OS'|'UIDc'|'.'|'label'|'.
    Parse UPPER Var UIDc UID
	check = UID','label
	if (UID <> 'NOTaRealID-IEM') then 
    do n = 1 to combined.0
      Parse Var combined.n UIDLAB1
	  UIDLAB = changestr('"',UIDLAB1,'')
      if (check == UIDLAB) then rc = lineout('output',UIDLAB','hostname','OS)
	end
  end
  say m/file.0 * 100
end
rc = lineout(fileinv)

finish:

