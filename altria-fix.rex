#! /usr/bin/rexx
/* Fix specific set of Mef3 files in 4th column to remove extraneous hostname\ */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.0.01  19Sep2017 */

rc = SysLoadFuncs()
home = directory()
rc = SysFileTree('*.mef3','mef','FOI')

Do m=1 to mef.0
  invfile = mef.m
  do while lines(invfile)
    text = LineIn(invfile)
    Parse Var text first'|'second'|'third'|'fourth':'.'\'fifth
    rc = lineout('tempfile.'m,first'|'second'|'third'|'fourth':'fifth)
  end
  rc = lineout(invfile)
  rc = SysFileDelete(invfile)
  rc = SysFileMove('tempfile.'m,invfile)
end
