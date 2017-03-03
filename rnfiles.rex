/* Rename bulk files Adding to the front. */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.7  3/3/2016 */
rc = SysLoadFuncs()
home = directory()
Parse ARG common addition
rc = SysFileTree(common'*','file','FO')
direc = Directory()
if (file.0 == 0) then call finish
do k = 1 to file.0
invfilec = file.k
/* invfile = strip(invfilec,'L',direc) */
invfile = changestr(direc'\',invfilec,'')
newfile = changestr(common,invfile,'')
renfile = addition||newfile
rc = SysFileMove(invfile,renfile)
/* ADDRESS CMD ren invfile renfile */

end

finish:
