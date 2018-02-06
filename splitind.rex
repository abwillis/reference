#! /usr/bin/rexx
/* Split into individual files manually collected mefs */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.0  5Feb2018 */
rc = SysLoadFuncs()
home = directory()

Parse Arg filename naming

rc = stream(filename,"c","open")
do While lines(filename)
  text = linein(filename)
  parse var text .'|'.'|'server'|'.
  rc = lineout(naming''server'.mef3',text)
end
rc = stream(filename,"c","close")


