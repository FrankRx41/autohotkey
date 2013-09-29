; Main AutoHotkey File
; LastUpdate 2012/11/16
; 修飾キー: ^ Ctrl , ! Alt , + Shift , # Win
; [無変換]    vk1Dsc07B
; [変換]      vk1Csc079
; [半/全]     sc029
; [カナ/かな] vkF2sc070
; 改行は`r , 変数利用時は%hoge%
; 左手前はXButton1、奥はXButton2
; テスト用
; F5::Reload
;

;#HotkeyInterval 1000
;#MaxHotkeysPerInterval 100

;=============================================================
;    _         _        _   _       _   _
;   / \  _   _| |_ ___ | | | | ___ | |_| | _____ _   _
;  / _ \| | | | __/ _ \| |_| |/ _ \| __| |/ / _ \ | | |
; / ___ \ |_| | || (_) |  _  | (_) | |_|   <  __/ |_| |
;/_/   \_\__,_|\__\___/|_| |_|\___/ \__|_|\_\___|\__, |
;                                                |___/
;=============================================================

;■ 起動するファイルを相対パスで指定する
SetWorkingDir,%A_ScriptDir%

;■ オートエグゼキュートセクション
Run, ..\eClip\eClip.exe
Run, ..\AFXW\AFXW.EXE -s -l"C:\" -r"D:\"
Run, ..\clnch\clnch.exe
;Run, ..\CLaunch\CLaunch.exe

;■ インクルード
#Include %A_ScriptDir%
#Include Data\Functions.ahk
#Include Data\scr\MoGe.ahk
#Include Data\scr\IME.ahk
#Include Data\scr\WheelRedirect.ahk
#Include Data\scr\RandomPass.ahk
#Include Data\scr\TimeSleeper.ahk
#Include Data\scr\TrayStrage.ahk
#Include Data\scr\WindowMoveInDisplay.ahk
#Include Data\scr\ChangeSearch.ahk
#Include Data\scr\AutoUSB.ahk
#Include Data\scr\ReverseScrollingWindows.ahk

;-------------------------------------------------------------
; マウス設定
;-------------------------------------------------------------
;■ マウスで擬似CraftLaunch
;~LButton & WheelUp::Run, ..\CLaunch\CLaunch.exe
~LButton & WheelUp::AltTab
~LButton & WheelDown::
	Process, Exist, chrome.exe
	if ErrorLevel<>0
		WinActivate, ahk_pid %ErrorLevel%
	else
		Run, %LocalAppData%\Google\Chrome\Application\chrome.exe,,Max
return

;■ 簡易マウスジェスチャ
SetTitleMatchMode, RegEx
#IfWinActive, ahk_class CabinetWClass|ExplorerWClass
	$RButton::MoGe("Explorer")
#IfWinActive
; 進む
MoGe_Explorer_R:
Send, {Browser_Forward}
return
; 戻る
MoGe_Explorer_L:
Send, {Browser_Back}
return
; 閉じる
MoGe_Explorer_DR:
Send, !{F4}
return
; 上のフォルダへ
MoGe_Explorer_U:
Send, {Backspace}
return

;-------------------------------------------------------------
; キー設定
;-------------------------------------------------------------

;■ Win+Aであふｗ起動
#A::Run, ..\AFXW\AFXW.EXE -s

;■ Win+CでChrome起動
#C::
Process,Exist,chrome.exe
if ErrorLevel<>0
	WinActivate,ahk_pid %ErrorLevel%
else
	if(COMPUTERNAME=="BABAROTT-PC")
		Run, %LocalAppData%\Google\Chrome\Application\chrome.exe
	else
		Run, C:\Program Files\Google\Chrome\Application\chrome.exe
Return

;■ Win+Eでエクスプローラ（デスクトップ）
#E::Run, %USERPROFILE%\Desktop\

;■ Win+FでEverythingのファイル検索
#F::Run, ..\Everything\Everything.exe

;■ Win+Gで規定のブラウザでGoogle起動
#G::Run,  https://www.google.co.jp/

;■ Win+NでEvernote起動
#N::Run, C:\Program Files\Evernote\Evernote\Evernote.exe

;■ Win+VでgVimを開く
#V::
Process,Exist,gvim.exe
if ErrorLevel<>0
	WinActivate,ahk_pid %ErrorLevel%
else
	Run, ..\Vim\gvim.exe
Return

;■ Ctrl2回押しでeClip
~Control::
if A_PriorHotkey <> ~Control
{
	KeyWait, Control
	return
}
if A_TimeSincePriorHotkey > 250
{
	KeyWait, Control
	return
}
	Run, ..\eClip\eClip.exe
Return

;■ Shift2回押しでcltc
~Shift::
if A_PriorHotkey <> ~Shift
{
	KeyWait, Shift
	return
}
if A_TimeSincePriorHotkey > 250
{
	KeyWait, Shift
	return
}
	Run, ..\cltc\cltc.exe
Return

;■ Ctrl+SpaceでIMEスイッチャー
^Space::
getIMEMode := IME_Get()
if (%getIMEMode% = 0)
{
	IME_SET(1)
	return
}
else
{
	IME_SET(0)
	return
}

;■ Shift+DELでカーソル行を削除
+DEL::Send,{Home}+{End}{Delete}

;■ Ctrl+Lでその行を選択する
^L::Send,{End}+{Home}

;■ Control+[でEsc効果
^[::Send, {Esc}

;■キーを無効化 {{{
;Windowsキー
LWin Up::Return
RWin Up::Return
;[半/全]キー
sc029::return
;[カナ/かな]キー
vkF2sc070::return
;[無変換]キー
vk1Dsc07B::return
;[変換]キー
vk1Csc079::return
; }}}

;■ 入力補完系
::b4::b4b4r07@gmail.com

;-------------------------------------------------------------
; ウィンドウ操作関連
;-------------------------------------------------------------

;■ すべての最小化ウィンドウをリストア
#U::RestoreAll()

;■ アクティブウィンドウを常に最手前
#W::WinSet, Topmost, Toggle, A

;■ アクティブなアプリケーションと同一種類のウィンドウを水平垂直に並べる(最大4枚まで)
#T::TileMove()

;■ Win+Spaceでアクティブウィンドウを閉じる
LWin & Space::WinClose, A
RWin & Space::WinClose, A

;■ 左Windowsキー＋XをAlt+Tabと同じ動作に
LWin & Z::AltTab

;■ Alt+Spaceでアクティブウィンドウを閉じる
Alt & Space::WinClose, A
#Q::WinClose, A

;■ Win+Mでアクティブウィンドウを最小化
#M::WinMinimize, A

;■ Win+S で最大化トグル
#S::
WinGet, Now, MinMax ,A
If(Now)
	WinRestore, A
Else
	WinMaximize, A
Return

;■ Esc長押しでウィンドウ閉じる
$Esc::
	KeyWait, Esc, T0.3
		if ErrorLevel
			Send,!{F4}
		else
		Send,{Esc}
	Keywait, Esc
Return

;; ;■ ダブル右クリックでアクティブウィンドウをクローズ
;; ~RButton::
;; If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
;; {
;; 	Sleep, 100
;; 	Send, {Esc}
;; 	WinClose,A
;; }
;; Return

;-------------------------------------------------------------
; アプリケーション固有設定
;-------------------------------------------------------------
^h::
IfWinNotActive ahk_class TAfxWForm
IfWinNotActive ahk_class Chrome_WidgetWin_1
	;;^h::Send, {BS}
	Send, {BS}
Return

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

;■ Vim
#IfWinActive ahk_class Vim
	#V::Send, +{INS}
#IfWinActive

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
