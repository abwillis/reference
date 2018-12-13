#! /usr/bin/rexx
/* Check Parse UPPER with numbers */

text1 = 'o|p|9|0|P|O|/|'
Parse upper var text1 a1'|'b1'|'c1'|'d1'|'e1'|'f1'|'g1'|'
parse var text1 a2'|'b2'|'c2'|'d2'|'e2'|'f2'|'g2'|'

say a2' 'b2' 'c2' 'd2' 'e2' 'f2' 'g2
say a1' 'b1' 'c1' 'd1' 'e1' 'f1' 'g1
