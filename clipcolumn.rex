/* Copy column to clipboard, one at a time - first column */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.3  4/11/2017 */
rc = SysLoadFuncs()

home = directory()
Parse ARG fileinv
if fileinv="" then pull fileinv

Do While Lines(fileinv)
inven = LineIn(fileinv)
Parse Var inven device1' '
Parse Var device1 '"'device'"'TheRest
if (device == "") then Parse Var device','TheRest
if (TheRest == "") then Parse Var device':'TheRest
if (TheRest == "") then Parse Var device';'TheRest
if (TheRest == "") then Parse Var device'|'TheRest
say device
cb = .WindowsClipboard~new
cb~copy(device)
Say "Hit Enter to continue"
pull continue
end
rc = stream(fileinv, 'c', 'close')

::requires "winSystm.cls"


