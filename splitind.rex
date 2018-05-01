#! /usr/bin/rexx
/* Split into individual files manually collected mefs */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.1  1May2018 */
rc = SysLoadFuncs()
home = directory()

Parse Arg filename naming

do while(filename == '')
  say "What is the filename?"
  parse pull filename
end

do while(naming == '')
  say "What is the account_date?"
  parse pull naming
end  

rc = stream(filename,"c","open")
do While lines(filename)
  text = linein(filename)
  parse var text .'|'.'|'server'|'.
  rc = lineout(naming''server'.mef3',text)
end
rc = stream(filename,"c","close")


