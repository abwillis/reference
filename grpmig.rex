/* USA group migration */
/* Envisioned/designed/developed by Andy Willis */
/* Version 1.1 25Jul2017 */

Num = 0
Say 'Groups migration form'

Say 'Account?'
Parse pull Account

Say 'Devices (MGR03 or device migration file) filename?'
Parse Pull MGR03

rc = SysFileTree(Account'-group-migration.csv','exist','FO')
if (exist.0 = 0) then do 
  rc = Lineout(Account'-group-migration.csv','environment:hostname:platform:group:intermediate code:type:system:primary:restricted:privileged:nested groups:access type:group description')
  /* Only add header if file does not exist, this allows adding to existing file */
  Say 'You will need to remove header before submitting, you should look at the output anyhow'
end

/* pull from Mef3 - linein(mef,1,1) just get hostname, lineout to close it */
rc = SysFileTree('*.mef3','file','FO')
if (file.0 == 0) then signal finish

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

say k

numl = 0
do While Lines(MGR03)
  numl = numl + 1
  mgrtext = LineIn(MGR03)
/* MGR03 has used ; delimiter but to use migration file created for devices need : and MGR03 in Brazil is starting to use | */
  Parse var mgrtext Dev03.numl';'.';'.';'env03.numl';'.';'plat03.numl';'.
  if (env03.numl == '') then Parse var mgrtext Dev03.numl':'.':'.':'env03.numl':'.':'plat03.numl':'.
  if (env03.numl == '') then Parse var mgrtext Dev03.numl'|'.'|'.'|'env03.numl'|'.'|'plat03.numl'|'.
end

do counter = 1 to file.0

  Environment = ''
  Hostname = ''
  Platform = ''
  Group = ''

  Hostname = devm.counter
  Say 'Device(s) - Device name: 'Hostname

  do l = 1 to numl
   If Dev03.l = Hostname then do
     kl = l
     l = numl
   end
  end

  /* Pulled from mgr03 */
  Environment = env03.kl
  Say 'Environment - Customer environment name: 'Environment

  /* Pulled from mgr03 */
  Platform = plat03.kl
  Say 'Platform - Platform name: 'Platform

  gps = 0 /* Number of unique groups found */
  agroups = ''
  do While Lines(file.counter)
    current = LineIn(File.counter)
    Parse var current .'|'.'|'.'|'.'|'NRIDCi'|'.'|'.'|'.'|'.'|'fgroups'|'privs
    Parse var NRIDCi NRIDC
    If (NRIDC <> 'NOTAREALID') then do

      rgroups = fgroups
      do while (rgroups <> '')
        Parse var rgroups cgroup','rgroups
        ngp = 1
        testgps = agroup
        do while (testgps <> '')
          Parse var testgps tgroup','testgps
          if (tgroup == cgroup) then do
            ngp = 0
          end
        end
        if ngp = 1 then do 
           agroups = agroups||','cgroup
           gps = gps + 1
           Group = cgroup
           Priv = 'NO'
           Nested = ''
           If (privs <> '') then do
             Parse var privs local'('firstg','restg')'
             iF (firstg == '') then Priv = 'YES'
             do while (firstg <> '')
               if (firstng == cgroup) then do
                 Priv = 'YES'
                 Nested = local'('firstng')'
               end
               Parse var restg firstg','restg
             end
           end
               
         intcode = ''
         Type = ''
         System = ''
         Primary = ''
         Restricted = ''
         priv = ''
         Nested = ''
         Access = ''
         Desc = ''

/* Next comment lines were original thought on how to handle groups, implementation changed but in case nested groups requires it to do it right will leave idea below */  
/* pull from Mef3 while lines(mef) linein(mef) parse first','something do while (something) i++ group.i=first parse something first','something */
/* Keep track of already found groups... add to a delimited line keeping track of how many unique groups, do loop with unique number of loops and if found set loop counter equal to unique number so that counter not incremented and delimted line not added to */
    
           Say 'Group - Group/profile name: ' cGroup

           Say 'Intermediate code - Intermediate code of the Group role owner'
           do while (intcode == '')
             Pull intcode
           end

           Say 'Type - Classification of the type of the group where the possible entries are : SYSTEM / APPLICATION / REGULAR / CUSTOMER'
           Pull Type
           If (Type == '') then Type = 'REGULAR'
           /* Probably default to Regular */

           Say 'System - Classification if the group is built in where the possible entries are : YES / NO'
           Pull System
           if (System == '') then System = 'NO'
           /* Probably default to No */

           Say 'Primary - Classification if the group is primary where the possible entries are : YES / NO'
           Pull Primary
           If (Primary == '') then Primary = 'NO'
           /* Probably default to no */

           Say 'Restricted - Classification if the group is restrict where the possible entries are : YES / NO'
           Pull Restricted
           If (Restricted = '') then Restricted = 'NO'
           /* determine default or set it to required answer */

 
           Say 'Privilege - Classification if the group is privileged where the possible entries are : YES / NO --:'
           Say priv
           /* pulled from mef */

           Say 'Nested groups - List of groups that contains this group as member : DEVICE1,GROUP1,GROUP2;DEVICE2,GROUP1,GROUP2,GROUP3 --:'
           Say Nested
           /* pulled from Mef3 */

           Say 'Access type - Access type provided by the group. The default option is GROUP. Possible entries: : GROUP / AREA / QUEUE / ATTRIBUTE / ALIAS / ROLE'
           Pull Access
           If (Access == '') then Access = 'GROUP'

           Say 'Group description - Provide the group description (maximum 512 characters). '
           Parse Pull Desc

           fullstuff = Environment':'Hostname':'Platform':'Group':'intcode':'Type':'System':'Primary':'Restricted':'Priv':'Nested':'Access':'Desc

           rc = Lineout(Account'-group-migration.csv',fullstuff)
        end
      end
    end
  end
end
signal Beginhere

finish:

