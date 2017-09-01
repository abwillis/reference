/* Copy column to clipboard, one at a time - first column */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.3.2  4/11/2017 */
rc = SysLoadFuncs()

home = directory()
Parse ARG fileinv delim
if fileinv="" then pull fileinv
if delim = "" then pull delim
if delim = '' then delim = ','

Do While Lines(fileinv)
  inven = LineIn(fileinv)
  Parse Var inven device1' '
  Parse Var device1 '"'device'"'TheRest
  if (device == "") then Parse Var device1 device (delim) .
  say device
  cb = .WindowsClipboard~new
  cb~copy(device)
  Say "Hit Enter to continue"
  pull continue
end
rc = stream(fileinv, 'c', 'close')

::requires "winSystm.cls"


