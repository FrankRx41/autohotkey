WinGet, id, list, , , Program Manager
indexA := 0
Loop, %id%
{
	StringTrimRight, this_id, id%a_index%, 0
	WinGetTitle, this_title, ahk_id %this_id%
	WinGetClass, this_class, ahk_id %this_id%
	If (this_title ="" || this_class = "TApplication")	;空ウィンドウ潰し
		Continue
	else
		indexA += 1
		Menu, task_list, Add, &%indexA% %this_title%, Activate_Window
;		Menu, sub1, Add, Close, Close_Window
;		Menu, task_list, Add, &%indexA% %this_title%, :sub1

}
Menu, task_list, Show
return

Activate_Window:
	wtitle = %A_ThisMenuItem%
	StringGetPos, spacePos, wtitle, %A_Space%
	spacePos += 1
	StringTrimLeft, wtitle, wtitle, spacePos
	WinActivate, %wtitle%
	return

Close_Window:
	MsgBox, Close!
	return