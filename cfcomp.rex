#! /usr/bin/rexx
/* Find matches in two files... assumes using first column in each, exact matches */
/* Envisioned, designed and written by Andy Willis */
/* Version 2.8.01  19Sep2017 */
rc = SysLoadFuncs()
home = directory()
rc = SysFileDelete('compcheck.csv')
rc = SysFileDelete('nomatch.csv')
rc = SysFileDelete('compfull.csv')
rc = SysFileDelete('nomatchfull.csv')
lognom1 = ""
Say
Say "Usage: Filename-1 Delimeter-1 Filename-2 Delimeter-2 nonmatches (optional, anything other than Y is no)"
Say
Parse ARG fileinv1 delim1 fileinv2 delim2 lognom1

if (delim1 <> ',') & (delim1 <> ';') & (delim1 <> ':') & (delim1 <> '|') & (delim1 <> '')  then do
  Say 'Bad first delimeter specified'
  delim1 = ""
  fileinv2 = ""
  delim2 = ""
  lognom1 = ""
end
if (delim2 <> ',') & (delim2 <> ';') & (delim2 <> ':') & (delim2 <> '|') & (delim2 <> '')  then do
  Say 'Bad second delimeter specified'
  delim2 = ""
  lognom1 = ""
end
if fileinv1 = "" then do
  Say "Filename of first file?"
  parse pull fileinv1
end
/* Seems to me the following should be OR (|) instead of AND (&) but did not work out that way */
do while ((delim1 <> ',') & (delim1 <> ';') & (delim1 <> ':') & (delim1 <> '|'))
  Say "Delimiters may be , ; : |"
  Say "Which delimeter do you want for first file?"
  parse pull Delim1
end
if fileinv2="" then do
  Say "Filename of second file?"
  parse pull fileinv2
end
if Delim2 = "" then do
  do while ((delim2 <> ',') & (delim2 <> ';') & (delim2 <> ':') & (delim2 <> '|'))
    Say "Delimiters may be , ; : |"
    Say "Which delimeter do you want for second file?"
    parse pull Delim2
  end
  if lognom1 = "" then do
    Say "Do you want to log non-matches? Anything other than Y is no."
	pull lognom1
  end	
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

    Parse Upper Var text devac (delim2) .

/* The following is to find the device name without knowing the delimiter... If there is no TheRest then no delimeter was found */
/* Possible downfall, if other character than delimter found prior to correct delimeter it may be seen as the delimter */
/* Downfall occurring to often, trying specify
	Parse Upper Var text devac','TheRest
    if (TheRest == "") then Parse Upper Var text devac';'TheRest
	if (TheRest == "") then Parse Upper Var text devac':'TheRest
    if (TheRest == "") then Parse Upper Var text devac'|'TheRest
*/
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
/*
 Parse Upper Var inven Some1','TheRest1
  if (TheRest1 == "") then Parse Upper Var inven Some1';'TheRest1
  if (TheRest1 == "") then Parse Upper Var inven Some1':'TheRest1
  if (TheRest1 == "") then Parse Upper Var inven Some1'|'TheRest1
*/

   Parse Upper Var inven Some1 (Delim1) .

  Parse Var Some1 ttt1'"'hhh1'"'TheRest
	if (ttt <> '') then do
	  Something1 = ttt1 
	end
	else do
	  Something1 = hhh1
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
rc = lineout('compfull.csv',inven)
return

nonames:
rc = lineout('nomatch.csv',something1)
rc = lineout('nomatchfull.csv',inven)
return

finish:





