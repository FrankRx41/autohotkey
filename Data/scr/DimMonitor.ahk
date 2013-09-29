; DimMonitor.ahk
; 参考スクリプト：http://www.donationcoder.com/Software/Skrommel/index.html#DimScreen
; 単体で起動可能。#Includeする場合はAuto-Executeセクションに記述。
; 詳細は以下のページで。
; http://retla.g.hatena.ne.jp/retla/20100810/dimmonitor

#NoEnv

Dim = 0
Day = 6							; 自動調整で明るくする時間
Night = 18						; 自動調整で暗くする時間
Span = % 1000 * 60 * 60 * 2		; 手動調整後は2時間経過するまで自動調整しない
SetTimer, DimOnTop, 200			; 200msごとにアクティブウィンドウの変化を監視

;*** フィルター生成 ***
DimFilter:
	DimGui := NewGui()
	Gui, %DimGui%:+LastFound +ToolWindow -Disabled -SysMenu -Caption +E0x20 +AlwaysOnTop
	Gui, %DimGui%:Color, 000000
	Gui, %DimGui%:Show, X0 Y0 W%A_ScreenWidth% H%A_ScreenHeight%, DimMonitor
	WinGet, DimId, Id, DimMonitor ahk_class AutoHotkeyGUI
	WinSet, Transparent, % Dim * 255 / 100, ahk_id %DimId%
	If (A_ScriptName = "DimMonitor.ahk")
		Return					; 単独実行なら自動実行終了
	Else
		GoTo, DimEnd			; 組み込みならReturnしない

DimOnTop:						; 常にフィルターを最前面に配置
	IfWinNotActive, ahk_id %AWinId%
	{
		WinSet, AlwaysOnTop, On, ahk_id %DimId%
		WinGet, AWinId, Id, A
	}
	GoSub, DimTime
Return

;*** 時間帯によって明度を自動変更 ***
DimTime:
	If (A_TickCount < Manual)
		Return
	If (A_Hour <= Day || A_Hour >= Night)
		Dim = 25				; 夜は明度75%
	Else
		Dim = 0
	WinSet, Transparent, % Dim * 255 / 100, ahk_id %DimId%
Return

;*** ホットキー操作 ***
#Home::							; 明度100%（不透明度0%）
	Dim = 0
	GoTo, DimHotKey
#End::							; 明度0%（不透明度100%）
	Dim = 100
	GoTo, DimHotKey
#PgDn::							; 明度を下げる（不透明度を上げる）
	Dim += 5
	If Dim > 100
		Dim = 100
	GoTo, DimHotKey
#PgUp::							; 明度を上げる（不透明度を下げる）
	Dim -= 5
	If Dim < 0
		Dim = 0
	GoTo, DimHotKey
DimHotKey:
	WinSet, Transparent, % Dim * 255 / 100, ahk_id %DimId%
	AutoHideTooltip("明るさ："100 - Dim "%", 500)
	Manual := A_TickCount + Span
Return

; *** ツールチップ自動消去関数 ***
AutoHideTooltip(Txt, Time, X="", Y="")
{
	Tooltip, %Txt%, %X%, %Y%
	SetTimer, AutoHide, -%Time%
	Return
	AutoHide:
		Tooltip, 
	Return
}

;*** Gui番号の生成関数（旧「流行らせるページ」より拝借） ***
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

DimEnd:
