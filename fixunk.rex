#! /usr/bin/rexx
/* Set labels in unk recon files from ibm or customer recon files */
/* Envisioned, designed and written by Andy Willis */
/* Version 1.2  28Jun2018 */

rc = SysLoadFuncs()
home = directory()

parse arg unknown ibm cust
output = 'output'

if (unknown == '') then do
  say "What is filename containing unknown labels?"
  parse pull unknown
end

if (ibm == '') then do
  say "What is the filename containing ibm labels?"
  parse pull ibm
end

if (cust == '') then do
  say "What is the filename containing customer labels?"
  parse pull cust
end

/* Easiest way to be cross compatibile and avoid slash vs. backslash */
/* Getting reconfile fullpath and will move to output directory, just because it is cleaner for many recon files */
rc = SysFileTree(unknown,'unks','FO')
rc = SysFileTree(ibm,'internals','FO')
rc = SysFileTree(cust,'customers','FO')
if (unks.0 == 0) then call finish
rc = SysIsFileDirectory(output)
if (rc == 0) then rc = sysmkdir(output)

rc = directory(output)
rc = SysFileDelete('ibm-label.csv')
rc = SysFileDelete('cust-label.csv')
rc = SysFileDelete('unk-label.csv')

say "Parsing Files"
a = 0
unk = unks.1
rc = stream(unk,"c","open")
do while lines(unk)
  words = linein(unk)
  parse var words A1':'B1':'C1':'D1':'E1':'F1':'G1':'H1':'I1':'J1':'K1':'
  if (A1 == "USR") then do
    a = a + 1 
    UA1.a = A1
    UB1.a = B1
    UC1.a = C1
    UD1.a = D1
    UE1.a = E1
    UF1.a = F1
    UG1.a = G1
    UH1.a = H1
    UI1.a = I1
    UJ1.a = J1
    UK1.a = K1
  end
end  
rc = stream(unk,"c","close")
UA1.0 = a

b = 0
internal = internals.1
rc = stream(internal,"c","open")
do while lines(internal)
  words = linein(internal)
  parse var words A1':'B1':'C1':'D1':'E1':'F1':'G1':'H1':'I1':'J1':'K1':'
  if (A1 == "USR") then do
    b = b + 1 
    IA1.b = A1
    IB1.b = B1
    IC1.b = C1
    ID1.b = D1
    IE1.b = E1
    IF1.b = F1
    IG1.b = G1
    IH1.b = H1
    II1.b = I1
    IJ1.b = J1
    IK1.b = K1
  end
end  
rc = stream(internal,"c","close")
IA1.0 = b

c = 0
customer = customers.1
rc = stream(customer,"c","open")
do while lines(customer)
  words = linein(customer)
  parse var words A1':'B1':'C1':'D1':'E1':'F1':'G1':'H1':'I1':'J1':'K1':'
  if (A1 == "USR") then do
    c = c + 1 
    CA1.c = A1
    CB1.c = B1
    CC1.c = C1
    CD1.c = D1
    CE1.c = E1
    CF1.c = F1
    CG1.c = G1
    CH1.c = H1
    CI1.c = I1
    CJ1.c = J1
    CK1.c = K1
  end
end  
rc = stream(customer,"c","close")
CA1.0 = c

say "Done parsing files, now comparing."

drop a b c
drop words
drop A1 B1 C1 D1 E1 F1 G1 H1 I1 J1 K1

/* Check unknown against IBM */
a = 0
do b = 1 to UA1.0
  match = 0
  do c = 1 to IA1.0
    if (UD1.b == ID1.c) then do
      rc = lineout('ibm-label.csv',UA1.b':'UB1.b':'UC1.b':'UD1.b':'UE1.b':'UF1.b':'IG1.c':'UH1.b':'UI1.b':'UJ1.b':'UK1.b':')
      match = 1
      c = IA1.0
    end
  end
  if (match == 0) then do
    a = a + 1
    L.a = b
  end
end
L.0 = a

drop a b c

/* Check customer against IBM */
do b = 1 to CA1.0
  match = 0
  do c = 1 to IA1.0
    if (CD1.b == ID1.c) then do
      rc = lineout('ibm-label.csv',CA1.b':'CB1.b':'CC1.b':'CD1.b':'CE1.b':'CF1.b':'IG1.c':'CH1.b':'CI1.b':'CJ1.b':'CK1.b':')
      match = 1
      c = IA1.0
    end
  end
end

drop a b c

/* Check Customer against unknown */
do a = 1 to L.0
  b = L.a
  match = 0
  do c = 1 to CA1.0
    if (UD1.b == CD1.c) then do
      rc = lineout('cust-label.csv',UA1.b':'UB1.b':'UC1.b':'UD1.b':'UE1.b':'UF1.b':'CG1.c':'UH1.b':'UI1.b':'UJ1.b':'UK1.b':')
      match = 1
      i = CA1.0
    end
  end
  if (match == 0) then do
    rc = lineout('unk-label.csv',UA1.b':'UB1.b':'UC1.b':'UD1.b':'UE1.b':'UF1.b':'UG1.b':'UH1.b':'UI1.b':'UJ1.b':'UK1.b':')
  end
end
