#! /usr/bin/rexx
/* remove servers from recon file */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.0.0 04Dec2017 */

rc = SysLoadFuncs()
home = directory()

rc = SysFileDelete('recon-cleaned.csv')
rc = SysFileDelete('nested.csv')

Parse arg servlist reconfile

if (servlist == "") then do
  say "Filename of server list"
  parse pull servlist
end

if (reconfile == "") then do
  say "Filename of reconfile"
  parse pull reconfile
end

c = 0
do while lines(servlist)
  c = c + 1
  list.c = linein(servlist)
end
list.0 = c
rc = stream(servlist,"c","close")

do while lines(reconfile)
  equalled = 0
  lined = linein(reconfile)
  do i = 1 to list.0
    check = POS(list.i,lined)
    if (check <> 0) then do
      equalled = 1
      parse var lined .':'.":"third":".
      if (third <> list.i) then do
        rc = lineout('nested.csv',list.i":"lined)
        equalled = 0
      end
      else i = list.0
    end
  end
  if equalled = 0 then rc = lineout('recon-cleaned.csv',lined)

end

rc = stream(servlist,"c","close")
