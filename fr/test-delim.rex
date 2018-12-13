/* Test using variable delimeters */
/* Envisioned, designed and written by Andy Willis */

parse arg file delim

tline = linein(file)
rc=lineout(file)
Parse Upper Var tline '"'first'"' (delim) '"'second'"' (delim) '"'third'"' (delim) '"'fourth'"' (delim) '"'fifth'"' (delim) '"'sixth'"' (delim) '"'seventh'"' (delim) '"'eighth'"' (delim) '"'ninth'"' (delim) '"'tenth'"' (delim) '"'eleventh'"'
if (first = '') then Parse Upper Var tline first (delim) second (delim) third (delim) fourth (delim) fifth (delim) sixth
say first second third fourth fifth sixth seventh eighth ninth tenth eleventh

say 'test output'
say first''second''third
