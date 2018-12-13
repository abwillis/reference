/*test date function*/
rc = SysLoadFuncs()
today = Date('Base')
say today
Ndate  = Date('Normal',today,'Base')
say ndate
parse var ndate day' 'mon' 'year
tdate = day||mon||year
say tdate
ldate='l'tdate
say ldate
