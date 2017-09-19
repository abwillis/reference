#! /usr/bin/rexx
/* Specific use case, need to pull lines from recon file for certain servers. */
/* Envisioned, designed and written by Andy Willis */
/* Version 2.3.01  19Sep2017 */
rc = SysLoadFuncs()
home = directory()
rc = SysFileDelete('reconstuff.csv')

Parse ARG fileinv1 fileinv2 lognom1

if fileinv1="" then do
  Say "Filename of recon file?"
  parse pull fileinv1
end
if fileinv2="" then do
  Say "Filename of server file?"
  parse pull fileinv2
end

if ((fileinv1=='nomatch.csv') | (fileinv2=='nomatch.csv')) then do
  say "Nomatch.csv used by this program and as we already deleted it, if we were to proceed the comparison would be bogus."
  call finish
end 

Parse Upper Var lognom1 lognom +1 .

Something2.0 = 0
c1 = 1

Do While Lines(fileinv2)
    devac = ''
	ttt = ''
	hhh = ''
	TheRest = ''
    text = LineIn(fileinv2)
	Parse Upper Var text devac','TheRest
    if (TheRest == "") then Parse Upper Var text devac';'TheRest
	if (TheRest == "") then Parse Upper Var text devac':'TheRest
    if (TheRest == "") then Parse Upper Var text devac'|'TheRest
	Parse Var devac ttt'"'hhh'"'TheRest
	if (ttt <> '') then do
	  Something2.c1 = ttt 
	end
	else do
	  Something2.c1 = hhh
	end
    Something2.0 = c1
	c1 = c1 + 1

end

Say c1-1 " records in Second file"

rc = lineout(fileinv2)
howmany = 0
nummatches = 0
Do While Lines(fileinv1)
howmany = howmany + 1
  inven = LineIn(fileinv1)
  Parse Upper Var inven .':'.':'server':'.
    
  match = 0

  Do m = 1 to Something2.0
    if (server == Something2.m) then do
      match = 1
      m = Something2.0
    end
  end
  if (match == 1) then call names

end
rc = lineout(fileinv1)
say howmany " records in first file"
say nummatches " matches"
call finish

names:
nummatches = nummatches + 1
rc = lineout('reconstuff.csv',inven)
return



finish:





