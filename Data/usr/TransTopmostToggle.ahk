;===============================================================================
; TransTopmostToggle.ahk - アクティブなウィンドウの半透明化と最前面化をToggleする。(2005/12/14)
;===============================================================================

#Persistent

class =
flag = 0

SetTimer, Reflesh, 1000	;1秒ごとに対象ウィンドウの有無を確認し、無くなっていればこのスクリプトを初期状態に戻す。
return

OnExit, ExitSub
return

;"Win+Alt+T"で本体実行
#!t::
	If class =
	{
		WinGetClass, class, A
		WinGetTitle, title, A
		MsgBox, 4, TransTopmostToggle, "%title%" をTransTopmostToggleの対象にしますか？
		IfMsgBox, No
		{
			class =
			flag = 0
			return
		}
	}
	If flag<>0
	{
		WinSet, Transparent, Off, ahk_class %class%
		WinSet, Topmost, Off, ahk_class %class%
		flag = 0
		return
	}
	else
	{
		WinSet, Transparent, 200, ahk_class %class%	;ウィンドウの不透明度(200/255)
		WinSet, Topmost, On, ahk_class %class%
		flag = 1
		return
	}

Reflesh:
	IfWinNotExist, ahk_class %class%
	{
		class =
		flag = 0
	}
	return

ExitSub:
	WinSet, Transparent, Off, ahk_class %class%
	WinSet, Topmost, Off, ahk_class %class%
	ExitApp