#! /usr/bin/rexx
/* Rename bulk files Adding to the front. */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.8.01  19Sep2017 */
rc = SysLoadFuncs()
home = directory()
Parse ARG common addition
rc = SysFileTree(common'*','file','FO')
direc = Directory()
if (file.0 == 0) then call finish
do k = 1 to file.0
  invfilec = file.k
/* invfile = strip(invfilec,'L',direc) */
  invfile1 = changestr(direc'\',invfilec,'')
  invfile = changestr(direc'/',invfile1,'')
  newfile = changestr(common,invfile,'')
  renfile = addition||newfile
  rc = SysFileMove(invfile,renfile)
end

finish:
