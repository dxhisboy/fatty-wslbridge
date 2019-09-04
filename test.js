//var oShell = WScript.CreateObject("WScript.Shell");
var WshShell = new ActiveXObject("WScript.Shell");
var value = WshShell.RegRead("HKEY_CURRENT_USER\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Lxss\\DefaultDistribution");
WScript.echo(value);
// var oExec = oShell.Exec('wsl -l -v');
// var strOutput = oExec.StdOut.ReadAll();
// var strANSI = "";
// for (var i = 1; i < strOutput.length; i += 1){
//     //WScript.echo(strOutput[i], i);
//     strANSI = strANSI + strOutput.charCodeAt(i) + " ";
// }
// WScript.echo(strOutput.length);

// WScript.echo(strANSI);
