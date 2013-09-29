SetWorkingDir,%A_ScriptDir%
InputBox, UserInput, Enter passward,,HIDE, 200, 100
if (UserInput=="baba")
{
	Run, lib\AutoHotkey\AutoHotkey.exe lib\AutoHotkey\AutoHotkey.ahk
}
if (UserInput!="baba" && UserInput!="")
{
	MsgBox, 16, Sorry, Wrong number!
	IfMsgBox, OK
	{
		Reload
	}
}
