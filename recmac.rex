#! /usr/bin/rexx
/* Create csv files for use with imacros to for reconciliation */
/* Envisioned, designed and written by Andy Willis */
/* Version 2.1.3 2May2018 */

rc = SysLoadFuncs()
home = directory()
rc = SysFileDelete('Device_Deviation_Groups.csv')
rc = SysFileDelete('Device_Deviation_Privs.csv')
rc = SysFileDelete('Device_Deviation_Users.csv')
rc = SysFileDelete('UAT_Deviation_Add_Privs.csv')
rc = SysFileDelete('UAT_Deviation_Add_Users.csv')
rc = SysFileDelete('UAT_Deviation_Groups.csv')

rc = lineout('Device_Deviation_Groups.csv','Instance,device_id,Hostname,Group Name,platform')
rc = lineout('Device_Deviation_Privs.csv','Instance,device_id,Hostname,User ID,Privs,platform')
rc = lineout('Device_Deviation_Users.csv','Instance,device_id,Hostname,User ID,platform')
rc = lineout('UAT_Deviation_Add_Privs.csv','Instance,device_id,Hostname,User ID,Privs,Justification,platform')
rc = lineout('UAT_Deviation_Add_Users.csv','Instance,device_id,Hostname,User ID,Type,Icode or SERIAL #,System User,Justification,Update Label? Yes or No,platform,label')
rc = lineout('UAT_Deviation_Groups.csv','Instance,device_id,Hostname,Group Name,intCodes,Privileged,Description,platform')

Parse ARG devfile reconfile inst1 justif dpeint
parse lower var inst1 inst

/* Ask for arguments if not provided on command line */
if (devfile == '') then do
  Say "DVC08 file?"
  Parse Pull devfile
end
if (reconfile == '') then do
  Say "Recon03 file?"
  Parse Pull reconfile
end
do while ((inst<>'br' & inst<>'us'))
  say "US or BR"
  parse lower pull inst
end
if (justif == '') then do
  say 'Justification? (.e.g. 1Q17 recon)'
  parse pull justif
end
if (dpeint == '') then do
  say 'DPE INT Code? For customer IDs'
  pull DPEINT
end  

/* Read in and parse Device file */
Say "Reading in data."
rc = stream(devfile,"c","open")
k = 0
Do While Lines(devfile)

  dtext = Linein(devfile)
  cnt = countstr(_SID,dtext)
  if (cnt = 0) then do
    k = k + 1
    parse var dtext .'|'.'|'.'|'DeviceID.k'|"'hostname.k'"|'.'|'.'|'.'|"'platform.k'"|'.
    if hostname.k = '' then parse var dtext .'|'.'|'.'|'DeviceID.k'|'hostname.k'|'.'|'.'|'.'|'platform.k'|'.
  end
end
DeviceID.0 = k
rc = stream(devfile,"c","close")

/* Read in and Parse Recon file */
rc = stream(reconfile,"c","open")
j = 0
do while Lines(reconfile)
  j = j + 1
  rtext = linein(reconfile)
  parse var rtext .'|"'source.j'"|'.'|'.'|"'device.j'"|'.'|'pltfrm.j'|"'Type.j'"|"'object.j'"|"'privlab.j'"|'request.j
  if source.j = '' then parse var rtext .'|'source.j'|'.'|'.'|'device.j'|'.'|'.'|'Type.j'|'object.j'|'privlab.j'|'request.j
end  
device.0 = j
rc = stream(reconfile,"c","close")

/* Load stem variables */
l = 0
do i = 1 to DeviceID.0
  do m = 1 to device.0
    if (hostname.i = device.m) then do
      l = l + 1
/* look at adding an if statement here checking platform so that if two hostnames on different platforms happened to exist */
      src.l = source.m
      typ.l = Type.m
      obj.l = object.m
      plv.l = privlab.m
      req.l = request.m
      did.l = DeviceID.i
      hst.l = hostname.i
      plt.l = platform.i
    end
  end
end
  typ.0 = l
  plv.0 = l
  obj.0 = l
  src.0 = l 

/* Initialize count variables to zero */
u = 0
v = 0
w = 0
x = 0
y = 0
z = 0
UDAP.0 = 0
DDP.0 = 0
UDG.0 = 0
DDG.0 = 0
UDAU.0 = 0
DDU.0 = 0

/* Do comparisons to load results into appropriate stem variables */
Say "Comparing data"
do n = 1 to obj.0
  ISN = ''
  Type = ''
  If req.n = '' then do
    SELECT
      WHEN typ.n = "Privilege" then do
        if src.n = "Not in UAT" then  do
          u = u + 1
          UDAP.0 = u
          UDAP.u = inst','did.n','hst.n','obj.n','plv.n','justif','plt.n','
          /* rc = lineout('UAT_Deviation_Add_Privs.csv',inst','did.n','hst.n','obj.n','plv.n','justif','plt.n',') */
        end
        if src.n = "Not in Device" then do
          v = v + 1
          DDP.0 = v
          DDP.v = inst','did.n','hst.n','obj.n','plv.n','plt.n','
          /* rc = lineout('Device_Deviation_Privs.csv',inst','did.n','hst.n','obj.n','plv.n','plt.n',') */
        end
      end

      When typ.n = "Group" then do
        if src.n = "Not in UAT" then do
          w = w + 1
          UDG.0 = w
          UDG.w = inst','did.n','hst.n','obj.n',,TRUE,Group,'plt.n','
          /* rc = lineout('UAT_Deviation_Groups.csv',inst','did.n','hst.n','obj.n',,TRUE,Group,'plt.n) */
        end
        if src.n = "Not in Device" then do
          x = x + 1
          DDG.0 = x
          DDG.x = inst','did.n','hst.n','obj.n','plt.n','
          /* rc = lineout('Device_Deviation_Groups.csv',inst','did.n','hst.n','obj.n','plt.n',') */
        end
      end

      When typ.n = "User ID" then do
        if src.n = "Not in UAT" then do
          parse upper var plv.n cntry'/'tid'/'SN'/'.
/* consider a compare for all types against plv.n and set a variable that adds for each hit and if 
variable is >1 then mark it as possible mislabel check /C/ /F/ /I/ /E/ etc. */
          Select 
              when tid = 'S' then do
                parse var SN '*'ISN
                Type = '2'
              end
              when tid = 'F' then do
                parse var SN '*'ISN
                Type = '2'
              end    
              when tid = 'C' then do
                ISN = DPEINT
                TYPE = '3'
              end
              when tid = 'E' then do
                ISN = SN''cntry
                Type = '1'
              end
              when tid = 'I' then do
                ISN = SN''cntry
                Type = '1'
              end
              when tid = 'N' then do
                ISN = 'labelling unknown 'SN''cntry
                Type = '4'
              end
              otherwise ISN = 'labelling unknown 'SN''cntry
          end
          y = y + 1
          UDAU.0 = y
          UDAU.y = inst','did.n','hst.n','obj.n','Type','ISN',No,'Justif',No,'plt.n','plv.n','
          /* rc = lineout('UAT_Deviation_Add_Users.csv',inst','did.n','hst.n','obj.n','Type','ISN',No,'Justif',No,'plt.n','plv.n',') */
        end
        if src.n = "Not in Device" then do
          z = z + 1
          DDU.0 = z
          DDU.z = inst','did.n','hst.n','obj.n','plt.n','
          /* rc = lineout('Device_Deviation_Users.csv',inst','did.n','hst.n','obj.n','plt.n',') */
        end
      end
    end
  end
end


say "Begin writing to files"

/* Sort UAT add Privs by UID  */
final.0 = UDAP.0
do k = 1 to final.0
  final.k = ''
end

do j = 1 to UDAP.0
  Parse Upper var UDAP.j .','.','.','UIDa','.
  e = 0
  do k = 1 to UDAP.0
    Parse UPPER var UDAP.k .','.','.','UIDb','.
    if UIDa > UIDb then e = e + 1
  end
  n = e + 1
  do while(final.n <> '')
    n = n + 1
  end
  final.n = UDAP.j
end
dest = 'UAT_Deviation_Add_Privs.csv'
call outputit

say "1/6 done"

/* Sort UAT add groups by group */
final.0 = UDG.0
do k = 1 to final.0
  final.k = ''
end

do j = 1 to UDG.0
  Parse Upper var UDG.j .','.','.','UDGa','.
  e = 0
  do k = 1 to UDG.0
    Parse UPPER var UDG.k .','.','.','UDGb','.
    if UDGa > UDGb then e = e + 1
  end
  n = e + 1
  do while(final.n <> '')
    n = n + 1
  end
  final.n = UDG.j
end
dest = 'UAT_Deviation_Groups.csv'
call outputit

say "1/3 done"

/* Sort UAT add ID by ID */
final.0 = UDAU.0
do k = 1 to final.0
  final.k = ''
end

do j = 1 to UDAU.0
  Parse Upper var UDAU.j .','.','.','UIDa','.
  e = 0
  do k = 1 to UDAU.0
    Parse UPPER var UDAU.k .','.','.','UIDb','.
    if UIDa > UIDb then e = e + 1
  end
  n = e + 1
  do while(final.n <> '')
    n = n + 1
  end
  final.n = UDAU.j
end
dest = 'UAT_Deviation_Add_Users.csv'
call outputit

say "1/2 done"

/*Sort Device by Device*/
intermediate.0 = DDP.0
final.0 = DDP.0
do k = 1 to DDP.0
  intermediate.k = ''
  final.k = ''
end

n = 0
do j = 1 to DDP.0
  Parse upper var DDP.j .','.','Hosta','.
  g = 1
  e = 0
  do k = 1 to DDP.0
    Parse upper var DDP.k .','.','Hostb','.
    if (hosta > hostb) then g = g + 1
    if (hosta == hostb) then e = e + 1
  end

  If (intermediate.g == '') then do
    q = g
    if (e % 100 < 1) then f = 1
    else f = e % 100
    do num = 1 to f
      n = n + 1
      intermediate.q = DDP.j
      q = q + 1
    end
  end
end
final.0 = n

j = 0
do i = 1 to intermediate.0
  if (intermediate.i <> '') then do
    j = j + 1
    final.j = intermediate.i
  end
end
dest = 'Device_Deviation_Privs.csv'
call outputit

say "2/3 done"

intermediate.0 = DDG.0
final.0 = DDG.0
do k = 1 to DDG.0
  intermediate.k = ''
  final.k = ''
end

n = 0
do j = 1 to DDG.0
  Parse upper var DDG.j .','.','Hosta','.
  g = 1
  e = 0
  do k = 1 to DDG.0
    Parse upper var DDG.k .','.','Hostb','.
    if (hosta > hostb) then g = g + 1
    if (hosta == hostb) then e = e + 1
  end

  If (intermediate.g == '') then do
    q = g
    if (e % 100 < 1) then f = 1
    else f = e % 100
    do num = 1 to f
      n = n + 1
      intermediate.q = DDG.j
      q = q + 1
    end
  end
end
final.0 = n

j = 0
do i = 1 to intermediate.0
  if (intermediate.i <> '') then do
    j = j + 1
    final.j = intermediate.i
  end
end
dest = 'Device_Deviation_Groups.csv'
call outputit

say "5/6 done"

intermediate.0 = DDU.0
final.0 = DDU.0
do k = 1 to DDU.0
  intermediate.k = ''
  final.k = ''
end

n = 0
do j = 1 to DDU.0
  Parse upper var DDU.j .','.','Hosta','.
  g = 1
  e = 0
  do k = 1 to DDU.0
    Parse upper var DDU.k .','.','Hostb','.
    if (hosta > hostb) then g = g + 1
    if (hosta == hostb) then e = e + 1
  end

  If (intermediate.g == '') then do
    q = g
    if (e % 100 < 1) then f = 1
    else f = e % 100
    do num = 1 to f
      n = n + 1
      intermediate.q = DDU.j
      q = q + 1
    end
  end
end
final.0 = n

j = 0
do i = 1 to intermediate.0
  if (intermediate.i <> '') then do
    j = j + 1
    final.j = intermediate.i
  end
end
dest = 'Device_Deviation_Users.csv'
call outputit

say "done"
call finish

outputit:
/* output sorted uat add ID to csv file */
do j = 1 to final.0
  rc = lineout(dest,final.j)
end
rc = stream(dest,"c","close")
return

finish:
