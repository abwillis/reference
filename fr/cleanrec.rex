#! /usr/bin/rexx
/* Removes devices UAT did not like for recon */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.0  26Oct2017 */

rc = SysLoadFuncs()
home = directory()

Parse ARG fileinv1 fileinv2

if (fileinv1 == "") then do
  Say "Filename of first file?"
  parse pull fileinv1
end

if (fileinv2 == "") then do
  Say "Filename of second file?"
  parse pull fileinv2
end

rc = SysFileDelete('new-'fileinv1)
rc = SysFileDelete('new-'fileinv2)

c = 0
Do While Lines(fileinv2)
  c = c + 1
  text = LineIn(fileinv2)
  parse var text .': 'remov.c
end
remov.0 = c

Do while lines(fileinv1)
  theline = linein(fileinv1)
  parse var theline .':'First':'Second':'.
  match = 0
  do i = 1 to remov.0
    if (remov.i == First':'Second) then do
      match = 1
      i = remov.0
    end
  end
  If (match == 0) then rc = lineout('new-'fileinv1,theline)
  else rc = lineout('new-'fileinv2,theline)
end
