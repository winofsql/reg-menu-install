Set objShellApplication = CreateObject("Shell.Application")
If WScript.Arguments.Count = 0 Then
	objShellApplication.ShellExecute "cscript.exe", Chr(34) & WScript.ScriptFullName & Chr(34) & " dummy", "", "runas", 1
	Wscript.Quit
End If

Set objShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")

target1 = "c:\app2"
target2 = "c:\app2\reg-menu"

If not objFSO.FolderExists(target1) Then

	objFSO.CreateFolder(target1)

End If

If not objFSO.FolderExists(target2) Then

	objShell.CurrentDirectory = target1

	objShell.Run "cmd /c git clone https://github.com/winofsql/reg-menu.git", 0, True
	objShell.Run "cmd /c cd c:\app2\reg-menu && rmdir .git /S /Q ", 0, True

	objShell.Run "cmd /c reg import " & target2 & "\user-desktop-icon.reg", 0, True
	objShell.Run "cmd /c reg import " & target2 & "\user-desktop-icon-app.reg", 0, True
	objShell.Run "cmd /c reg import " & target2 & "\user-gomi-icon.reg", 0, True
	objShell.Run "cmd /c cscript " & target2 & "\build-shortcut.vbs", 0, True

End If

MsgBox("desktop-reg-menu ê›íËÇèIóπÇµÇ‹ÇµÇΩÅB")
