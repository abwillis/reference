/* Copy column to clipboard, one at a time - first column */
/* Envisioned, designed and written by Andy Willis */
/* Linux Version 1.1  1Sep2017 */
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
  'echo 'device' | xclip -selection c'
  Say "Hit Enter to continue"
  pull continue
end
rc = stream(fileinv, 'c', 'close')



