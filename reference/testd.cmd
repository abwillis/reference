@echo off
set /a dw=8
set /a adddaysto=0
set /a shifted=0

if "%Date:~0,3%"=="Thu" set /A dw = 2
if "%Date:~0,3%"=="Fri" set /A dw = 1
if "%Date:~0,3%"=="Sat" set /A dw = 0
if "%Date:~0,3%"=="Sun" set /A dw = 6
if "%Date:~0,3%"=="Mon" set /A dw = 5
if "%Date:~0,3%"=="Tue" set /A dw = 4
if "%Date:~0,3%"=="Wed" set /A dw = 3

@echo dw is %dw%

set /A dayCnt = 3
@echo dayCnt is %dayCnt%

if %dayCnt% GTR %dw% goto busdayadd
goto countedday

:busdayadd
@echo on
set /A dayaddit = %dayCnt% + %dw%

set /A daycheck = %dayaddit% / 7

set /A adddaysto = (%daycheck% * 2) + 2

:countedday

@echo %adddaysto%

