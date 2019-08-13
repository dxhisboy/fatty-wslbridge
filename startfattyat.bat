rem @echo off
rem if "%1" == "h" goto begin
rem mshta vbscript:createobject("wscript.shell").run("""%~nx0"" h",0)(window.close)&&exit
rem :begin
rem REM
for /f "delims=" %%a in ('wsl.exe -e wslpath -u -a %1') do @set extpath=%%a
%~dp0\bin\fatty.exe -w max -c %~dp0/mintty.conf %~dp0/bin/wslbridge2.exe -C %extpath%
