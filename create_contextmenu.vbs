fattydir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) + "\"
Set oWS = WScript.CreateObject("WScript.Shell")

fattyreg = "HKCU\Software\Classes\Directory\Background\shell\fatty-wslbridge\"
oWS.RegWrite fattyreg, "Open fatty-wslbridge Here", "REG_SZ"
oWS.RegWrite fattyreg + "Icon", fattydir + "bin\fatty.exe", "REG_SZ"
oWs.RegWrite fattyreg + "Command\", fattydir + "startfattyat.bat %V", "REG_SZ"

fattyreg = "HKCU\Software\Classes\Directory\shell\fatty-wslbridge\"
oWS.RegWrite fattyreg, "Open fatty-wslbridge Here", "REG_SZ"
oWS.RegWrite fattyreg + "Icon", fattydir + "bin\fatty.exe", "REG_SZ"
oWs.RegWrite fattyreg + "Command\", fattydir + "startfattyat.bat %V", "REG_SZ"
