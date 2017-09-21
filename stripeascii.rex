#! /usr/bin/rexx
/* Remove extended ascii characters */
/* Envisioned, designed and written by Andy Willis */
/* Version test 1.0  21Sep2017 */
rc = SysLoadFuncs()
home = directory()
Parse ARG fileinv

above = xrange('80'x,'FF'x) /* Needed due to possible extended ascii we will check below */
below = xrange('00'x,'1F'x)
output = 'stripped.csv'
rc = SysFileDelete(output)

rc = stream(fileinv,"c","open read")
Do While Lines(fileinv)
  inven = LineIn(fileinv)
  select 
      when (verify(inven,below,'M') <> 0) then LAB3 = space(translate(inven,,below))' -extendedascii'
      when (verify(inven,above,'M') <> 0) then LAB3 = space(translate(inven,,above))' -extendedascii'
      otherwise LAB3 = inven
  end
/*  check = changestr('"',(changestr("'",UID2,'')','LAB3),'') */

 rc = lineout(output,LAB3)

end
rc = lineout(fileinv)