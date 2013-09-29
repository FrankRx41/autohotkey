;Main AutoHotkey File
;LastUpdate 2009/11/16
;修飾キー: ^ Ctrl , ! Alt , + Shift , # Win
;[無変換]    vk1Dsc07B
;[変換]      vk1Csc079
;[半/全]     sc029
;[カナ/かな] vkF2sc070
;改行は`r , 変数利用時は%hoge%
;左手前はXButton1、奥はXButton2
;テスト用
;F5::Reload
;┏━━━━━━━━━━━━━━━━━━┓
;┃                                    ┃
;┃             AutoHotkey             ┃
;┃                                    ┃
;┗━━━━━━━━━━━━━━━━━━┛
;
;■ 起動するファイルを相対パスで指定する
SetWorkingDir,%A_ScriptDir%

;■ オートエグゼキュートセクション
Run, ..\eClip\eClip.exe
Run, ..\AFx\AFXW.EXE -s -l"C:\" -r"..\..\"
Run, ..\clnch\clnch.exe

;■ インクルードセクション
#Include %A_ScriptDir%
#Include Data\scr\MoGe.ahk
#Include Data\scr\IME.ahk
#Include Data\scr\WheelRedirect.ahk
#Include Data\scr\RandomPass.ahk
#Include Data\scr\TimeSleeper.ahk
#Include Data\scr\TrayStrage.ahk
#Include Data\scr\WindowMoveInDisplay.ahk
#Include Data\scr\ChangeSearch.ahk
#Include Data\scr\AutoUSB.ahk
;#Include Data\scr\NoTaskbar.ahk

;-------------------------------------------
; 関数
;-------------------------------------------

;文字列貼り付け用関数
HotString(msg)
{
	bk=%ClipboardAll%
	Clipboard=%msg%
	Send,^v
	Clipboard=%bk%
}

;文字列挟み込み用関数
SandString(start,end)
{
	bk=%ClipboardAll%
	Clipboard=
	Send,^c
	if(Clipboard!="")
		Clipboard = %start%%clipboard%%end%
	else
		Clipboard = %start%%end%
	Send,^v
	Clipboard=%bk%
}

;クリップボードの中身で文字列挟み込み用関数
ClipSandString(start,end)
{
	bk=%ClipboardAll%
	Clipboard = %start%%clipboard%%end%
	Send,^v
	Clipboard=%bk%
}

;選択したテキスト内容でぐぐる・ローカルディレクトリの時はエクスプローラ起動
SearchSelectedText()
{
	bk=%ClipboardAll%
	Clipboard=
	Send,^c
    ClipWait, 1
    SplitPath, Clipboard, name, dir, ext, noext, drive
    IfInString,drive,ttp://
        IfInString,drive,h
            Run,%Clipboard%
        else
            Run,h%Clipboard%
    else If(drive!="")
        Run,%dir%
    else if(Clipboard!="")
        Run,http://www.google.com/search?q=%Clipboard%
    Clipboard=%bk%
}

;一行コピーもどき
LineCopy()
{
	Clipboard=
	Send,^c
	if(Clipboard="")
	{
		Send,{End}+{Home}
		Send,^c{Left}
	}
}

;Window移動用関数
MoveWindow(xStep,yStep)
{
	WinGetPos,X,Y,,,A
	X:=X+xStep
	Y:=Y+yStep
	WinMove A,,X,Y
}

; 指定番号のモニタサイズを取得する
GetMonitor(monitorNo, ByRef mX, ByRef mY, ByRef mW, ByRef mH)
{
	SysGet, m, MonitorWorkArea, %monitorNo%
	mX := mLeft
	mY := mTop
	mW := mRight - mLeft
	mH := mBottom - mTop
}

; アクティブウィンドウの左上座標が含まれるモニタを取得する
GetActiveMonitor(ByRef mX, ByRef mY, ByRef mW, ByRef mH)
{
	WinGet, activeWindowID, ID, A
	WinGetPos, x, y, w, h, ahk_id %activeWindowID%
	SysGet,monitorCount,MonitorCount
	Loop, %monitorCount%
	{
		SysGet, m, MonitorWorkArea, %a_index%
		if (mLeft <= x && x < mRight && mTop <= y && y < mBottom)
		{
			mX := mLeft
			mY := mTop
			mW := mRight - mLeft
			mH := mBottom - mTop
			return
		}
	}
}

;対象モニタにアクティブウィンドウを移動する(高さリサイズ)
SendToTargetMonitor(monitorNo)
{
	WinGetPos, x, y, w, h, A
	GetMonitor(monitorNo, mX, mY, mW, mH)
	Random, rand, 50, 200
	WinMove, A,, mX + rand, mY, w, mH
}

;アクティブなアプリケーションと同一種類のウィンドウを水平垂直に並べる(最大4枚まで)
TileMove()
{
	GetActiveMonitor(mX, mY, mW, mH)
	WinGet, activeWindowID, ID, A
	WinGetClass, activeWindowClass, ahk_id %activeWindowID%
	WinGet, id, list, ahk_class %activeWindowClass%
	Loop, %id%
	{
		w := mW / 2
		h := (id > 2) ? mH / 2 : mH
		x := (Mod(a_index, 2) == 1) ? mX : mX + w
		y := (a_index <= 2) ? mY : mY + h
		
		StringTrimRight, this_id, id%a_index%, 0
		WinActivate, ahk_id %this_id%
		WinWaitActive, ahk_id %this_id%
		WinMove, ahk_id %this_id%,,x, y, w, h
	}
}

;全てのアプリケーションを元に戻す
RestoreAll()
{
	WinGet, id, list
	Loop, %id%
	{
		StringTrimRight, this_id, id%a_index%, 0
		WinRestore, ahk_id %this_id%
	}
}

;-------------------------------------------
; マウス
;-------------------------------------------

;■ マウスで擬似CraftLaunch
~LButton & WheelUp::Run, ..\clnch\clnch.exe
~LButton & WheelDown::
	Process,Exist,chrome.exe
	if ErrorLevel<>0
		WinActivate,ahk_pid %ErrorLevel%
	else
		Run, %LocalAppData%\Google\Chrome\Application\chrome.exe,,Max
return

;■ 簡易マウスアプリスイッチ
~XButton1 & WheelUp::AltTab
~XButton1 & WheelDown::ShiftAltTab

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
	return
; 閉じる
	MoGe_Explorer_DR:
	Send, !{F4}
	return
; 上のフォルダへ
	MoGe_Explorer_U:
	Send, {Backspace}
	return
#IfWinActive

;■ ホイールボタンをクリックで現在時刻表示
;MButton::Msgbox,%A_Year%/%A_Mon%/%A_MDay%`n%A_Hour%時%A_Min%分%A_Sec%秒

;■ ホイールボタンをクリックでアクティブウィンドウを最小化
MButton::WinMinimize,A

;■ XButton2であふｗ起動
XButton2::Run, ..\AFx\AFXW.EXE -s

;-------------------------------------------
; ホットキー関連
;-------------------------------------------

;■ Cntl+ShiftでCLaunch起動
;Control & Shift::Run, ..\CLaunch\CLaunch.exe
;Shift & Control::Run, ..\CLaunch\CLaunch.exe

;■ Win+Aであふｗ起動
#A::Run, ..\AFx\AFXW.EXE -s

;■ Win+FでEverythingのファイル検索
#F::Run, ..\AFx\tools\Everything\Everything.exe

;■ Win+Qでクイックターミネーター
#Q::
	Run, ..\qt0\qt0.exe
	Sleep, 1000
	FileDelete, *.ini
Return

;■ Win+Gで規定のブラウザでGoogle起動
#G::Run,  https://www.google.co.jp/

;■ Win+Hで規定のブラウザでhttp検索
;#H::Run, https://www.google.co.jp/

;■ Win+PでPaper Plane xUI起動
#P::
Process,Exist,ppcw.exe
if ErrorLevel<>0
	WinActivate,ahk_pid %ErrorLevel%
else
	Run, ..\PPx\PPCW.EXE
Return

;■ Win+CでChrome起動
#C::
Process,Exist,chrome.exe
if ErrorLevel<>0
	WinActivate,ahk_pid %ErrorLevel%
else
	Run, %LocalAppData%\Google\Chrome\Application\chrome.exe,,Max
Return

;■ Win+OでOpera起動
#O::
Process,Exist,opera.exe
if ErrorLevel<>0
	WinActivate,ahk_pid %ErrorLevel%
else
	Run, ..\Opera\opera.exe
Return

;■ Win+Eでエクスプローラ（デスクトップ）
#E::Run, %USERPROFILE%\Desktop\

;■ Win+NでEvernote起動
#N::Run, C:\Program Files\Evernote\Evernote\Evernote.exe,,Max

;■ Win+Sでサクラエディタを開く
#S::Run, ..\AFx\tools\sakura\sakura.exe

;■ Win+ALtでcltc起動
;#Alt::Run, ..\cltc\cltc.exe
;!LWin::Run, ..\cltc\cltc.exe
;!RWin::Run, ..\cltc\cltc.exe

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

;■ CapsLockでIMEスイッチ
sc029::
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
;sc029 vkF3sc029 vkF4sc029 => [半/全]
;※vkf0sc03A / sc03a
;※どっちもCapsLock

;-------------------------------------------
; アクティブウィンドウ関連
;-------------------------------------------

;■ アクティブモニタの半分サイズにして左右に寄せる
;#Left::

;■ 最小化と復元
;	GetActiveMonitor(x, y, w, h)
;	WinGet, id, ID, A
;	WinMove, ahk_id %id%,,x, y, w / 2 , h
;	return
;#Right::
;	GetActiveMonitor(x, y, w, h)
;	WinGet, id, ID, A
;	WinMove, ahk_id %id%,,x + w / 2, y, w / 2 , h
;	return
;#Up::RestoreAll()
;#Down::#d

;■ アクティブウィンドウを常に最手前
#W::WinSet, Topmost, Toggle,A

;■ アクティブなアプリケーションと同一種類のウィンドウを水平垂直に並べる(最大4枚まで)
#T::TileMove()

;■ Win+Spaceでアクティブウィンドウを閉じる
LWin & Space::WinClose,A
RWin & Space::WinClose,A

;■ Alt+Spaceでアクティブウィンドウを閉じる
Alt & Space::WinClose,A

;■ Win+Mでアクティブウィンドウを最小化
#M::WinMinimize,A

;■ Win+変換で最大化トグル
LWin & vk1Csc079::
	WinGet, tmp, MinMax,A
	If tmp = 1
		WinRestore,A
	else
		WinMaximize,A
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

;■ ダブル右クリックでアクティブウィンドウをクローズ
~RButton::
If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
{
	Sleep, 100
	Send, {Esc}
	WinClose,A
}
Return

;■ 左Windowsキー＋XをAlt+Tabと同じ動作に
LWin & Z::ShiftAltTab

;■ 左Windowsキー＋ZをShift＋Alt+Tabと同じ動作に
;LWin & X::AltTab

;■ Ctrl+Gで反転させたワードをGoogleで検索
^G::
bk=%ClipboardAll%
Clipboard=
Send, ^c
ClipWait
Run, http://www.google.com/search?q=%Clipboard%
Clipboard=%bk%
Return

;-------------------------------------------
; アプリケーション固有設定
;-------------------------------------------

;■ タスクバーで音量変更
#IfWinActive,ahk_class Shell_TrayWnd
	~WheelUp::Send, {Volume_Up}
	~WheelDown::Send, {Volume_Down}
	~MButton::Send, {Volume_Mute}
	Up::Send, {Volume_Up}
	Down::Send, {Volume_Down}
	Right::Send, {Volume_Mute}
	Left::Send, {Volume_Mute}
Return

;■ Windowsフォトビューア
#IfWinActive ahk_class Photo_Lightweight_Viewer 
	Esc::send,!{F4}
#IfWinActive

;■ エクスプローラ
#IfWinActive ahk_class CabinetWClass 
	Esc::send,!{F4}
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
;~vk1Dsc07B=無変換、vk1Csc079=変換、vkF2sc070=カナかな
	F1::^w                          ;タブを閉じる
	;F2::^t                          ;新規タブ
	;F3::^+n                         ;シークレットモード
	F4::^+o                         ;ブックマーク
	F6::^+t                         ;最近閉じたタブ
	MButton::^w                     ;タブを閉じる
	vk1Dsc07B::^w                   ;タブを閉じる[無変換]
	vk1Csc079::Send,{Backspace}     ;履歴を１つ戻る[変換]
	vkF2sc070::^Tab                 ;タブ移動[アプリケーションキー]
	~XButton1::MsgBox, danger
	XButton2::return
	
	!a::
	{
		Send, ^t
		Send, ^k
		Send, {BS}
		Send, http://auth.fun.ac.jp/
		Send, {Enter}
		Return
	}	
	!s::
	{
		Send, ^t
		Send, ^k
		Send, {BS}
		Send, https://student.fun.ac.jp/up/faces/login/Com00501A.jsp
		Send, {Enter}
		Return
	}
	!h::
	{
		Send, ^t
		Send, ^k
		Send, {BS}
		Send, http://hope.c.fun.ac.jp/
		Send, {Enter}
		Return
	}
	!w::
	{
		Send, ^t
		Send, ^k
		Send, {BS}
		Send, https://webdav.fun.ac.jp/proself/login/login.go
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
	!v::
	{
		Send, ^t
		Send, ^k
		Send, {BS}
		Send, http://www.wordengine.jp/
		Send, {Enter}
		Return
	}
	F2::
	{
		Send, {AppsKey}
		Send, v
		Send, {Enter}
		Send, {PGDN 5}
		Send, {Down 16}
		Return
	}
	F3::
	{
		Send, {AppsKey}
		Send, t
		Send, {Enter}
		Return
	}
#IfWinActive

;■ Opera
#IfWinActive ahk_class OperaWindowClass
	F1::^w             ;タブ閉じ
	F2::^+Tab          ;左のタブ
	F3::^Tab           ;右のタブ
	F4::^+b            ;ブックマーク
	!z::^+b            ;ブックマーク
	^Numpad0::^t       ;SpeedDial
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
	h::Send, {Right}
	j::Send, {Down}
	k::Send, {Up}
	l::Send, {Left}
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
#IfWinActive

;■ ファイル名を指定して実行
#IfWinActive ahk_class #32770
; 頭3文字またはフルネーム
; ***以下オールユーザ設定***
	::c::C:\
	::d::%USERPROFILE%\Desktop\
	::des::%USERPROFILE%\Desktop\
	::desktop::%USERPROFILE%\Desktop\
	::pro::%PROGRAMFILES%\
	::programfiles::%PROGRAMFILES%\
	::roa::%USERPROFILE%\AppData\Roaming
	::roaming::%USERPROFILE%\AppData\Roaming
	::com::explorer.exe ,{20D04FE0-3AEA-1069-A2D8-08002B30309D}
	::computer::explorer.exe ,{20D04FE0-3AEA-1069-A2D8-08002B30309D}
	::con::control
	::controlpanel::control
	::tas::taskmgr
	::taskmanager::taskmgr
	::sys::control.exe /name Microsoft.System
	::system::control.exe /name Microsoft.System
	::n::notepad
	::p::mspaint
	::not::notepad
	::pai::mspaint
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

;-------------------------------------------
; その他
;-------------------------------------------

;■ 通知領域に表示しない
;#NoTrayIcon

;■ リマッピング
;AppsKey::LWin

;■ キーを無効化
LWin Up::Return
RWin Up::Return
;※[半/全]キー
;sc029::return
;※[カナ/かな]キー
vkF2sc070::return

;■ 入力補完系
::gm::b4b4r07@gmail.com
::b4::b4b4r07@gmail.com
::b1::b1012231@fun.ac.jp
::c1::c10h14o@docomo.ne.jp
::vj::vj2sw3v1
::486::48694062
::848::84841207

;■ Shift+DELでカーソル行を削除
+DEL::Send,{Home}+{End}{Delete}

;■ Ctrl+Lでその行を選択する
^L::Send,{End}+{Home}

;■ 無変換+Cでカーソル行をクリップボードへ転送
~vk1Dsc07B & C::Send,{Home}+{End}^c

;■ 無変換+Vでカーソル行に貼り付け
~vk1Dsc07B & V::Send,{Home}+{End}^v

;■ 無変換+←でカーソル行先頭
~vk1Dsc07B & Left::Send,{Home}

;■ 無変換+→でカーソル行末尾
~vk1Dsc07B & Right::Send,{End}

;■ Ctrl+←でカーソル行先頭
;Ctrl & Left::Send,{Home}

;■ Ctrl+→でカーソル行末尾
;Ctrl & Right::Send,{End}

;■ Shiftなしで_を打鍵
;SC073::_

;■ テスト（成功）
#K::
if(COMPUTERNAME=="BABAROTT-PC")
	Run, notepad.exe
else
	Run, mspaint.exe
Return

;■ クリップボード監視・テキスト保存
OnClipboardChange:
	if A_EventInfo = 1
		FileAppend, %clipboard%`n`n ********** `n`n, .\Data\clipboard.txt
return

;; test
^[::Send, {Esc}
#V::Run, C:\bin\vim\gvim.exe