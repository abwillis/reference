@REM Open directory
@REM Version 1.0
@echo off
if [%1]==[] (powershell ii .
	) Else (
		powershell ii %1
		cd %1
	)
