/* Find duplicate mef files */
/* Envisioned, designed and written by Andy Willis */
/* Version 2.9  24Jul2017 */
rc = SysLoadFuncs()
home = directory()

rc = SysFileDelete('dupcheck.csv')
rc = SysFileDelete('wrongfile.csv')
rc = SysFileDelete('badfile.csv')
rc = SysFileTree('*.mef3','file','FO')
if (file.0 == 0) then call finish

do k = 1 to file.0
  invfile = file.k
  text = LineIn(invfile,1,1)
  Parse Var text Something'|'Something'|'device'|'Something
  rc = LineOut(invfile) /*stream close will seg fault after many uses on linux */
/* rc = stream(invfile, 'c', 'close') */
  if (device == '') then call badstuff

  else do
    checkfile = '*'device'.mef3'
    rc = SysFileTree(checkfile,'howm','FOI')
    if (howm.0 == 0) then do
      Parse Var device dev1'.'.
      checkfile = '*'dev1'.mef3'
      rc = SysFileTree(checkfile,'howm','FOI')
    end
    if (howm.0 == 0) then call wrongstuff
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
    if (lineup == listfile) then new = 1
  end
  rc = LineOut('dupcheck.csv')
  if (new == 0) then do
    say listfile
    rc = SysFileTree(listfile,'fdate','F')
    rc = lineout('dupcheck.csv',listfile','Word(fdate.1,3))
  end
end

return


badstuff:
Say 'Something bad, empty hostname field in'
say invfile 
rc = lineout('badfile.csv', invfile)
return

wrongstuff:
Say 'Something wrong, no file found with hostname'
say invfile
rc = lineout('wrongfile.csv', invfile','device)
return

finish:
