# files
files
git push -u origin master

Scripts used in IAM Secondary Controls.
.rex files require Rexx to be installed, can be used on (unless otherwise noted) Linux, Windows, or even OS/2... may be able to run even on mainframe.
.cmd files are essentially windows batch files, only run on Windows (well potentially on OS/2 but at least some certainly will not.


altria-fix.rex     -- Fix specific issue with some Altria mef files.

cfcomp.rex         -- Compare first column of csv files (should handle ,;:| as delimters)

clipcolumn.rex     -- fills clipboard from column in text file - Windows only

lclipc.rex         -- fills clipboard from column in text file - Linux only

convert.rex        -- Proof of concept mef3 file conversion (incomplete)

custchk.rex        -- Sort customer, IBM, and unknown IDs in converted file into separate files based on labels.

daysback.rex       -- regular day date calculations

devmig.rex         -- Creates bulk device migration file

devmgr.rex         -- Clean device manager file for storage (remove first line and OS devices)

devteam.rex        -- Creates dev team bulk migration file

dircode.cmd        -- create directories on windows using account and quarter as parameters

diryear.cmd        -- create directory structure, takes account and year as parameters

dvmgos.rex         -- clean device manager file for OS (removes first line and storage devices)

ecminv.rex         -- Clean up ECM report for easier viewing of important to secondary controls information

ecmuatchk.rex      -- Check ECM against UAT (using DVC08 file)

emef.rex           -- Find extra mefs, compares mefs in current directory to inventory file

fixmef.rex         -- Fixes filename and environment (first column of mef3 file)

grpmig.rex         -- creates group bulk migration file (incomplete)

GVM.cmd            -- Launch validatemefs, downloads file to make sure latest and gives list of probable files and paths needed as well as date 30 days ago

hostlab.rex        -- Finds hosts for IDs in mapfile

listmefs.rex       -- createslist all mefs in current directory

mefdatemove.rex    -- Move date from end of mef3 filename to middle where it is expected.

mefDNS.rex         -- Show server and domain that the DNS error is caused by 

nestrem.rex        -- Creates datasource for IMacro for nested groups.

nomefs.rex         -- Find missing (from inventory file) mefs (from current directory)

open.cmd           -- open file manager on windows... will open current by default or the path given as parameter

pfdup.rex          -- Searches current directory for duplicate mef3 files and also checks for some common problems such as missing hostname in mef3 file

privown.rex        -- Creates an easy to use list from CSV of email and privs to input into URT for priv owners.  Input expected to be broken down by OS and in format OS,priv,owner,email.

recmac.rex         -- Creates datasource for iMacros for reconciliation.

recserv.rex        -- remove servers from recon file

rnfiles.rex        -- Rename files in bulk that have something in common

rpmpack.rex        -- Creates list of everything installed via yum/rpm

sortmefs.rex       -- Copy mef3 files into directories based on platform

splitind.rex       -- Split into individual files manually collected mefs

srvpull.rex        -- Specific use case, needed to pull lines from recon file for certain servers.

stripeascii.rex    -- Remove extended ascii characters

UIDLAB.rex         -- different layout of information in hostlab.rex

README.md          -- This file.

