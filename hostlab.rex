/* Find servers to match ID/labels in mapfile */
/* Envisioned, designed and written by Andy Willis */
/* Version test 1.6  4/18/2017 */
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
above = xrange('80'x,'FF'x) /* Needed due to possible extended ascii we will check below */
output = 'hostlab.csv'
rc = SysFileDelete(output)

rc = SysFileTree('*.mef3','file','FOI')
if (file.0 == 0) then call finish

combined.0 = 0
n = 1
do m = 1 to file.0
  invfile = file.m
  do while lines(invfile)
    text = LineIn(invfile)
    Parse Var text .'|'.'|'hostname'|'OS'|'UIDc'|'.'|'label1'|'.
    if (verify(label1,above,'M') <> 0) then do
      label = space(translate(label1,,above))' -extendedascii'
    end
    else do
      label = label1
    end
    Parse UPPER Var UIDc UID
    if ((UID <> 'NOTaRealID-IEM') & (UID <> 'NOTaRealID')) then hold = changestr("'",hostname'|'OS'|'UID','label,'')
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
  if (verify(LAB2,above,'M') <> 0) then do
    LAB3 = space(translate(LAB2,,above))' -extendedascii'
  end
  else do
    LAB3 = LAB2
  end
  check = changestr('"',(changestr("'",UID2,'')','LAB3),'')
  rc = lineout(output,check' --------------------')

  do k = 1 to combined.0
    Parse Var combined.k host'|'OS1'|'UIDLAB
    if (check == UIDLAB) then rc = lineout(output,host','OS1)
  end
end
rc = lineout(fileinv)

finish:
