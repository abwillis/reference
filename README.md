# files
files
git push -u origin master

Scripts used in IAM Secondary Controls.
.rex files require Rexx to be installed, can be used on (unless otherwise noted) Linux, Windows, or even OS/2... may be able to run even on mainframe.
.cmd files are essentially windows batch files, only run on Windows (well potentially on OS/2 but at least some certainly will not.


altria-fix.rex     -- Fix specific issue with some Altria mef files.

daysall.cmd        -- Date calculations - regular days and business (weekdays)

diryear.cmd        -- create directory structure, takes account and year as parameters

hostlab.rex        -- Finds hosts for IDs in mapfile

UIDLAB.rex         -- different layout of information in hostlab.rex

rnfiles.rex        -- Ren bulk files that have something in common

busdayback.cmd     -- Business(weekday) day date calculations

daysback.rex       -- regular day date calculations

dvmgos.rex         -- clean device manager file for OS (removes first line and storage devices)

listmefs.rex       -- createslist all mefs in current directory

rpmpack.rex        -- Creates list of everything installed via yum/rpm

busday.cmd         -- calclulate business (weekday) days

days.cmd           -- calcullate regular days

ecminv.rex         -- Clean up ECM report for easier viewing of important to secondary controls information

nomefs.rex         -- Find missing (from inventory file) mefs (from current directory)

cfcomp.rex         -- Compare first column of csv files (should handle ,;:| as delimters)

devmgr.rex         -- Clean device manager file for storage (remove first line and OS devices)

emef.rex           -- Find extra mefs, compares mefs in current directory to inventory file

open.cmd           -- open file manager on windows... will open current by default or the path given as parameter

clipcolumn.rex     -- fills clipboard from column in text file - Windows only

lclipc.rex         -- fills clipboard from column in text file - Linux only

devmig.rex         -- Creates bulk device migration file

fixmef.rex         -- Fixes filename and environment (first column of mef3 file)

devteam.rex        -- Creates dev team bulk migration file

grpmig.rex         -- creates group bulk migration file (incomplete)

pfdup.rex          -- Searches current directory for duplicate mef3 files and also checks for some common problems such as missing hostname in mef3 file

convert.rex        -- Proof of concept mef3 file conversion (incomplete)

dircode.cmd        -- create directories on windows using account and quarter as parameters

GVM.cmd            -- Launch validatemefs, downloads file to make sure latest and gives list of probably files and paths needed as well as date 30 days ago

privown.rex        -- Creates an easy to use list from CSV of email and privs to input into URT for priv owners.  Input expected to be broken down by OS and in format OS,priv,owner,email.

recmac.rex         -- Creates datasource for iMacros for reconciliation.

nestrem.rex        -- Creates datasource for IMacor for nested groups.

README.md          -- This file.

