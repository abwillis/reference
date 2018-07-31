#! /usr/bin/rexx
/* Create Directories based on account and quarter/year. */
/* Version 1.0 16Jul2018 */

rc = SysLoadFuncs()
home = directory()

Parse Arg Account QY

do While (Account == '')
  Say "Account?"
  Parse Pull Account
end

do While (QY == '')
  Say "Quarter Year (i.e. 1Q19)"
  Parse Pull QY
end

if (Account <> '.') then do
  rc = SysIsFileDirectory(Account)
  if (rc == 0) then rc = SysMkDir(Account)
  rc = directory(Account)
end
if (SysIsFileDirectory(QY) == 0) then rc = SysMkDir(QY)
rc = directory(QY)
if (SysIsFileDirectory(data) == 0) then rc = SysMkDir(data)
if (SysIsFileDirectory(evidence) == 0) then rc = SysMkDir(evidence)
if (SysIsFileDirectory(extra) == 0) then rc = SysMkDir(extra)
if (SysIsFileDirectory(hold) == 0) then rc = SysMkDir(hold)
if (SysIsFileDirectory(rem) == 0) then rc = SysMkDir(rem)
if (SysIsFileDirectory(recon) == 0) then rc = SysMkDir(recon)
if (SysIsFileDirectory(reports) == 0) then rc = SysMkDir(reports)
if (SysIsFileDirectory(cvscur) == 0) then rc = SysMkDir(cvscur)
if (SysIsFileDirectory(cvsprev) == 0) then rc = SysMkDir(cvsprev)
if (SysIsFileDirectory(mefcur) == 0) then rc = SysMkDir(mefcur)
if (SysIsFileDirectory(mefprev) == 0) then rc = SysMkDir(mefprev)
if (SysIsFileDirectory(doneprev) == 0) then rc = SysMkDir(doneprev)
if (SysIsFileDirectory(donecurr) == 0) then rc = SysMkDir(donecurr)
if (SysIsFileDirectory(delta) == 0) then rc = SysMkDir(delta)
if (SysIsFileDirectory(preprod) == 0) then rc = SysMkDir(preprod)
rc = directory(home)


