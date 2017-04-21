/* Find matches in two files... assumes using first column in each, exact matches */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.8  4/13/2017 */
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
	  say "else"
	  Something2.c1 = hhh
	end
    Something2.0 = c1
	c1 = c1 + 1

end

rc = lineout(fileinv2)

Do While Lines(fileinv1)
  inven = LineIn(fileinv1)
  Parse Upper Var inven '"'Something1'"'TheRest
  if (Something1 == "") then Parse Upper Var inven Something1','TheRest
  if (TheRest == "") then Parse Upper Var inven Something1':'TheRest
  if (TheRest == "") then Parse Upper Var inven Something1';'TheRest
  if (TheRest == "") then Parse Upper Var inven Something1'|'TheRest
  match = 0

  Do m = 1 to Something2.0
    if (something1 == Something2.m) then match = 1
  end
  if (match == 1) then call names
  if (match == 0) & (lognom == 'Y') then call nonames

end
rc = lineout(fileinv1)
call finish

names:
say something1
rc = lineout('compcheck.csv',something1)
return

nonames:
rc = lineout('nomatch.csv',something1)
return

finish:





