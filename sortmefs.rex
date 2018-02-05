#! /usr/bin/rexx
/* Copy mef3 files into directories based on platform */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.0  5Feb2018 */
rc = SysLoadFuncs()
home = directory()

rc = SysFileTree('*.mef3','file','FO')
if (file.0 == 0) then call finish

do k = 1 to file.0
  invfile = file.k
  rc = stream(invfile,"c","open")
  text = LineIn(invfile,1,1)
  Parse Var text '|'.'|'.'|'Platform'|'.
  rc = stream(invfile,"c","close")
  filename1 = changestr(home'\',invfile,'')    /* Removes path from filename on windows */
  filename = changestr(home'/',filename1,'')  /* If Linux then path is still in place and this then removes path, no effect if Windows */ 

/* Check if platform directory exists and create it if not */
  rc = SysIsFileDirectory(Platform)
  if (rc == 0) then rc = sysmkdir(Platform)

  rc = stream(invfile,"c","open")
  do while lines(invfile)
    text = LineIn(invfile)
    rc = directory(Platform)
    rc = lineout(filename,text)
    rc = directory(home)
  end
  rc = stream(invfile,"c","close")
end

finish:
  