/* Find matches in two files... assumes using first column in each, exact matches */
/* Envisioned, designed and written by Andy Willis */
/* Version 2.1  04May2017 */
rc = SysLoadFuncs()
home = directory()
rc = SysFileDelete('compcheck.csv')
rc = SysFileDelete('nomatch.csv')
lognom1 = ""

Parse ARG fileinv1 fileinv2 lognom1

if fileinv1="" then do
  Say "Filename of first file?"
  parse pull fileinv1
end
if fileinv2="" then do
  Say "Filename of second file?"
  parse pull fileinv2
  if lognom1="" then do
    Say "Do you want to log non-matches? Y/N"
	pull lognom1
  end	
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
  Parse Upper Var inven Some1','TheRest
  if (TheRest == "") then Parse Upper Var inven Some1';'TheRest
  if (TheRest == "") then Parse Upper Var inven Some1':'TheRest
  if (TheRest == "") then Parse Upper Var inven Some1'|'TheRest
  Parse Var Some1 ttt'"'hhh'"'TheRest
	if (ttt <> '') then do
	  Something1 = ttt 
	end
	else do
	  Something1 = hhh
	end
    
  match = 0

  Do m = 1 to Something2.0
    if (something1 == Something2.m) then do
      match = 1
      m = Something2.0
    end
  end
  if (match == 1) then call names
  if (match == 0) & (lognom == 'Y') then call nonames

end
rc = lineout(fileinv1)
say howmany " records in first file"
say nummatches " matches"
call finish

names:
/* say something1 */
nummatches = nummatches + 1
rc = lineout('compcheck.csv',something1)
return

nonames:
rc = lineout('nomatch.csv',something1)
return

finish:





