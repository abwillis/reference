:Date
@echo off
REM Initial subtraction code from Public Domain 
REM Revised and extended for business days and forward or backward by Andy Willis
REM Version 2.5 08Feb2017
set yyyy=
set dayCnt=%1
if [%1]==[] set /P dayCnt=How many days back? (negative numbers goes Back to the Future) 

set $tok=1-3
for /f "tokens=1 delims=.:/-, " %%u in ('date /t') do set $d1=%%u
if "%$d1:~0,1%" GTR "9" set $tok=2-4
for /f "tokens=%$tok% delims=.:/-, " %%u in ('date /t') do (
 for /f "skip=1 tokens=2-4 delims=/-,()." %%x in ('echo.^|date') do (
    set %%x=%%u
    set %%y=%%v
    set %%z=%%w
    set $d1=
    set $tok=))

if "%yyyy%"=="" set yyyy=%yy%
if /I %yyyy% LSS 100 set /A yyyy=2000 + 1%yyyy% - 100

set CurDate=%mm%/%dd%/%yyyy%

if "%dayCnt%"=="" set dayCnt=90

REM Substract your days here
set /A dd=1%dd% - 100 - %dayCnt%

set /A mm=1%mm% - 100

set ng=0
if /I %dayCnt% LSS 0 set ng=1
:CHKDAY

if /I %dd% GTR 31 goto ADDDAY
set ng=0
if /I %dd% GTR 0 goto DONE

set /A mm=%mm% - 1

if /I %mm% GTR 0 goto ADJUSTDAY

set /A mm=12
set /A yyyy=%yyyy% - 1

:ADJUSTDAY

if %mm%==1 goto SET31
if %mm%==2 goto LEAPCHK
if %mm%==3 goto SET31
if %mm%==4 goto SET30
if %mm%==5 goto SET31
if %mm%==6 goto SET30
if %mm%==7 goto SET31
if %mm%==8 goto SET31
if %mm%==9 goto SET30
if %mm%==10 goto SET31
if %mm%==11 goto SET30
REM ** Month 12 falls through

:SET31
if /I %ng% == 1 set /A dd=%dd% - 62
if /I %ng% == 1 set /A mm=%mm% + 1
if /I %ng%==1 if /I %mm%==13 set /A yyyy = %yyyy% + 1
if /I %ng%==1 if /I %mm%==13 set mm=1
set /A dd=31 + %dd%

goto CHKDAY

:SET30
if /I %ng% == 1 set /A dd=%dd% -60
if /I %ng% == 1 set /A mm=%mm% + 1
if /I %ng%==1 if /I %mm%==13 set /A yyyy = %yyyy% + 1
if /I %ng%==1 if /I %mm%==13 set mm=1
set /A dd=30 + %dd%

goto CHKDAY

:LEAPCHK

set /A tt=%yyyy% %% 4

if not %tt%==0 goto SET28

set /A tt=%yyyy% %% 100

if not %tt%==0 goto SET29

set /A tt=%yyyy% %% 400

if %tt%==0 goto SET29

:SET28

if /I %ng% == 1 set /A dd=%dd% - 56
if /I %ng% == 1 set /A mm=%mm% + 1
if /I %ng%==1 if /I %mm%==13 set /A yyyy = %yyyy% + 1
if /I %ng%==1 if /I %mm%==13 set mm=1
set /A dd=28 + %dd%

goto CHKDAY

:SET29

if /I %ng% == 1 set /A dd=%dd% - 58
if /I %ng% == 1 set /A mm=%mm% + 1
if /I %ng%==1 if /I %mm%==13 set /A yyyy = %yyyy% + 1
if /I %ng%==1 if /I %mm%==13 set mm=1
set /A dd=29 + %dd%

goto CHKDAY

:ADDDAY




if /I %mm% GTR 0 goto ADJUSTDAY

Goto CHKDAY

:DONE

set track="Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec"
for /F "tokens=%mm% delims=," %%y in (%track%) do set month=%%y

if /I %mm% LSS 10 set mm=0%mm%
if /I %dd% LSS 10 set dd=0%dd%

@echo %dayCnt% back
@echo %mm%/%dd%/%yyyy%

@echo %dd%%month%%yyyy%
:end
pause
