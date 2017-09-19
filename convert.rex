#! /usr/bin/rexx
/* Proof of concept REXX MGR/MEF3 conversion */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.0.01  19Sep2017 */
rc = SysLoadFuncs()
home = directory()

Parse ARG mgrfile mefdir account

if (mgrfile == '') then do
  rc = SysFileTree('*.csv','init','FOI')
  do c = 1 to init.0
    say init.c
  end
  rc = directory('..')
  rc = SysFileTree('*.csv','csvs','FOI')
  do c = 1 to csvs.0
    say csvs.c
  end
  rc = directory(home)
  Say "Filename of devices (mgr01) file?"
  parse pull mgrfile
end
if (mgrfile == '') then call finish

if (mefdir == "") then do
  Say "What directory are the mef3 files in? Use . for current directory."
  parse pull mefdir
end
if (mefdir == '') then call finish

if (account = '') then do
  Say "For what account is this for?"
  parse pull account
end
if (account == '') then call finish

SysFileDelete(account'-recon.csv')

rc = directory(mefdir)
rc = SysFileTree('*.mef3','file','FO')
rc = directory(home)
if (file.0 == 0) then call finish

hostname.0 = 0
env.0 = 0
c1 = 1
Do While Lines(mgrfile)
  infor = LineIn(mgrgile)
  parse var infor hostname.c1';'.';'.';'env.c1';'.
  env.0 = c1
  hostname.0 = c1
  c1 = c1 + 1
end
if (hostname.0 == 0) then call finish

groups.0 = 0
d1 = 1
do m = 1 to file.0
  invfile = file.m
  text = LineIn(invfile,1,1)
  Parse Var text .'|'.'|'device1'|'.'|'UID'|'.'|'Label'|'stat'|'priv1'|'group
  Parse upper var device1 device'.'Something
  call checkit
  call addit
  rc = lineout(invfile)
end









checkit:
do i=1 to hostname.0
  if (device == hostname.i) then call addit
end
return

addit:

