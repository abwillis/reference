/* Find matches in two files... assumes using first column in each, exact matches */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.1.1  4/11/2017 */
rc = SysLoadFuncs()
home = directory()
/* 
Parse ARG fileinv
if fileinv="" then pull fileinv
*/
pull fileinv1
pull fileinv2


Do While Lines(fileinv1)
  inven = LineIn(fileinv1)
  Parse Upper Var inven '"'Something1'"'TheRest
  if (Something1 == "") then Parse Upper Var inven Something1','TheRest
  if (TheRest == "") then Parse Upper Var inven Something1':'TheRest
  if (TheRest == "") then Parse Upper Var inven Something1';'TheRest
  if (TheRest == "") then Parse Upper Var inven Something1'|'TheRest
  match = 0

  Do While Lines(fileinv2)
    text = LineIn(fileinv2)
    Parse Upper Var inven '"'Something2'"'TheRest
    if (Something2 == "") then Parse Upper Var inven Something2','TheRest
    if (TheRest == "") then Parse Upper Var inven Something2':'TheRest
    if (TheRest == "") then Parse Upper Var inven Something2';'TheRest
    if (TheRest == "") then Parse Upper Var inven Something2'|'TheRest
    if (something1 == something2) then match = 1
  end
  if (match == 1) then call names
  rc = lineout(fileinv2)
end
rc = lineout(fileinv1)
call finish

names:
say something1 
rc = lineout('dupcheck.csv',device)
return

finish:





