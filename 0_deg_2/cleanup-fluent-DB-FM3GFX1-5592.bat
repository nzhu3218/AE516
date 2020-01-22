echo off
set LOCALHOST=%COMPUTERNAME%
set KILL_CMD="C:\PROGRA~1\ANSYSI~1\v192\fluent/ntbin/win64/winkill.exe"

"C:\PROGRA~1\ANSYSI~1\v192\fluent\ntbin\win64\tell.exe" DB-FM3GFX1 53229 CLEANUP_EXITING
if /i "%LOCALHOST%"=="DB-FM3GFX1" (%KILL_CMD% 3848) 
if /i "%LOCALHOST%"=="DB-FM3GFX1" (%KILL_CMD% 5592) 
if /i "%LOCALHOST%"=="DB-FM3GFX1" (%KILL_CMD% 2024)
del "P:\Classes\Spring 2020\516\PW\Tutorials and Tests\proj1\cases\0_deg_2\cleanup-fluent-DB-FM3GFX1-5592.bat"
