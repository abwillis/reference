/* Test sorting alpha character strings */

string1 = 'aabc'
string2 = 'aaac'

say string1 < string2
say string1 = string2
say string1 > string2
say 'ANDY' < 'ANDREW'
say 'ANDY' = 'ANDREW'
say 'ANDY' > 'ANDREW'

test.1  = 'Andy'
test.2  = 'Andy'
test.3  = 'Andrew'
test.4  = 'Kurt'
test.5  = 'Daniel'
test.6  = 'Kurt'
test.7  = 'Bryan'
test.8  = 'Brian'
test.9  = 'Bruce'
test.10 = 'Tim'
test.11 = 'Sam'
test.12 = 'Dean'
test.13 = 'Buffy'
test.14 = 'William'
test.15 = 'Andy'
test.16 = 'Andy'
test.17 = 'Andy'
test.0 = 17

finala.0 = test.0
do k = 1 to test.0
  finala.k = ''
end

n = 0
do i = 1 to test.0
  Parse Upper var test.i a
  g = 1
  e = 0
  do j = 1 to test.0
    Parse Upper var test.j b
    If a > b then g = g + 1
    if a == b then e = e + 1
  end

  If (finala.g == '') then do
    q = g
    if (e % 4 < 1) then f = 1
    else f = e % 2
    do num = 1 to f
      n = n + 1
      finala.q = test.i
      q = q + 1
    end
  end
  say a g i e
end
final.0 = n
say n

j = 0
do i = 1 to finala.0
  if (finala.i <> '') then do
    j = j + 1
    final.j = finala.i
  end
end

say ''
do s = 1 to final.0
 say final.s 
end
  
