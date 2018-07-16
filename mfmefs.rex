#! /usr/bin/rexx
/* Create mef files from mainframe health-check files */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.0 16Jul2018 */

rc = SysLoadFuncs()
home = directory()

Parse Arg Account
if (Account == '') then do
Say "Account?"
Parse Pull Account
end
Today = Date('B')
TheDate = Date('N',Today,'B')
parse var TheDate day' 'Mon' 'year

rc = SysFileTree('*.hcf','file','FOI')
if (file.0 == 0) then call finish


do m = 1 to file.0
  invfile = file.m
  Desc = ''
  prim = ''
  priv = ''
  rc = stream(invfile,"c","open")
  do while Lines(invfile)
    text = LineIn(invfile)
    cnt = CountStr("userconfig",text)
    if (cnt > 0) then parse var text hostname':'.
    cnt = CountStr("Account name",text)
    if (cnt > 0) then parse var text .': 'User
    cnt = CountStr("Description:",text)
    if (cnt > 0) then parse var text .': 'Desc
    cnt = CountStr("Enabled",text)
    if (cnt > 0) then parse UPPER var text .': 'Enabled
    if (Enabled == 'YES') then Enable = 'ENABLED'
    if (Enabled == 'NO') then Enable = 'DISABLED'
    cnt = CountStr("Home LF Role",text)
    if (cnt > 0) then parse var text .': 'prim
    cnt = CountStr("Chassis Role",text)
    if (cnt > 0) then parse var text .': 'priv
    cnt = CountStr("Home LF:",text)
    if (cnt > 0) then do
      rc = lineout(Account'_'Day||Mon||Year'_'hostname'.mef3',Account'|S|'hostname'|MF Config|'User'||'Desc'|'Enable'||'Prim'|'priv)
      Desc = ''
      prim = ''
      priv = ''
    end
  end
  rc = stream(invfile,"c","close")
end
