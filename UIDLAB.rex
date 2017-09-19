#! /usr/bin/rexx
/* Find servers to match ID/labels in mapfile */
/* Envisioned, designed and written by Andy Willis */
/* Version 2.4.11  9/19/2017 */
rc = SysLoadFuncs()
home = directory()
Parse ARG fileinv /* This file can be anywhere, even if not specified on the command line but listing will only be of most likley location */

if fileinv="" then do
rc = directory(..)
rc = SysFileTree('*.csv','init','FOI')
rc = directory(home)
  do c = 1 to init.0
    say init.c
  end
  say "Path (in relation to "home") and filename of inventory file? "
  parse pull fileinv
end

above = xrange('80'x,'FF'x) /* Needed due to possible extended ascii we will check below */
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

  if (verify(LAB2,above,'M') <> 0) then do
    LAB3 = space(translate(LAB2,,above))' -extendedascii'
  end
  else do
    LAB3 = LAB2
  end

  combined.n = changestr("'",UID2,'')','changestr('"',LAB3,'')
  n = n + 1
  combined.0 = combined.0 + 1
end  
rc = stream(fileinv,"c","close")

rc = lineout(output,'UID,Label,hostname,OS')

do m = 1 to file.0
  invfile = file.m
  do while lines(invfile)
    text = LineIn(invfile)
    Parse Var text .'|'.'|'hostname'|'OS'|'UIDc'|'.'|'label1'|'.
    Parse UPPER Var UIDc UID

    if (verify(label1,above,'M') <> 0) then do
      label = space(translate(label1,,above))' -extendedascii'
    end
    else do
      label = label1
    end

    check = UID','label
    if ((UID <> 'NOTaRealID-IEM') & (UID <> 'NOTaRealID')) then 
      do j = 1 to combined.0
      Parse Var combined.j UIDLAB1
      UIDLAB = changestr('"',UIDLAB1,'')
      if (check == UIDLAB) then do
        rc = lineout(output,UIDLAB','hostname','OS)
      end
    end
  end
say m/file.0 * 100
end
rc = lineout(fileinv)

finish:

