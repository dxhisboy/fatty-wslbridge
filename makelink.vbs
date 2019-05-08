scriptdir = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
Set oWS = WScript.CreateObject("WScript.Shell")
sLinkFile = scriptdir + "\fatty.lnk"
Set oLink = oWS.CreateShortcut(sLinkFile)
    oLink.TargetPath = scriptdir + "\fatty.exe"
    oLink.Arguments = "-w max -c " + scriptdir + "\mintty.conf " + scriptdir + "\wslbridge.exe -C ~"
 '  oLink.Description = "Start wslbridge in fatty"   
 '  oLink.WindowStyle = "1"   
 '  oLink.WorkingDirectory = "C:\Program Files\MyApp"
oLink.Save