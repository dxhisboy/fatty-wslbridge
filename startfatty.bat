rem @echo off
rem if "%1" == "h" goto begin
rem mshta vbscript:createobject("wscript.shell").run("""%~nx0"" h",0)(window.close)&&exit
rem :begin
rem REM
%~dp0\bin\fatty.exe -w max -c %~dp0/mintty.conf %~dp0/bin/wslbridge2.exe -C ~
