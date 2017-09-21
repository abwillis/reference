#! /usr/bin/rexx
/* Sort recon files into in UAT and not in UAT */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.0  21Sep2017 */

rc = SysLoadFuncs()
home = directory()

parse arg reconfile list1 account

if reconfile = '' then call getreconfile
if list1 = '' then call getlist
if (account == '') then call getaccnt

rc = SysFileDelete(account'-recon-uat.csv')
rc = SysFileDelete(account'-recon-nouat.csv')

rc = stream(list1,"c","open")
k = 0
do while lines(list1)
  k = k + 1
  words.k = linein(list1)
end
rc = stream(list1,"c","close")
words.0 = k

rc = stream(reconfile,"c","open")
do while lines(reconfile)
  holdit = linein(reconfile)
  parse var holdit .':'.':'C1':'
  j = 0 /* If stays a 0 then it is in UAT */
  do i = 1 to words.0
    if (C1 == words.i) then do
      j = 1 /* If set then it is in the list that was not in UAT */
      i = words.0 /* Just to end the loop instead of having to complete it */
    end  
  end
  select
    when j = 0 then rc = lineout(account'-recon-uat.csv',holdit)
    when j = 1 then rc = lineout(account'-recon-nouat.csv',holdit)
  end
end  
rc = stream(recon,"c","close")

call finish

getreconfile:
Say "Reconciliation file?"
Parse Pull reconfile
return

getlist:
Say "Filename of list of servers to remove?"
Parse Pull list1
return
  
getaccnt:
say "What account?"
parse pull account
return

finish: