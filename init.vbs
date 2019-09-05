Set oWS = WScript.CreateObject("WScript.shell")
ScriptDir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
Set oReg = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv")

WSL1Reg = "Software\Classes\Directory\Background\shell\fatty-wsl1"
WSL2Reg = "Software\Classes\Directory\Background\shell\fatty-wsl2"
DistrosReg = "Software\Classes\Directory\Background\shell\fatty-wsl-distros"

LxssPath = "SOFTWARE\Microsoft\Windows\CurrentVersion\Lxss"
SharedArg = " -w max --dir " & ScriptDir & " -c .config\fattyrc --configdir .config "
WSLBridge = "usr/bin/wslbridge2.exe"
HVPty = "usr/bin/hvpty.exe"
Const HKCU   = &H80000001

Sub CreateShortCut(DistroName, Version)
  ShortCutFile = ScriptDir & "\fatty-" & DistroName & ".lnk"
  Bridge = HVPty
  If Version < 2 Then
    Bridge = WSLBridge
  End IF
  Set ShortCut = oWS.CreateShortCut(ShortCutFile)
  ShortCut.TargetPath = ScriptDir & "\usr\bin\fatty.exe"
  ShortCut.Arguments = SharedArg & Bridge & " -d " & DistroName & " -D ~"
  ShortCut.Save
End Sub

Sub CreateContextMenu(DistroName, Version)
  DistroReg = DistrosReg & "\shell\" & DistroName
  oReg.CreateKey HKCU, DistroReg
  oReg.SetStringValue HKCU, DistroReg, "", DistroName
  oReg.SetDWORDValue HKCU, DistroReg, "CommandFlags", 64
  oReg.SetStringValue HKCU, DistroReg, "Icon", "%localappdata%\Microsoft\WindowsApps\" & DistroName & ".exe"
  oReg.CreateKey HKCU, DistroReg & "\Command"
  If Version < 2 Then
    oReg.SetStringValue HKCU, DistroReg & "\Command", "", ScriptDir & "\usr\bin\fatty.exe" & SharedArg & WSLBridge & " -d " & DistroName & " -C %V"
  Else
    oReg.SetStringValue HKCU, DistroReg & "\Command", "", ScriptDir & "\usr\bin\fatty.exe" & SharedArg & HVPty & " -d " & DistroName & " -C %V"
  End If
End Sub

NeedContextMenu = MsgBox("Create context menu?", 4)
if NeedContextMenu = 6 Then
  oReg.DeleteKey HKCU, WSL1Reg
  oReg.DeleteKey HKCU, WSL2Reg
  oReg.DeleteKey HKCU, DistrosReg

  oReg.CreateKey HKCU, WSL1Reg
  oReg.SetStringValue HKCU, WSL1Reg, "", "Open fatty-wslbridge Here (WSL1)"
  oReg.setStringValue HKCU, WSL1Reg, "Icon", ScriptDir & "\usr\bin\fatty.exe"
  oReg.CreateKey HKCU, WSL1Reg & "\Command"
  oReg.setStringValue HKCU, WSL1Reg & "\Command", "", ScriptDir & "\usr\bin\fatty.exe" & SharedArg & WSLBridge & " -C %V"

  oReg.CreateKey HKCU, WSL2Reg
  oReg.SetStringValue HKCU, WSL2Reg, "", "Open fatty-wslbridge Here (WSL2)"
  oReg.setStringValue HKCU, WSL2Reg, "Icon", ScriptDir & "\usr\bin\fatty.exe"
  oReg.CreateKey HKCU, WSL2Reg & "\Command"
  oReg.setStringValue HKCU, WSL2Reg & "\Command", "", ScriptDir & "\usr\bin\fatty.exe" & SharedArg & HVPty & " -C %V"

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

