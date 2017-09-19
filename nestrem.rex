#! /usr/bin/rexx
/* Create csv files for use with imacros to for Nested Files reconciliation */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.0 19Sep2017 */
rc = SysLoadFuncs()
home = directory()

Parse ARG devfile dashboard inst1
parse lower var inst1 inst

if devfile = '' then do
  Say "DVC08 file?"
  Parse Pull devfile
end
if dashboard = '' then do
  Say "dashboard file?"
  Parse Pull dashboard
end
do while ((inst<>'br' & inst<>'us'))
  say "US or BR"
  parse lower pull inst
end

rc = SysFileDelete('Device_Deviation_Nested_Groups.csv')
rc = lineout('Device_Deviation_Nested_Groups.csv','Instance,device_id,Hostname')

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

rc = stream(dashboard,"c","open")
j = 0
l = 0
do while Lines(dashboard)
  j = j + 1
  rtext = linein(dashboard)
  parse var rtext device.j';'.';'pltfrm.j';'.';'.';'.';'.';'.';'.';'.';'.';'nested';'.
  parse var nested num'/'num1
  if (num1 <> '') then do
    l = l + 1
    device.l = device.j
    pltfrm.l = pltfrm.j
  end  
end  
device.0 = l
say "Number of dashboard entries: "l
rc = stream(dashboard,"c","close")

do i = 1 to DeviceID.0
  do m = 1 to device.0
    if (hostname.i = device.m) then do
      if (platform.i = pltfrm.m) then do
        rc = lineout('Device_Deviation_Nested_Groups.csv',inst','DeviceID.i','device.m)
        m = Device.0
      end
    end
  end
end




