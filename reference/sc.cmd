/* close sockets */
rc = SysLoadFuncs()
Say 'Monitoring Sockets'
do While 1
call begin
end

begin:
'@echo off'
'netstat -s |grep CLOSE >sockets.txt'
do While Lines(sockets.txt)
socket1 = LINEIN(sockets.txt)
parse var socket1 socket 'STREAM'rest
'@echo on'
if socket<>0 then 'soclose 'socket
end
rc=stream('sockets.txt',c,'close')
rc = SysFileDelete(sockets.txt)
/* Say 'Sleeping' */
rc=SysSleep(600)
/* say 'begin check again' */
return