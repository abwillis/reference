#! /usr/bin/rexx
/* Check ECM against UAT  */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.1.01  20Feb2018 */

rc = SysLoadFuncs()
home = directory()

Parse Arg invfile dvcfile

outstatus = 'output.csv'

rc = SysFileDelete(outstatus)
rc = SysFileDelete(noecm)

do while (invfile == '')
  say "Inventory file?"
  Parse pull invfile
end

do while (dvcfile == '')
  say "DVC08 file?"
  Parse pull dvcfile
end

a = 0
b = 0

rc = stream(invfile,"c","open")
do while lines(invfile)
  a = a + 1
  first = LineIn(invfile)
  parse upper var first logical.a','.
end
logical.0 = a
rc = stream(invfile,"c","close")

rc = stream(dvcfile,"c","open")
do while lines(dvcfile)
  b = b + 1
  second = LineIn(dvcfile)
  parse upper var second .'|'.'|'.'|'.'|'hostname.b'|'.'|'status.b'|'.
end
rc = stream(dvcfile,"c","close")
hostname.0 = b
status.0 = b

do c = 1 to logical.0
check = 0
  do d = 1 to hostname.0
    if (logical.c == hostname.d) then do
      check = 1
      if (status.d == 'ON MIGRATION') then rc = lineout(outstatus,hostname.d','status.d)
      if (status.d == 'UNAVAILABLE') then rc = lineout(outstatus,hostname.d','status.d)
      d = hostname.0
    end
  end
  if check = 0 then rc = lineout(outstatus,logical.c',Not in UAT')
end  

do c = 1 to hostname.0
  check = 0
  do d = 1 to logical.0
    if (hostname.c == logical.d) then do
      check = 1
      d = logical.0
    end
  end
  if (check == 0) then rc = lineout(outstatus,hostname.c',Not in ECM')
end  