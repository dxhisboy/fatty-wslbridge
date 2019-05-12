fattydir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) + "\"
Set oWS = WScript.CreateObject("WScript.Shell")

fattyreg = "HKCU\Software\Classes\Directory\Background\shell\fatty-wslbridge\"
oWS.RegDelete fattyreg + "Icon"
oWs.RegDelete fattyreg + "Command\"
oWS.RegDelete fattyreg

