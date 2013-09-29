#NoTrayIcon

#Esc::
	STGui := NewGui()
	Gui, %STGui%:Add, Edit, vSTCnt w30 Number, 
	Gui, %STGui%:Add, Text, ys+4, 分後に実行
	Gui, %STGui%:Add, Radio, Checked1 vSTSel xm, シャットダウン
	Gui, %STGui%:Add, Radio, Checked0, スリープ
	Gui, %STGui%:Add, Radio, Checked0 gFileSelect Section, ファイル
	Gui, %STGui%:Add, Edit, vSTFile ys-3, 
	Gui, %STGui%:Add, Button, xm w100 Section gSTExec Default, OK
	Gui, %STGui%:Add, Button, w100 ys gCancel, Cancel
	Gui, %STGui%:Show
Return
FileSelect:
	FileSelectFile, TmrFile
	GuiControl, , STFile, %TmrFile%
Return
STExec:
	Gui, %STGui%:Submit
	STCnt := STCnt * 1000 * 60
	If (STCnt > 0)
	{
		Tick = % A_TickCount + STCnt
		If STSel = 1
			SetTimer, Shutdown, 1000
		Else If STSel = 2
			SetTimer, Sleep, 1000
		Else If STSel = 3
			SetTimer, STRun, 1000
	}
	Gui, Destroy
Return
Shutdown:
	If (A_TickCount > Tick)
	{
		SetTimer, Shutdown, OFF
		MsgBox, 4097, Shutdown, シャットダウンを開始します, 10
		IfMsgBox, Cancel
			Return
		Shutdown, 1
	}
Return
Sleep:
	If (A_TickCount > Tick)
	{
		SetTimer, Sleep, OFF
		DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)
	}
Return
STRun:
	If (A_TickCount > Tick)
	{
		SetTimer, STRun, OFF
		If (FileExist(STFile))
			Run, %STFile%
		Else
			Msgbox, [File Not Exist] `n %STFile%
	}
Return

;以下の関数は「流行らせるページ」から拝借
NewGui(){
    Process,Exist
    mypid:=ErrorLevel
    DetectHiddenWindows,On
    WinGet,h,list,ahk_pid %mypid% ahk_class AutoHotkeyGUI
    DetectHiddenWindows,Off
    Loop,99{
        found=0
        Gui,%A_Index%:+LastFound
        WinGet,hwnd,id
        Loop,%h%{
            if(h%A_Index%=hwnd){
                found=1
                break
            }
        }
        if(found=0){
            return A_Index
        }
    }
    return 0
}