#! /usr/bin/rexx
/* Move date from end of mef3 filename to middle where it is expected. */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.0  17Apr2018 */

rc = SysLoadFuncs()
home = directory()
Parse ARG ACC1

rc = SysFileTree('*.mef3','file','FO')
direc = Directory()

if (file.0 == 0) then call finish
do k = 1 to file.0
  invfilec = file.k
  invfile1 = changestr(direc'\',invfilec,'')
  invfile = changestr(direc'/',invfile1,'')
  parse var invfile account'_'host'_'date'.'.
  if (account == '') then account = ACC1
  parse var date year'-'month'-'day

  SELECT
    WHEN month == '01' then month = 'Jan'
    WHEN month == '02' then month = 'Feb'
    WHEN month == '03' then month = 'Mar'
    WHEN month == '04' then month = 'Apr'
    WHEN month == '05' then month = 'May'
    WHEN month == '06' then month = 'Jun'
    WHEN month == '07' then month = 'Jul'
    WHEN month == '08' then month = 'Aug'
    WHEN month == '09' then month = 'Sep'
    WHEN month == '10' then month = 'Oct'
    WHEN month == '11' then month = 'Nov'
    WHEN month == '12' then month = 'Dec'
  END    

  newfile = account||'_'||day||month||year||'_'||host||'.mef3'
  rc = SysFileMove(invfile,newfile)
end

finish: