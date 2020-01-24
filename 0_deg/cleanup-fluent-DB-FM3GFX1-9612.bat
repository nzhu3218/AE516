echo off
set LOCALHOST=%COMPUTERNAME%
set KILL_CMD="C:\PROGRA~1\ANSYSI~1\v192\fluent/ntbin/win64/winkill.exe"

"C:\PROGRA~1\ANSYSI~1\v192\fluent\ntbin\win64\tell.exe" DB-FM3GFX1 65165 CLEANUP_EXITING
if /i "%LOCALHOST%"=="DB-FM3GFX1" (%KILL_CMD% 3580) 
if /i "%LOCALHOST%"=="DB-FM3GFX1" (%KILL_CMD% 9612) 
if /i "%LOCALHOST%"=="DB-FM3GFX1" (%KILL_CMD% 1924)
del "P:\Classes\Spring 2020\516\PW\Tutorials and Tests\proj1\cases\scripting_practice\cleanup-fluent-DB-FM3GFX1-9612.bat"
