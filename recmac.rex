/* Create csv files for use with imacros to for reconciliation */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.1.01 19Sep2017 */

rc = SysLoadFuncs()
home = directory()
rc = SysFileDelete('Device_Deviation_Groups.csv')
rc = SysFileDelete('Device_Deviation_Privs.csv')
rc = SysFileDelete('Device_Deviation_Users.csv')
rc = SysFileDelete('UAT_Deviation_Add_Privs.csv')
rc = SysFileDelete('UAT_Deviation_Add_Users.csv')
rc = SysFileDelete('UAT_Deviation_Groups.csv')

Parse ARG devfile reconfile inst1 justif
parse lower var inst1 inst

if devfile = '' then do
  Say "DVC08 file?"
  Parse Pull devfile
end
if reconfile = '' then do
  Say "Recon03 file?"
  Parse Pull reconfile
end
do while ((inst<>'br' & inst<>'us'))
  say "US or BR"
  parse lower pull inst
end
if justif = '' then do
  say 'Justification? (.e.g. 1Q17 recon)'
  parse pull justif
end

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

rc = stream(reconfile,"c","open")
j = 0
do while Lines(reconfile)
  j = j + 1
  rtext = linein(reconfile)
  parse var rtext .'|"'source.j'"|'.'|'.'|"'device.j'"|'.'|'.'|"'Type.j'"|"'object.j'"|"'privlab.j'"|'request.j
  if source.j = '' then parse var rtext .'|'source.j'|'.'|'.'|'device.j'|'.'|'.'|'Type.j'|'object.j'|'privlab.j'|'request.j
end  
device.0 = j
rc = stream(reconfile,"c","close")

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

rc = lineout('Device_Deviation_Groups.csv','Instance,device_id,Hostname,Group Name,platform')
rc = lineout('Device_Deviation_Privs.csv','Instance,device_id,Hostname,User ID,Privs,platform')
rc = lineout('Device_Deviation_Users.csv','Instance,device_id,Hostname,User ID,platform')
rc = lineout('UAT_Deviation_Add_Privs.csv','Instance,device_id,Hostname,User ID,Privs,Justification,platform')
rc = lineout('UAT_Deviation_Add_Users.csv','Instance,device_id,Hostname,User ID,Type,Icode or SERIAL #,System User,Justification,Update Label? Yes or No,platform,label')
rc = lineout('UAT_Deviation_Groups.csv','Instance,device_id,Hostname,Group Name,intCodes,Privileged,Description,platform')

do n = 1 to obj.0
  ISN = ''
  Type = ''
  If request.n = '' then do
    SELECT
      WHEN typ.n = "Privilege" then do
        if src.n = "Not in UAT" then  do 
          rc = lineout('UAT_Deviation_Add_Privs.csv',inst','did.n','hst.n','obj.n','plv.n','justif','plt.n',')
        end
        if src.n = "Not in Device" then do 
          rc = lineout('Device_Deviation_Privs.csv',inst','did.n','hst.n','obj.n','plv.n','plt.n',')
        end
      end

      When typ.n = "Group" then do
        if src.n = "Not in UAT" then do
          rc = lineout('UAT_Deviation_Groups.csv',inst','did.n','hst.n','obj.n',,TRUE,Group,'plt.n)
        end
        if src.n = "Not in Device" then do
          rc = lineout('Device_Deviation_Groups.csv',inst','did.n','hst.n','obj.n','plt.n',')
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
                ISN = ''
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
              otherwise ISN = 'labelling unknown'
          end
          rc = lineout('UAT_Deviation_Add_Users.csv',inst','did.n','hst.n','obj.n','Type','ISN',No,'Justif',No,'plt.n','plv.n',')
        end
        if src.n = "Not in Device" then do 
          rc = lineout('Device_Deviation_Users.csv',inst','did.n','hst.n','obj.n','plt.n',')
        end
      end
    end
  end
end

