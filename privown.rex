#! /usr/bin/rexx
/* Concatenate with commas privs for each email address */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.0.01  19Sep2017 */
/* System assumes Platform, priv, user name, user email */
/* Ouput will be email priv1,priv2,etc */

rc = SysLoadFuncs()
home = directory()
rc = SysFileDelete('privown.txt')
Parse ARG fileinv


if fileinv="" then do
  rc = SysFileTree('*.csv','init','FOI')
  do c = 1 to init.0
    say init.c
  end
  say "Inventory filename?"
  parse pull fileinv
end

enum.0 = 0
Do While Lines(fileinv)
  c1 = 0
  inven = LineIn(fileinv)
  parse var inven .','priv','.','email
  call emailnum
  if (deva.c1 == '') then deva.c1 = priv
  else deva.c1 = deva.c1','priv
end

do l = 1 to enum.0
rc = lineout('privown.txt',enum.l'  'deva.l)
end
call finish


emailnum:
/* find if email has been assigned a number and if so return it, if not assign one and return it */
if (enum.0 == 0) then do

  enum.0 = enum.0 + 1
  c1 = enum.0
  enum.1 = email
  deva.c1 = ''
end
else do k = 0 to enum.0
  parse var enum.k ckem
  if (ckem == email) then do
    c1 = k
    k = enum.0
  end
end
if (c1 == 0) then do
  enum.0 = enum.0 + 1
  j = enum.0
  enum.j = email
  c1 = enum.0
  deva.c1 = ''
end
return

finish:
  
