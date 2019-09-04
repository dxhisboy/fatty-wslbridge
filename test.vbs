Set oReg = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\default:StdRegProv")
strKeyPath = "SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Lxss"
Const HKEY_CURRENT_USER   = &H80000001
oReg.EnumKey HKEY_CURRENT_USER, strKeyPath, arrSubKeys
oReg.EnumValues HKEY_CURRENT_USER, strKeyPAth, arrSubNames, arrTypes
For I=0 To UBound(arrSubNames)
 wscript.echo arrSubNames(I), arrTypes(I)
Next
For Each strSubkey In arrSubKeys
  wscript.echo strSubkey
  
Next
;https://docs.microsoft.com/en-us/previous-versions/windows/desktop/regprov/enumvalues-method-in-class-stdregprov