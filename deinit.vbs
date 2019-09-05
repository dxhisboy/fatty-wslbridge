Set oReg = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv")

WSL1Reg = "Software\Classes\Directory\Background\shell\fatty-wsl1"
WSL2Reg = "Software\Classes\Directory\Background\shell\fatty-wsl2"
DistrosReg = "Software\Classes\Directory\Background\shell\fatty-wsl-distros"

NeedDeleteMenu = MsgBox("Remove context menu?", 4)
If NeedDeleteMenu = 6 Then
  oReg.DeleteKey HKCU, WSL1Reg
  oReg.DeleteKey HKCU, WSL2Reg
  oReg.DeleteKey HKCU, DistrosReg
End If