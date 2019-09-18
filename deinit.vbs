Set oReg = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv")

WSL1Reg = "Software\Classes\Directory\Background\shell\fatty-wsl1"
WSL2Reg = "Software\Classes\Directory\Background\shell\fatty-wsl2"
WSL2Reg = "Software\Classes\Directory\Background\shell\fatty-wsl"
DistrosReg = "Software\Classes\Directory\Background\shell\fatty-wsl-distros"
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

NeedDeleteMenu = MsgBox("Remove context menu?", 4)
If NeedDeleteMenu = 6 Then
  DeleteRegTree HKCU, WSL1Reg
  DeleteRegTree HKCU, WSL2Reg
  DeleteRegTree HKCU, WSLReg
  DeleteRegTree HKCU, DistrosReg
End If