#! /usr/bin/rexx
/* REXX MGR-Devices cleanup for OS */
/* Version 1.3.1 19Sep2017 */
/* Envisioned, designed and written by Andy Willis */

rc = SysLoadFuncs()
home = directory()

Parse ARG csvfile account
if (csvfile == 'help') then call help

if (csvfile == '') then call filelist

if (account == '') then call getaccnt

newfile = account'-'DEVICES'.csv'

junk = linein(csvfile) /* eat the first line as we don't want it in the final output */
Do While Lines(csvfile)
  text = LineIn(csvfile)
  parse Upper var text text1
  clear = Pos('STORAGE',text1)
  if (clear == 0) then do
    clear1 = Pos('SHID',text1)
    if (clear1 == 0) then rc = lineout(newfile,text)
  end
end

call finish

filelist:
rc = SysFileTree('*MGR*.csv','file','FOI')
do k = 1 to file.0
  test = file.k
  say test
end

/* Parse Pull instead of just pull to prevent uppercasing */
say "what file do you wish to clean"
parse pull csvfile
return

getaccnt:
say "What account?"
parse pull account
return

help:
say "This was written to clean up MGR CSV to be converted"
say " Usage:"
say "dvmgos filename account"
say "dvmgos help    This screen"


finish:

