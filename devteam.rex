/* USA delivery team migration 1.0 10Apr2017 */
Org = 'SARM'
Cntry = 'USA'
Per = '8x5'
TZ = '-6'
IT = '08-00'
ET = '17-00'
SAY "This script assumes Organization:" Org", Country: "Cntry", Time Period: "Per","
SAY "Timezone: "TZ", and time: "IT" to "ET"."
/* User can either change these above or correct the csv */
SAY "Leave Delivery Team Name field blank and hit enter to end."
SAY "All other fields "
getinfo:
Name=''
SAY "Delivery Team Name"
Parse Pull Name
if Name='' then signal finish
SAY "Email for Delivery Team"
Parse Pull Email
SAY "Description of Delivery Team"
Parse Pull Desc
SAY "Intermediate code of role responsible for Delivery Team"
Parse Pull IntC
info = Name':'Email':'Org':'Cntry':'Per':'TZ':'IT':'ET':'Desc':'IntC
rc = LineOut('DTeam.csv',info)
signal getinfo

finish: