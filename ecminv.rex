#! /usr/bin/rexx
/* REXX ECM Inventory cleanup */
/* Version 1.4.1 30Apr2018 */
/* Envisioned, designed and written by Andy Willis */

rc = SysLoadFuncs()
home = directory()

today = Date('Base')
Ndate = Date('Normal',today,'Base')
parse var ndate day' 'mon' 'year
if day<10 then day='0'day
if mon<10 then mon='0'mon
tdate = day||mon||year

Parse ARG csvfile account
if (csvfile == 'help') then call help

if (csvfile == '') then call filelist

if (account == '') then call getaccnt

newfilename = account'_'tdate'_'Inventory
newfile = newfilename'.csv'

check = stream(newfile,'c','query exists')

/* Using the below to copy and then delete file data rather than using SysFileMove in hopes of being cross platform */
if (check <> '') then do
  random=SysTempFileName(???)
  renname = newfilename||random'.csv'
  do while lines(newfile)
    words = linein(newfile)
    rc = lineout(renname,words)
  end
end
rc = lineout(newfile)
rc = SysFileDelete(newfile)
/* End rename procedure */

count = 0
Do While Lines(csvfile)
  count = count + 1
  text1 = LineIn(csvfile)
  text = ChangeStr(',',text1,'')
  Parse Var text drop';'LN';'LNA';'SysID';'Sysstate';'OSFam';'Cat';'Plat';'IP';'drop';'drop';'drop';'drop';'drop';'drop';'drop';'drop';'drop';'drop';'drop';'drop';'QEVReq';'drop';'QEVdate';'QEVnext';'QEVstat';'CBNReq';'drop';'drop';'CBNDate';'CBNNext';'CBNStat';'PrivReq';'drop';'drop';'PrivDate';'PrivNext';'PrivStat';'drop
  if LN = '' then Parse Var text drop','LN','LNA','SysID','Sysstate','OSFam','Cat','Plat','IP','drop','drop','drop','drop','drop','drop','drop','drop','drop','drop','drop','drop','QEVReq','drop','QEVdate','QEVnext','QEVstat','CBNReq','drop','drop','CBNDate','CBNNext','CBNStat','PrivReq','drop','drop','PrivDate','PrivNext','PrivStat','drop
  if (count >3 ) then do
    newline = ChangeStr('"',LN','LNA','SysID','SysState','OSFam','Cat','Plat','IP','QEVReq','CBNReq','PrivReq','QEVStat','CBNStat','PrivStat','QEVDate','CBNDate','PrivDate','QEVNext','CBNNext','PrivNext',','')
    if (QEVReq == 'y') then rc = lineout(newfile,newline
    else if (CBNReq == 'y') then rc = lineout(newfile,newline)
    else if (PrivReq == 'y') then rc = lineout(newfile,newline)
    else NOP
  end
end

rc = lineout(csvfile)
call finish

filelist:
rc = SysFileTree('*Inv*.csv','file','FOI')
do k = 1 to file.0
  test = file.k
  say test
end

rc = SysFileTree('*IDMCOMP*.csv','file','FOI')
do k = 1 to file.0
  test = file.k
  say test
end

rc = SysFileTree('*Cust*.csv','file','FOI')
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
say "This was written to clean up ECM CSV to be cleaner to read"
say " Usage:"
say "ecminv filename account"
say "ecminv help    This screen"


finish:

