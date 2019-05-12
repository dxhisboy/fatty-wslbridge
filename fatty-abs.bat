@echo off
if "%1" == "h" goto begin
mshta vbscript:createobject("wscript.shell").run("""%~nx0"" h",0)(window.close)&&exit
:begin
REM
bin\fatty.exe -w max -c %cd%/mintty.conf %cd%/bin/wslbridge.exe -C ~
