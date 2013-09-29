;┏━━━━━━━━━━━━━━━━━━┓
;┃                                    ┃
;┃             AutoHotkey             ┃
;┃                                    ┃
;┗━━━━━━━━━━━━━━━━━━┛
;
;■ 通知領域に表示しない
;#NoTrayIcon

;■ 起動するソフトを相対パスで指定する
SetWorkingDir,%A_ScriptDir%

;■auto_execute_section
Run, ..\CLaunch\CLaunch.exe
;Run, ..\TTBase\TTBase.exe
Run, ..\Paster\Paster.exe
Run, ..\..\DropboxPortableAHK.exe


;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

;■ AHK終了
#Q::
MsgBox , 1, Check, Do you do safety removing hardware?
if(ErrorLevel=0)
{
  Process,Close, Paster.exe
  Process,Close, Everything.exe
  Process,Close, CLaunch.exe
  Process,Close, DropboxPortableAHK.exe
  Process,Close, Dropbox.exe
  Run, ..\UnplugDrive\UnplugDrive.exe
  Process,Close, AutoHotkey.exe
  ExitApp
  return
}
return

;■ リマッピング
AppsKey::LWin

;■ Shiftなしで_を打鍵
;SC073::_

;■ Winキーを無効化
;LWin Up::Return ;WINキーが反応しなくなる

;■マウスでのジェスチャー
;~LButton & WheelUp::Run, ..\AFx\AFXW.EXE -s
~LButton & WheelUp::Run, ..\CLaunch\CLaunch.exe
~LButton & WheelDown::
	Process,Exist,chrome.exe
	if ErrorLevel<>0
	  WinActivate,ahk_pid %ErrorLevel%
	else
	  Run, ..\GoogleChrome\GoogleChromePortable.exe
	return

;■ Cntl+ShiftでCLaunch起動
Control & Shift::Run, ..\CLaunch\CLaunch.exe

;■ Win+A であふｗ起動
#A::Run, ..\AFx\AFXW.EXE -s

;■ Win+FでEverythingのファイル検索
#F::Run, ..\AFx\tools\Everything\Everything.exe

;■ WinGで規定のブラウザでGoogle起動
#G::Run, https://www.google.co.jp/

;■ Win+CでChrome起動
#C::
Process,Exist,chrome.exe
if ErrorLevel<>0
  WinActivate,ahk_pid %ErrorLevel%
else
  Run, ..\GoogleChrome\GoogleChromePortable.exe
return

;■Win+Eでマイコンピュータを開く
#E::Run, ..\AFx\etc\MyComputer.{20D04FE0-3AEA-1069-A2D8-08002B30309D}

;■ Win+NでEvernote起動
#N::Run, C:\Program Files\Evernote\Evernote\Evernote.exe

;■ Win+Sでサクラエディタを開く
#S::Run, ..\AFx\tools\sakura\sakura.exe

;■ Win+Spaceでアクティブウィンドウを閉じる
LWin & Space::WinClose,A

;■ Alt+Spaceでアクティブウィンドウを閉じる
Alt & Space::WinClose,A

;■ Win+Mでアクティブウィンドウを最小化
#M::WinMinimize,A

;■ Win+変換で最大化トグル
LWin & vk1Csc079::
    WinGet, tmp, MinMax, A
    If tmp = 1
        WinRestore, A
    Else
        WinMaximize, A
Return

;■ Esc長押しでウィンドウ閉じる
$Esc::
  KeyWait, Esc, T0.3
  if ErrorLevel
    send,!{F4}
  else
    send,{Esc}
  keywait, Esc
return

;■ 左Windowsキー＋ZをShift＋Alt+Tabと同じ動作に
;LWin & X::AltTab

;■ 左Windowsキー＋XをAlt+Tabと同じ動作に
LWin & Z::ShiftAltTab

;■ Chrome上にて変換キーで戻るキー
#IfWinActive - Google Chrome ahk_class Chrome_WidgetWin_0
 ;vk1Dsc07B=無変換、vk1Csc079=変換
 vk1Csc079::Send,{Backspace}
#IfWinActive

;■ Alt+Gで反転させたワードをGoogleで検索
!G::                                            ;Win+Gキーに割り当て
bk=%ClipboardAll%                               ;クリップボードの内容をバックアップ
Clipboard=                                      ;クリップボードをクリア
Send,^c                                         ;Ctrl+Cキーを送信
ClipWait                                        ;クリップボードにテキストが格納されるまで待機
Run,http://www.google.com/search?q=%Clipboard%  ;クリップボードの内容を検索するGoogleのURLを開く
Clipboard=%bk%                                  ;バックアップした内容を書き戻し
return

;■ Everythingでファイルパスをコピー(Shift+C)
#IfWinActive,ahk_class EVERYTHING
	+C::
		ControlGetText, text,msctls_statusbar321, ahk_class EVERYTHING
		Clipboard=%text%
return

;■ メモ帳でのコマンド
#IfWinActive ahk_class Notepad
 ^r::^h
 ^w::Send,!ow
#IfWinActive

;■ 入力補完
::gm::b4b4r07@gmail.com
::b4::b4b4r07@gmail.com
::vj::vj2sw3v1
::84::84841207

;■ クリップボード監視・保存
OnClipboardChange:
	if A_EventInfo = 1
		FileAppend, %clipboard%`n`n, .\clipboard.txt
return

