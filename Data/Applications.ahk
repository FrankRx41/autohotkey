;-------------------------------------------------------------
; アプリケーション固有設定
;-------------------------------------------------------------

;■ Windows上での操作
#h::Send, {Left}
#j::Send, {Down}
#k::Send, {Up}
#l::Send, {Right}

;■ タスクバーで音量変更
#IfWinActive,ahk_class Shell_TrayWnd
	~WheelUp::Send, {Volume_Up}
	~WheelDown::Send, {Volume_Down}
	~MButton::Send, {Volume_Mute}
	Up::Send, {Volume_Up}
	Down::Send, {Volume_Down}
	Right::Send, {Volume_Mute}
	Left::Send, {Volume_Mute}
	k::Send, {Volume_Up}
	j::Send, {Volume_Down}
	l::Send, {Volume_Mute}
	h::Send, {Volume_Mute}
Return

;■ Windowsフォトビューア
#IfWinActive ahk_class Photo_Lightweight_Viewer
	Esc::send,!{F4}
#IfWinActive

;■ エクスプローラ
#IfWinActive ahk_class CabinetWClass
	Esc::send,!{F4}
#IfWinActive


;■ AFXW上のアクション
#IfWinActive ahk_class TLogForm
	h::Send, {Left}
	j::Send, {Down}
	k::Send, {Up}
	l::Send, {Right}
#IfWinActive

;■ Everythingでファイルパスをコピー(Shift+C)
#IfWinActive,ahk_class EVERYTHING
	+C::
		ControlGetText, text,msctls_statusbar321, ahk_class EVERYTHING
		Clipboard=%text%
Return

;■ メモ帳
#IfWinActive ahk_class Notepad
	^r::^h
	^w::Send,!ow
	Esc::Send !{F4}
#IfWinActive

;■ ペイント
#IfWinActive ahk_class MSPaintApp
	Esc::Send !{F4}
#IfWinActive

;■ コマンドプロンプト
#IfWinActive ahk_class ConsoleWindowClass
	^v::
		Keywait, ctrl
		Send, !{Space}ep
		return
#IfWinActive

;■ Chrome
#IfWinActive ahk_class Chrome_WidgetWin_1
	F1::^w                          ;タブを閉じる
	F2::^t                          ;新規タブ
	F3::^+n                         ;シークレットモード
	F4::^+o                         ;ブックマーク
	F6::^+t                         ;最近閉じたタブ
	vkF2sc070::^Tab                 ;タブ移動[アプリケーションキー]
	!s::
	{
		Send, ^t
		Send, ^k
		Send, {BS}
		Send, https://student.fun.ac.jp/up/faces/login/Com00501A.jsp
		Send, {Enter}
		Return
	}
	!m::
	{
		Send, ^t
		Send, ^k
		Send, {BS}
		Send, http://vle.c.fun.ac.jp/moodle/login/index.php
		Send, {Enter}
		Return
	}
#IfWinActive

;■ 練馬
#IfWinActive ahk_class TFormMain
	Esc::send,!{F4}
#IfWinActive

;■ ファイル名階層化くん
#IfWinActive ahk_class WindowsForms10.Window.8.app.0.378734a
	Esc::Send, !{F4}
	return
#IfWinActive

;■ SumatraPDF
#IfWinActive ahk_class SUMATRA_PDF_FRAME
	Esc::Send, !{F4}
	;j::Send, {Right}
	;k::Send, {Left}
	h::Send, {Left}
	j::Send, {Down}
	k::Send, {Up}
	l::Send, {Right}
#IfWinActive

;■ PPe
#IfWinActive ahk_class PPeditW
	Esc::Send, !{F4}
#IfWinActive

;■ DF
#IfWinActive DF
	Esc::Send, !{F4}
#IfWinActive

;■ FileSum
#IfWinActive FileSum
	Esc::Send, !{F4}
	h::Send, {Left}
	j::Send, {Down}
	k::Send, {Up}
	l::Send, {Right}
#IfWinActive

;■ あふｗの小窓での操作
#IfWinActive ahk_class CLTCMainWindow
	h::Send, {Left}
	j::Send, {Down}
	k::Send, {Up}
	l::Send, {Right}
#IfWinActive

;■ あふｗの小窓での操作2
#IfWinActive ahk_class TFinfoForm
	^h::Send, {Left}
	^j::Send, {Down}
	^k::Send, {Up}
	^l::Send, {Right}
#IfWinActive

;■ あふｗの小窓での操作3
#IfWinActive ahk_class TFinf2Form
	^h::Send, {Left}
	^j::Send, {Down}
	^k::Send, {Up}
	^l::Send, {Right}
#IfWinActive

;■ あふｗの小窓での操作4
#IfWinActive ahk_class TOverForm
	^h::Send, {Left}
	^j::Send, {Down}
	^k::Send, {Up}
	^l::Send, {Right}
#IfWinActive

;■ あふｗでの拡張改名
#IfWinActive ahk_class TExRenForm
	^h::Send, {Left}
	^j::Send, {Down}
	^k::Send, {Up}
	^l::Send, {Right}
#IfWinActive

;■ eClipでの矢印操作
#IfWinActive ahk_class eClipMainClass
	^h::Send, {Left}
	^j::Send, {Down}
	^k::Send, {Up}
	^l::Send, {Right}
#IfWinActive

;■ clnchでの矢印操作
#IfWinActive ahk_class ClnchWindowClass
	^h::Send, {Left}
	^j::Send, {Down}
	^k::Send, {Up}
	^l::Send, {Right}
#IfWinActive

;■ ファイル名を指定して実行
#IfWinActive ahk_class #32770
; 頭3文字またはフルネーム
; ***以下オールユーザ設定***
	::c::C:\
	::d::%USERPROFILE%\Desktop\
	::des::%USERPROFILE%\Desktop\
	::desktop::%USERPROFILE%\Desktop\
	::programfiles::%PROGRAMFILES%\
	::roaming::%USERPROFILE%\AppData\Roaming
	::computer::explorer.exe ,{20D04FE0-3AEA-1069-A2D8-08002B30309D}
	::controlpanel::control
	::taskmanager::taskmgr
	::system::control.exe /name Microsoft.System
	::n::notepad
	::pa::mspaint
	::reg::regedit
	::gomi::shell:RecycleBinFolder
	::tmp::%USERPROFILE%\Desktop\tmp\
	::bin::
	if(COMPUTERNAME=="BABAROTT-PC")
		Run, D:\bin\
	else
		Run, C:\bin\
	return
#IfWinActive
