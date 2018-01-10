#! /usr/bin/rexx
/* Show server and domain that DNS error is caused by  */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.0  10Jan2018 */
rc = SysLoadFuncs()
home = directory()
rc = SysFileDelete('server-DNS.csv')
rc = SysFileTree('*.mef3','file','FO') /* Load list of mef3 files into file.x, total number of mef3 files into file.0 */

do k = 1 to file.0
  invfile = file.k
  rc = stream(invfile, 'c', 'open')
  do While Lines(invfile)
    text = LineIn(invfile)
  end
  rc = stream(invfile, 'c', 'close')
  Parse var text .'|'.'|'server'|'.'|'.'|'.'|'.'|'.'|'.'|'.'|'errors
  a = 1
  e.0 = a
  parse var errors e.a';'therest
  do while (therest <> '')
    a = a + 1
    e.0 = a
    parse var therest e.a';'therest
  end
  parse var e.a check'('domains')'
  if ((check <> 20) & (check <> 21)) then check = ''
/*  if (check <> '')  then rc = lineout('server-DNS.csv',server':'errors':'check':'domains) */
if (check <> '')  then rc = lineout('server-DNS.csv',server':'domains)
end  
  
  