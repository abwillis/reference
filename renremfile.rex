#! /usr/bin/rexx
/* Remove date at tail end of mef filename. */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.0  8Nov2017 */
rc = SysLoadFuncs()
home = directory()
Parse ARG common
rc = SysFileTree('*.mef3','file','FO')
direc = Directory()
if (file.0 == 0) then call finish
do k = 1 to file.0
  invfilec = file.k
/* invfile = strip(invfilec,'L',direc) */
  invfile1 = changestr(direc'\',invfilec,'')
  invfile = changestr(direc'/',invfile1,'')
  newfile = changestr(common,invfile,'')
/*  renfile = addition||newfile */
  rc = SysFileMove(invfile,newfile)
end

finish:
