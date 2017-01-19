/* Open directory in wps */

call RxFuncAdd 'Sysopenobject', 'RexxUtil', 'Sysopenobject'

MyArg = Arg(1)

If Left( MyArg,1 ) = '"' then 
Parse var MyArg '"' MyArg
If right( MyArg,1 ) = '"' then
Parse var MyArg MyArg '"'
If right( MyArg,1 ) = '\' then
Parse var MyArg MyArg '\'
If MyArg = "" Then do
MyArg = .
end

curdir = directory(MyArg)
/* rc=SysSetObjectData(curdir, "OPEN="||icon) */
rc=sysopenobject(curdir,icon,true)
rc=sysopenobject(curdir,icon,true)
exit