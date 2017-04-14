/* Find servers to match ID/labels in mapfile */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.0  4/14/2017 */
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
dev1 = "something"
combined.0 = 0

do m = 1 to file.0
  invfile = file.m
  do while lines(invfile)
    text = LineIn(invfile)
    Parse Var text .'|'.'|'hostname'|'.'|'UID'|'.'|'label'|'.
    combined.m = hostname'|'UID','label
    rc = lineout(invfile)
    combined.0 = combined.0 + 1
  end
end

rc = stream(fileinv,"c","open")
Do While Lines(fileinv)
  inven = LineIn(fileinv)
  Parse Var inven "'"UID2','label2','.
  check = UID2','label2
  match = 0
  lineout('UIDLAB.csv',check)

  do k = 1 to combined.0
    Parse Var combined.k host'|'UIDLAB
    if (check == UIDLAB) then lineout('UIDLAB.csv',host)
  end
end
rc = lineout(fileinv)

finish:

