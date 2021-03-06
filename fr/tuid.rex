/* Find servers to match ID/labels in mapfile */
/* Envisioned, designed and written by Andy Willis */
/* Version test 1.4  4/14/2017 */
rc = SysLoadFuncs()
home = directory()
Parse ARG fileinv
if fileinv="" then do
rc = SysFileTree('..\*.csv','init','FOI')
  do c = 1 to init.0
    say init.c
  end
  say "Inventory filename?"
  Parse pull fileinv
end
rc = directory(home)
output = 'tuid.csv'
rc = SysFileDelete(output)

rc = SysFileTree('*.mef3','file','FOI')
if (file.0 == 0) then call finish

combined.0 = 0
n = 1
do m = 1 to file.0
  invfile = file.m
  do while lines(invfile)
    text = LineIn(invfile)
    Parse Var text .'|'.'|'hostname'|'OS'|'UIDc'|'.'|'label'|'.
    Parse UPPER Var UIDc UID
    if (UID <> 'NOTaRealID-IEM') then hold = changestr("'",hostname'|'OS'|'UID','label,'')
    combined.n = changestr("'",hold,'')
    n = n + 1
    combined.0 = combined.0 + 1
  end
rc = lineout(invfile)
/*  say m/file.0 * 100 */
end

rc = stream(fileinv,"c","open read")
say "mef part done"
Do While Lines(fileinv)
  inven = LineIn(fileinv)
  Parse Var inven UID2','LAB2','.
  check = changestr('"',(changestr("'",UID2,'')','LAB2),'')
  rc = lineout(output,check' --------------------')

  do k = 1 to combined.0
    Parse Var combined.k host'|'OS1'|'UIDLAB
    if (check == UIDLAB) then rc = lineout(output,host','OS1)
    if (check == UIDLAB) then say rc ' rc ' host ' host '
  end
end
rc = lineout(fileinv)

finish:
