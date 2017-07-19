/* USA devices migration */
/* Envisioned/designed/developed by Andy Willis */
/* Version 1.0 19Jul2017 */

Num = 0
Say 'Device migration form'
Say 'There is no input validation occuring, other than for some fields that _something_ was supplied'
Say 'If empty is valid, just hit enter... if empty is not valid you will be prompted'
Say 'Currently assuming Status is migration (should normally be for new devices), automatic = NO, Connection therefore is blank, and ECMMap is left blank'
Say 'If needed can uncomment those questions.'
Say 'Leave Device Name empty to finish'

Say 'Account?'
Parse pull Account

Beginhere: /* We will reset everything just in case */
Num = Num + 1

HostName = ''
IP = '0.0.0.0' /* We will assume 0.0.0.0 if no IP given */
Status = 'Migration'
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
Connection = '' /* If we stop assuming automatic is no, we will need to take this into account too */
ECMMap = '' /* This is normally left blank so for now I am not asking for it */

Say 'Input information for  device #'num
Say 'Device name (hostname) or leave blank to end'
Pull HostName
If (HostName == '') then signal finish

Say 'Device IP - defaults to 0.0.0.0 - we do not verify the IP is of valid syntax'
Parse Pull IP
If (IP == '') then IP = '0.0.0.0'

/*
Say 'Status - Classification of the device status where the possible entries are : AVAILABLE / UNAVAILABLE / MIGRATION'
Pull Status
*/

Say 'Environment - Customer environment name'
EnvReq:
Pull Environment
If (Environment == '') then do
  Say 'Environment required'
  signal EnvReq
end

Say 'Delivery Team - Delivery Team name that carried out the requests for this device'
DTReq:
Parse Pull DelT
If (DelT == '') then do
  Say 'Delivery Team required'
  signal DTReq
end

Say 'Platform - Platform Name'
PNReq:
Pull Platform
If (Platform == '') then do
  Say 'Platform required'
  signal PNReq
end

/*
Say ' Automatic - Classification if the requests execution will be automatic where the possible entries are : YES / NO'
Pull Auto
*/

Say 'Role - Name of the role of the device where the possible entries are : STAND ALONE, PRIMARY DOMAIN CONTROLLER (NT4), LDAP MEMBER, CLUSTER MEMBER, SP NODE, BACKUP DOMAIN CONTROLLER (NT4), LDAP, LDAP SERVER, CLUSTER MASTER, SP CONTROL WORKSTATION'
RoleReq:
Parse Pull Role
If (Role == '') then do
  Say 'Role required'
  signal RoleReq
end

Say 'Master device - Name of the master device of this device'
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

finish:

