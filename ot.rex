/* REXX Open directory in GUI */
rc = SysLoadFuncs()
first = arg(1)
curdir = directory(arg(1))
rc=sysopenobject(curdir,icon,false)
