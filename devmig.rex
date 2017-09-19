#! /usr/bin/rexx
/* USA devices migration */
/* Envisioned/designed/developed by Andy Willis */
/* Version 1.6.01 19Sep2017 */

home = Directory()
Num = 0
Say 'Device migration form'
Say 'There is no input validation occuring, other than for some fields that require _something_ be supplied:'
Say 'If empty is valid, just hit enter... if empty is not valid you will be prompted.'
Say 'Currently assuming Status is migration (should normally be for new devices), automatic = NO, Connection therefore is blank, and ECMMap is left blank.'
/* If needed can uncomment those questions to no longer default the above */
Say 'Leave Device Name empty and hit enter to finish'

Say 'Account?'
Parse pull Account

rc = SysFileTree(Account'-device-migration.csv','exist','FO')
if (exist.0 = 0) then do 
  rc = Lineout(Account'-device-migration.csv','Hostname:IP:status:environment:delivery team:platform:automated:deveice role:master device:description:Last IBM QEV:Last IBM CBN:Last IBM Privilege Revalidation:Last Customer QEV:Last Customer CBN:Last Customer Privilege Revalidation:connection:ECM Mapping Name')
/* Only add header if file does not exist, this allows adding to existing file */
  Say 'You will need to remove header before submitting, you should look at the output anyhow'
end

Say 'Use Mef3 files? (Y if yes)'
Pull mefs

Say 'Use ECM? (Y if yes) Assumes an ecminv converted IDCOMP file.'
Pull ECMQues

If (ECMQues == 'Y') then do
  call filelist
  rc = Directory(..)
  call filelist
  rc = Directory(home)
  Say 'ECM filename?'
  Parse Pull ECMFile
end

If (mefs == 'Y') then do
  rc = SysFileTree('*.mef3','file','FO')
  if (file.0 == 0) then do
    Say 'Use Mefs answered Y but no mefs available.  Quitting.'
    signal finish
  end

  do k = 1 to file.0
    invfile = file.k
    rc = stream(invfile,"c","open")
    text = LineIn(invfile,1,1)
    Parse Var text .'|'.'|'device1'|'Plat'|'.
    Parse var device1 device'.'Something
    rc = lineout(invfile)
    devm.k = device
    Parse Upper var Plat platm.k
  end
end

If (ECMQues == 'Y') then do
  servnum = 0
  do while Lines(ECMFile)
    servnum = servnum + 1
    newline = LineIn(ECMFile)
    Parse UPPER VAR newline hname','.','.','.','.','.','.','IPA','
    hnames.servnum = hname
    IPAs.servnum = IPA
  end
say servnum
end

Beginhere: /* We will reset everything just in case */
Num = Num + 1

HostName = ''
IP = ''
Status = 'MIGRATION'
Environment = ''
DelT = ''
Platform = ''
Auto = 'NO' /* Assuming NO for all for now */
Role = ''
Masdev = ''
Desc = ''
LQEV = ''
LCBN = ''
Lpriv = ''
LCQEV = ''
LCCBN = ''
LCpriv = ''
Connection = 'DIRECT' /* If we stop assuming automatic is no, we will need to take this into account too */
ECMMap = '' /* This is normally left blank so for now I am not asking for it */

if (mefs == 'Y') then do
  if (num <= file.0) then do
    HostName = devm.num
    Say 'Hostname is 'HostName
  end
  else do
    Say 'Input information for  device #'num
    Say 'Device name (hostname) or leave blank to end'
    Pull HostName
    If (HostName == '') then signal finish
  end
end
else do
  Say 'Input information for  device #'num
  Say 'Device name (hostname) or leave blank to end'
  Pull HostName
  If (HostName == '') then signal finish
end

If (ECMQues = 'Y') then do 
  do j=1 to servnum
    if (hnames.j == HostName) then do 
      IP = IPAs.j
      j = servnum
      say IP
    end
  end
  if IP = '' then do
    say 'IP not set by ECM file'
    Say 'Device IP - defaults to 0.0.0.0 - we do not verify the IP is of valid syntax'
    Parse Pull IP
  end
end
else do
  Say 'Device IP - defaults to 0.0.0.0 - we do not verify the IP is of valid syntax'
  Parse Pull IP
end
If (IP == '') then IP = '0.0.0.0' /* Assuming 0.0.0.0 if no IP given */

/*
Say 'Status - Classification of the device status where the possible entries are : AVAILABLE / UNAVAILABLE / MIGRATION'
Pull Status
*/

Say 'Environment - Customer environment name'
Pull Environment
do While (Environment == '')
  Say 'Environment is required:'
  Pull Environment
end

Say 'Delivery Team - Delivery Team name that carried out the requests for this device'
do While (DelT == '')
  Say 'Delivery Team is required'
  Pull DelT
end

if (mefs == 'Y') then do
  if (num <= file.0) then do
      Platform = platm.num
      say ''
      Say 'Platform is 'Platform
      say ''
  end 
  else do
    Say 'Platform - Platform Name'
    Pull Platform
    do While (Platform == '')
      Say 'Platform is required'
      Pull Platform
    end
  end
end
else do
  Say 'Platform - Platform Name'
Pull Platform
  do While (Platform == '')
    Pull Platform
  end
end

/*
Say ' Automatic - Classification if the requests execution will be automatic where the possible entries are : YES / NO'
Pull Auto
*/

Say 'Role - Name of the role of the device where the possible entries are : STAND ALONE, PRIMARY DOMAIN CONTROLLER (NT4), LDAP MEMBER, CLUSTER MEMBER, SP NODE, BACKUP DOMAIN CONTROLLER (NT4), LDAP, LDAP SERVER, CLUSTER MASTER, SP CONTROL WORKSTATION'
do While (Role == '')
  Say 'Role required'
  Pull Role
end

Say 'Master device - Name of the master device of this device (case sensitive)'
Parse Pull MasDev

Say 'Description - Description of device functionality'
Parse Pull Desc

Say 'Last QEV - Date of last QEV revision using the format : YYYY-MM-DD'
Parse Pull LQEV

Say 'Last CBN - Date of last CBN revision using the format : YYYY-MM-DD'
Parse Pull LCBN

Say 'Last Privi - Date of last Privi revision using the format : YYYY-MM-DD'
Parse Pull Lpriv

Say 'Last Customer QEV - Date of last QEV revision using the format : YYYY-MM-DD'
Parse Pull LCQEV

Say 'Last Customer CBN - Date of last CBN revision using the format : YYYY-MM-DD'
Parse Pull LCCBN

Say 'Last Customer Privilege Revalidation - Date of last Privi revision using the format : YYYY-MM-DD'
Parse Pull LCpriv

/*
Say 'Connection - Name of the connection to the device, in the case of manual handheld devices the possible entry is: : DIRECT'
Pull Connection
*/

/*
Say 'ECM Mapping Name - Hostname or the instance name of the device that will be send to the ECM. This is an optional field, if you don't input the data, it will use the device name by default. : HOSTNAME / INSTANCE NAME'
Pull ECMMap
*/

fullstuff = Hostname':'IP':'Status':'Environment':'DelT':'Platform':'Auto':'Role':'Masdev':'Desc':'LQEV':'LCBN':'Lpriv':'LCQEV':'LCCBN':'LCpriv':'Connection':'ECMMap

rc = Lineout(Account'-device-migration.csv',fullstuff)
signal Beginhere

filelist:
/* give a list of all Inventory files that have been properly converted */
rc = SysFileTree('*Inv*.csv','file','FOI')
do k = 1 to file.0
  test = file.k
  say test
end
return

finish:

