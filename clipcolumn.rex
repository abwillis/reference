/* Copy column to clipboard, one at a time */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.1  3/07/2017 */
rc = SysLoadFuncs()

home = directory()
Parse ARG fileinv
if fileinv="" then pull fileinv

Do While Lines(fileinv)
inven = LineIn(fileinv)
Parse Var inven device1' '
Parse Var device1 device','TheRest
say device
cb = .WindowsClipboard~new
cb~copy(device)
Say "Hit Enter to continue"
pull continue
end
rc = stream(fileinv, 'c', 'close')

::requires "winSystm.cls"