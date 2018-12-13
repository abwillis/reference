/* Coallate the inventory information into inv.csv */
/* Envisioned, designed and written by Andy Willis */
/* Version 2.0  10/24/2012 */
rc = SysLoadFuncs()
rc = SysFileDelete(nonelist.txt)
rc = SysFileTree('.','dirs','DO')
home = directory()
TFN = 'INV-'DATE(S)'.CSV'
NFL = 'NFL-'DATE(S)'.CSV'
rc = SysFileDelete(TFN)
rc = SysFileDelete(NFL)
call LineOut TFN,"MSN,Model,Name,email,emp SN,Cube,Account,P/S,OfficeXP,Office2003,Office2007,Office2010,Access,Date", 1
call LineOut NFL,"MSN,Model,Name,email,emp SN,Cube,Account,P/S,OfficeXP,Office2003,Office2007,Office2010,Access,Date", 1

do j = 1 to dirs.0
newdir = directory(dirs.j)
call check
newdir = directory(home)
end

call nonecheck

/* Correlate the email address in email.htm and text file */
check:
wstfile = email.htm
do i = 1 to 4
Something = LineIn(wstfile)
end
text = LINEIN(wstfile)
Parse Upper Var text Part1 '>' emailw '<' rest
rc = stream( wstfile, 'c', 'close')
if (emailw == "NONE") then do
  call LineOut None.txt,emailw
  call LineOut None.txt
  return
end
rc = SysFileDelete(none.txt)
rc = SysFileTree('*.txt','file','FO')
if (file.0 == 0) then return
do k = 1 to file.0
/* Parse Var file.1 Something'\'Something'\'Something'\'invfile */
invfile = file.k
text = LineIn(invfile,1,1)
Parse Upper Var text Something','Something','Something',"'emaili'",'Something
rc = stream(invfile, 'c', 'close')
if (emaili \= emailw) then rc = SysFileDelete(invfile)
end
call LineOut TFN, text
return


nonecheck:

rc = SysFileTree('none.txt','nonef','FOS')
do l = 1 to nonef.0
call lineout 'nonelist.txt', nonef.l
Parse Var nonef.l pathn'\NONE.TXT'
rc = directory(pathn)
rc = SysFileDelete(none.txt)
rc = SysFileTree('*.txt','nada','FO')
rc = directory(home)
if (nada.0 \= 0) then do m=1 to nada.0
blast = nada.m
text = LineIn(blast,1,1)
rc = stream(blast,'c','close')
call LineOut NFL, text
rc = SysFileDelete(blast)
end
end

finish:

