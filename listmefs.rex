#! /usr/bin/rexx
/* Create a list of devices found in mef3 files */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.2  07Feb2018 */
rc = SysLoadFuncs()
home = directory()

rc = SysFileDelete('listmefs.csv')
rc = SysFileDelete('listmefs-nh.csv')
rc = SysFileTree('*.mef3','file','FO')
if (file.0 == 0) then call finish

do k = 1 to file.0
  invfile = file.k
  rc = stream(invfile,"c","open")
  text = LineIn(invfile,1,1)
  rc = lineout(invfile)
  /* rc = stream(invfile,"c","close") on Linux can cause segfault when called enough times */
  Parse Var text Something'|'Something'|'device1'|'Something
  Parse var device1 device'.'Something
  filename1 = changestr(home'\',invfile,'')    /* Removes path from filename on windows */
  filename = changestr(home'/',filename1,'')  /* If Linux then path is still in place and this then removes path, no effect if Windows */ 
  
  rc = lineout('listmefs.csv',device1','filename','invfile)
  rc = lineout('listmefs-nh.csv',device','filename','invfile) /* Will normally be the same as listmefs but occassionally listmefs could have FQDN for the servers */
end

finish:





