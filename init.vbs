Set oWS = WScript.CreateObject("WScript.shell")
ScriptDir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
Set oReg = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv")

WSL1Reg = "Software\Classes\Directory\Background\shell\fatty-wsl1"
WSL2Reg = "Software\Classes\Directory\Background\shell\fatty-wsl2"
WSLReg = "Software\Classes\Directory\Background\shell\fatty-wsl"
DistrosReg = "Software\Classes\Directory\Background\shell\fatty-wsl-distros"

LxssPath = "SOFTWARE\Microsoft\Windows\CurrentVersion\Lxss"
SharedArg = " -w max -c """ & ScriptDir & "\.config\fattyrc"" "
' " -w max --dir " & ScriptDir & " -c .config\fattyrc --configdir .config "
UnquotedBridge = ScriptDir & "/usr/bin/unquote.exe " & ScriptDir & "/usr/bin/rawpty.exe"
Bridge = ScriptDir & "/usr/bin/rawpty.exe"
Const HKCU   = &H80000001

Sub DeleteRegTree(hDef, strKeyPath)
  oReg.EnumKey hDef, strKeyPath, arrSubkeys
  If IsArray(arrSubkeys) Then
    For Each strSubkey In arrSubkeys
      DeleteRegTree hDef, strKeyPath & "\" & strSubkey
    Next
  End If
  oReg.DeleteKey hDef, strKeyPath
End Sub

Sub CreateShortCut(DistroName, Version)
  ShortCutFile = ScriptDir & "\fatty-" & DistroName & ".lnk"
  Set ShortCut = oWS.CreateShortCut(ShortCutFile)
  ShortCut.TargetPath = ScriptDir & "\usr\bin\fatty.exe"
  ShortCut.Arguments = SharedArg & Bridge & " wsl.exe ~ -d " & DistroName
  ShortCut.Save
End Sub

Sub CreateContextMenu(DistroName, Version)
  DistroReg = DistrosReg & "\shell\" & DistroName
  oReg.CreateKey HKCU, DistroReg
  oReg.SetStringValue HKCU, DistroReg, "", DistroName
  oReg.SetDWORDValue HKCU, DistroReg, "CommandFlags", 64
  oReg.SetStringValue HKCU, DistroReg, "Icon", "%localappdata%\Microsoft\WindowsApps\" & DistroName & ".exe"
  oReg.CreateKey HKCU, DistroReg & "\Command"
  oReg.SetStringValue HKCU, DistroReg & "\Command", "", ScriptDir & "\usr\bin\fatty.exe" & SharedArg & UnquotedBridge & " 'wsl.exe -d " & DistroName & " --cd ""%V""'"
End Sub

NeedContextMenu = MsgBox("Create context menu?", 4)
if NeedContextMenu = 6 Then
  DeleteRegTree HKCU, WSL1Reg
  DeleteRegTree HKCU, WSL2Reg
  DeleteRegTree HKCU, WSLReg
  DeleteRegTree HKCU, DistrosReg

  oReg.CreateKey HKCU, WSLReg
  oReg.SetStringValue HKCU, WSLReg, "", "Open fatty-wslbridge Here"
  oReg.setStringValue HKCU, WSLReg, "Icon", ScriptDir & "\usr\bin\fatty.exe"
  oReg.CreateKey HKCU, WSLReg & "\Command"
  oReg.setStringValue HKCU, WSLReg & "\Command", "", ScriptDir & "\usr\bin\fatty.exe" & SharedArg & UnquotedBridge & " 'wsl.exe --cd ""%V""'"

  oReg.CreateKey HKCU, DistrosReg
  oReg.SetStringValue HKCU, DistrosReg, "MUIVerb", "Open fatty Here with Distro"
  oReg.SetStringValue HKCU, DistrosReg, "Subcommands", ""
  oReg.setStringValue HKCU, DistrosReg, "Icon", ScriptDir & "\usr\bin\fatty.exe"
End If
oReg.EnumKey HKCU, LxssPath, DistroIDs

For Each DistroID In DistroIDs
  oReg.GetStringValue HKCU, LxssPath & "\" & DistroID, "DistributionName", DistroName
  oReg.GetDWORDValue HKCU, LxssPath & "\" & DistroID, "Version", DistroVer
  CreateShortCut DistroName, DistroVer
  If NeedContextMenu = 6 Then
    CreateContextMenu DistroName, DistroVer
  End If
'  WScript.Echo DistroID, DistroName, DistroVer
Next

