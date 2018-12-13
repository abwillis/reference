/* Create a list of devices found in mef3 files */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.0  4/10/2017 */
rc = SysLoadFuncs()
home = directory()

rc = SysFileDelete('listmefs.csv')
rc = SysFileDelete('listmefs-nh.csv')
rc = SysFileTree('*.mef3','file','FO')
if (file.0 == 0) then call finish

do k = 1 to file.0
invfile = file.k
rc = stream(invfile,"c","open")
do while lines(invfile)
text = LineIn(invfile)
Parse Var text Something
                                                 
below = xrange('00'x,'1F'x)                             
above = xrange('80'x,'FF'x)

test = verify(Something,above,'M')
if (test <> 0) then do
  yyy = translate(Something,,above,'')
end
else do
  yyy = Something
end
 
say 'old = »»»'Something"«««"                          
say 'new = »»»'yyy"«««"                          
rc = lineout(test.mef3,yyy)
say test
end                                                
rc = lineout(invfile) 
end

/* rc = stream(fileinv, "c", "close") :::: This will cause segmentation fault on Linux if run many times */
finish:





