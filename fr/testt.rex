/*REXX program strips all  "control codes"  from a character string  (ASCII or EBCDIC). */
/* xxx= 'string of ☺☻♥♦⌂, may include control characters and other ilk.♫☼§►↔◄' */
xxx = 'string of ☺☻♥♦⌂, may include control characters and other    ♫☼§►↔◄░▒▓█┌┴┐±÷²¬└┬┘ilk.'

below = xrange('00'x,'1F'x)             
above = xrange('80'x,'FF'x)
yyy  = translate(xxx,,above,'00'x)
zzz  = translate(yyy,,below,'00'x)


 
say 'old = »»»'xxx"«««" 
say 'new = »»»'yyy"«««" 
say 'newer = »»»'zzz"«««" 


