echo off
set LOCALHOST=%COMPUTERNAME%
set KILL_CMD="C:\PROGRA~1\ANSYSI~1\v192\fluent/ntbin/win64/winkill.exe"

"C:\PROGRA~1\ANSYSI~1\v192\fluent\ntbin\win64\tell.exe" DB-FM3GFX1 58685 CLEANUP_EXITING
if /i "%LOCALHOST%"=="DB-FM3GFX1" (%KILL_CMD% 3812) 
if /i "%LOCALHOST%"=="DB-FM3GFX1" (%KILL_CMD% 11364) 
if /i "%LOCALHOST%"=="DB-FM3GFX1" (%KILL_CMD% 6720)
del "P:\Classes\Spring 2020\516\PW\Tutorials and Tests\proj1\cases\5_deg_repeat\cleanup-fluent-DB-FM3GFX1-11364.bat"
