#! /usr/bin/rexx
/* Sort customer, IBM, and unknown IDs in converted file into separate files based on labels. */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.1  21Sep2017 */

rc = SysLoadFuncs()
home = directory()

parse arg reconfile account

if reconfile = '' then call getreconfile
if (account == '') then call getaccnt
output = 'output'

/* Easiest way to be cross compatibile and avoid slash vs. backslash */
/* Getting reconfile fullpath and will move to output directory, just because it is cleaner for many recon files */
rc = SysFileTree(reconfile,'recons','FO')
if (recons.0 == 0) then call finish
rc = SysIsFileDirectory(output)
if (rc == 0) then rc = sysmkdir(output)

rc = directory(output)
rc = SysFileDelete(account'-cust-recon.csv')
rc = SysFileDelete(account'-unk-recon.csv')
rc = SysFileDelete(account'-ibm-recon.csv')

recon = recons.1
rc = stream(recon,"c","open")
do while lines(recon)
  words = linein(recon)
  parse var words A1':'B1':'C1':'D1':'E1':'F1':'G1':'H1':'I1':'J1':'K1':'
  if (A1 == "GRP") then do
    call putcust
    call putibm
    call putunk
  end  
  if (A1 == "USR") then call usrparse
end  
rc = stream(recon,"c","close")
  
call finish  
  
getreconfile:
Say "Reconciliation file?"
Parse Pull reconfile
return
  
getaccnt:
say "What account?"
parse pull account
return

putcust:
  rc = lineout(account'-cust-recon.csv',A1':'B1':'C1':'D1':'E1':'F1':'G1':'H1':'I1':'J1':'K1':')
return

putibm:
  rc = lineout(account'-ibm-recon.csv',A1':'B1':'C1':'D1':'E1':'F1':'G1':'H1':'I1':'J1':'K1':')
return

putunk:
  rc = lineout(account'-unk-recon.csv',A1':'B1':'C1':'D1':'E1':'F1':'G1':'H1':'I1':'J1':'K1':')
return

/* Below are the current and obsolete but possibly used label types */
usrparse:
  parse var G1 .'/'which'/'
    SELECT
      WHEN which = 'C' then do
        call putcust
      end
      WHEN which = 'I' then do
        call putibm
      end
      WHEN which = 'E' then do
        call putibm
      end
      WHEN which = 'F' then do
        call putibm
      end
      WHEN which = 'S' then do
        call putibm
      end
      When which = 'N' then do
        call putibm
      end
      When which = 'T' then do
        call putibm
      end
      Otherwise call putunk
    end  
return      

finish:
rc = directory(home)
