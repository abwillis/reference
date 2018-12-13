#! /usr/bin/rexx
/* Test directory() in Linux */
curdir = directory()
rc = directory("testit")
say directory()
rc = directory('..')
say rc
say curdir
say Date('B')
say Date('S')
weekday = Date('Weekday', '01/15/98', 'Usa')
say weekday
say time()
