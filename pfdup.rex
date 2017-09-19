#! /usr/bin/rexx
/* Find duplicate mef files */
/* Envisioned, designed and written by Andy Willis */
/* Version 3.0.01  19Sep2017 */
rc = SysLoadFuncs()
home = directory()

/* Delete logging files so as to not just add to them */
rc = SysFileDelete('dupcheck.csv')
rc = SysFileDelete('wrongfile.csv')
rc = SysFileDelete('badfile.csv')

rc = SysFileTree('*.mef3','file','FO') /* Load list of mef3 files into file.x, total number of mef3 files into file.0 */
if (file.0 == 0) then call finish

do k = 1 to file.0
  invfile = file.k
  text = LineIn(invfile,1,1) /* Just pull in the first line of the file, from it we can get the hostname we are looking for here */
  Parse Var text Something'|'Something'|'device'|'Something /* Parses out hostname (device) */
  rc = LineOut(invfile) /*stream close will seg fault after many uses on linux */
/* rc = stream(invfile, 'c', 'close') */
  if (device == '') then call badstuff /* mef file is bad if the hostname is not in it */

  else do
    checkfile = '*'device'.mef3'
    rc = SysFileTree(checkfile,'howm','FOI')
    if (howm.0 == 0) then do
      Parse Var device dev1'.'. /* Remove FQDN if device name fails above, could be filename does not have the FQDN and hostname in mef3 does internally */
      checkfile = '*'dev1'.mef3'
      rc = SysFileTree(checkfile,'howm','FOI')
    end
    if (howm.0 == 0) then call wrongstuff /* Filename still not found from device, even after removing FQDN above, call logging */
    else if (howm.0 > 1) then call names
  end
end
call finish

names:

do x = 1 to howm.0
  new = 0
  listfile = howm.x
  do while lines('dupcheck.csv')
    checkit = LineIn('dupcheck.csv')
    Parse var checkit lineup','.
    if (lineup == listfile) then new = 1 /* Any match will set new=1 so then below it will not output that filename, prevents the same filename being output twice for each match */
  end
  rc = LineOut('dupcheck.csv')
  if (new == 0) then do
    say listfile
    rc = SysFileTree(listfile,'fdate','F')
    rc = lineout('dupcheck.csv',listfile','Word(fdate.1,3))
  end
end

return


badstuff: /* Called to log mef3 files that are missing the hostname */
Say 'Something bad, empty hostname field in'
say invfile 
rc = lineout('badfile.csv', invfile)
return

wrongstuff:  /* A file matching the hostname was not found, this sometimes is caused by name being truncated, log it but not necessarily a problem */
Say 'Something wrong, no file found with hostname'
say invfile
rc = lineout('wrongfile.csv', invfile','device)
return

finish:
