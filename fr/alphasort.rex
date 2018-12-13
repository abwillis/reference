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
test.0 = 14

final.0 = test.0
do k = 1 to test.0
  final.k = ''
end

do i = 1 to test.0
  Parse Upper var test.i a
  e = 0
  do j = 1 to test.0
    Parse Upper var test.j b
    If a > b then e = e + 1
  end
  n = e + 1
  do while (final.n <> '')
    n = n + 1
  end
  final.n = test.i
  say a e i
end

say ''
do s = 1 to final.0
 say final.s 
end
  
