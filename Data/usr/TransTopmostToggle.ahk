;===============================================================================
; TransTopmostToggle.ahk - �A�N�e�B�u�ȃE�B���h�E�̔��������ƍőO�ʉ���Toggle����B(2005/12/14)
;===============================================================================

#Persistent

class =
flag = 0

SetTimer, Reflesh, 1000	;1�b���ƂɑΏۃE�B���h�E�̗L�����m�F���A�����Ȃ��Ă���΂��̃X�N���v�g��������Ԃɖ߂��B
return

OnExit, ExitSub
return

;"Win+Alt+T"�Ŗ{�̎��s
#!t::
	If class =
	{
		WinGetClass, class, A
		WinGetTitle, title, A
		MsgBox, 4, TransTopmostToggle, "%title%" ��TransTopmostToggle�̑Ώۂɂ��܂����H
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
		WinSet, Transparent, 200, ahk_class %class%	;�E�B���h�E�̕s�����x(200/255)
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