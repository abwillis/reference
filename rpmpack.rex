/* REXX to get just package names from RPM installed output */

rc = SysLoadFuncs()
Parse Arg fileout

rc = SysFileDelete(fileout)
fileinv = holdrpm.txt

address cmd 'yum list |grep install >'fileinv
do while Lines(fileinv)
  text = LineIn(fileinv)
  parse var text package'.'.
  rc = Lineout(fileout,'yum install -y 'package)
end
rc = SysFileDelete(fileinv)
