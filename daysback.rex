/* REXX Calculate days and business days from today */
/* Envisioned/designed/developed by Andy Willis */
/* Version 1.2 03May2017 */
Parse Arg DayCnt
if DayCnt = '' then do
  say "How many days back? Negative is back to the future."
  Parse Pull DayCnt
  end
Today = Date('B')
daydif = Today - DayCnt
weekday = Date('Base',Today,'Base')//7
value = 1
addd = 0
days = 0
daysall = DayCnt

if (DayCnt > 0) then do 
  if (DayCnt > weekday) then do
  hold = DayCnt - weekday
  do while (hold >= 1)
    days = days + 2
    hold = hold - 5
  end
    daysall = days + DayCnt
  end
busdays = Today - daysall
end
else do
  DaysCnt = DayCnt * -1
  if (DaysCnt > (5 - weekday)) then do
    additive = 5 - weekday
    hold = DaysCnt - additive
    do while (hold >=1)
      days = days + 2
      hold = hold - 5
    end
    daysall = DayCnt - days
  end
busdays = Today - daysall
end

mydate = Date('N',daydif,'B')
mybusdate = Date('N',busdays,'B')
myusdate = Date('USA',daydif,'B')
myusbusdate = Date('USA',busdays,'B')

parse var mydate day' 'Mon' 'year
parse var mybusdate bday' 'bMon' 'byear
parse var myusdate uday'/'uMon'/'.
parse var myusbusdate ubday'/'ubMon'/'ubyear

say
say DayCnt "Days back "
say mydate 
say myusdate
say uday'/'uMon'/'year
say day||Mon||year
say
say DayCnt "Weekdays back  Which is "daysall" totals days."
say mybusdate
say myusbusdate
say ubday'/'ubMon'/'byear
say bday||bMon||byear

