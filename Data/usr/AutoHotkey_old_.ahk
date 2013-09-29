;/*******************************************************************************************************
; メニュー
; Win+G == GoogleChorme起動
; Win+H == 規定のブラウザでGoogle検索
; Win+F == Everything起動
; Win+A == あふｗ起動
; Win+N == Evernote起動
; Win+E == マイコンピュータ起動
; --------------------------------------
; Win+M == アクティブウィンドウ最小化
; Win+Space == アクティブウィンドウを閉じる
; Win+変換 == アクティブウィンドウ最大化トグル
; Alt+Space == アクティブウィンドウの真下をチラ見る
; --------------------------------------
; Win+Z == Alt+Tabの挙動をする
; Win+X == 〃 （※）
; --------------------------------------
; Chrome*変換 == 戻る
; Everything*(Shift+C) == カーソル下のフルパスをコピー
;
;*******************************************************************************************************/
;┏━━━━━━━━━━━━━━━━━━┓
;┃                                    ┃
;┃             AutoHotkey             ┃
;┃                                    ┃
;┗━━━━━━━━━━━━━━━━━━┛
;
;■ 起動するソフトを相対パスで指定する
SetWorkingDir,%A_ScriptDir%

;■ Shiftなしで_を打鍵
;SC073::_

;■ Winキーを無効化
;LWin Up::Return ;WINキーが反応しなくなる

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;    GUI  Button   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Control & Shift::Run, ..\CLaunch\CLaunch.exe
~LButton & WheelUp::
/*
Gui,Add,Button,gB1  x10  y10  w120 h25,CCleaner
Gui,Add,Button,gB2  x10  y35  w120 h25,FlacDrop
Gui,Add,Button,gB3  x10  y60  w120 h25,freac
Gui,Add,Button,gB4  x10  y85  w120 h25,ID_Manager
Gui,Add,Button,gB5  x10  y110 w120 h25,JTrim
Gui,Add,Button,gB6  x10  y135 w120 h25,LyricsMaster
Gui,Add,Button,gB7  x10  y160 w120 h25,MaltiWallpaper
Gui,Add,Button,gB8  x10  y185 w120 h25,PDForsell
Gui,Add,Button,gB9  x10  y210 w120 h25,ProcessExplorer
Gui,Add,Button,gB10 x10  y235 w120 h25,RevoUninstaller
Gui,Add,Button,gB11 x130 y10  w120 h25,SimiPix
Gui,Add,Button,gB12 x130 y35  w120 h25,speecy
Gui,Add,Button,gB13 x130 y60  w120 h25,SystemExplorer
Gui,Add,Button,gB14 x130 y85  w120 h25,toumeiPNG
Gui,Add,Button,gB15 x130 y110 w120 h25,ToYcon
Gui,Add,Button,gB16 x130 y135 w120 h25,UniversalExtractor
Gui,Add,Button,gB17 x130 y160 w120 h25,DAEMON_Tools
Gui,Add,Button,gB18 x130 y185 w120 h25,DVD43
Gui,Add,Button,gB19 x130 y210 w120 h25,EasyFileLocker
Gui,Add,Button,gB20 x130 y235 w120 h25,DAEMON_Tools
Gui,Add,Button,gB21 x250 y10  w120 h25,ExactAudioCopy
Gui,Add,Button,gB22 x250 y35  w120 h25,HandBrake
Gui,Add,Button,gB23 x250 y60  w120 h25,いじくるつーる
Gui,Add,Button,gB24 x250 y85  w120 h25,ImgBurn
Gui,Add,Button,gB25 x250 y110 w120 h25,iTunes
Gui,Add,Button,gB26 x250 y135 w120 h25,Mp3tag
Gui,Add,Button,gB27 x250 y160 w120 h25,VLC
Gui,Show 
return
B1:
	Run,C:\bin\CCleaner\CCleaner.exe
	Gui,Destroy
	return
B2:
	Run,C:\bin\flacdrop\FlacDrop.exe
	Gui,Destroy
	return
B3:
	Run,C:\bin\freac\freac.exe
	Gui,Destroy
	return
B4:
	Run,C:\bin\ID_Manager\id_manager\IDM.exe
	Gui,Destroy
	return
B5:
	Run,C:\bin\JTrim\JTrim.exe
	Gui,Destroy
	return
B6:
	Run,C:\bin\LyricsMaster\LyricsMaster.exe
	Gui,Destroy
	return
B7:
	Run,C:\bin\MultiWallpaper\MultiWallpaper.exe
	Gui,Destroy
	return
B8:
	Run,C:\bin\PDForsell\PDForsell2.exe
	Gui,Destroy
	return
B9:
	Run,C:\bin\ProcessExplorer\procexp.exe
	Gui,Destroy
	return
B10:
	Run,C:\bin\RevoUninstaller\Revouninstaller.exe
	Gui,Destroy
	return
B11:
	Run,C:\bin\SimiPix\SimiPix.exe
	Gui,Destroy
	return
B12:
	Run,C:\bin\speecy\Speccy.exe
	Gui,Destroy
	return
B13:
	Run,C:\bin\SystemExplorer\SystemExplorer.exe
	Gui,Destroy
	return
B14:
	Run,C:\bin\toumei_32\手軽に透明png.exe
	Gui,Destroy
	return
B15:
	Run,C:\bin\ToYcon\ToYcon.exe
	Gui,Destroy
	return
B16:
	Run,C:\bin\UniversalExtractor\UniExtract.exe
	Gui,Destroy
	return
B17:
	Run,C:\Program Files\DAEMON Tools Lite\DTLite.exe
	Gui,Destroy
	return
B18:
	Run,C:\Program Files\dvd43\DVD43_Tray.exe
	Gui,Destroy
	return
B19:
	Run,C:\Program Files\Easy File Locker\FileLocker.exe
	Gui,Destroy
	return
B20:
	Run,C:\Program Files\Evernote\Evernote\Evernote.exe
	Gui,Destroy
	return
B21:
	Run,C:\Program Files\Exact Audio Copy\EAC.exe
	Gui,Destroy
	return
B22:
	Run,C:\Program Files\Handbrake\Handbrake.exe
	Gui,Destroy
	return
B23:
	Run,C:\Program Files\IJIKURU\RNSF7.EXE
	Gui,Destroy
	return
B24:
	Run,C:\Program Files\ImgBurn\ImgBurn.exe
	Gui,Destroy
	return
B25:
	Run,C:\Program Files\
	Gui,Destroy
	return
B26:
	Run,C:\Program Files\Mp3tag\Mp3tag.exe
	Gui,Destroy
	return
B27:
	Run,C:\Program Files\VideoLAN\VLC\vlc.exe
	Gui,Destroy
	return
*/
;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
;■マウスでのジェスチャー
~LButton & WheelDown::Run, https://www.google.co.jp/
;~LButton & WheelUp::Run, ..\CLaunch\CLaunch.exe

;■ Win+A であふｗ起動
#A::Run, ..\AFx\AFXW.EXE -s
;	#A::
;	Process,Exist,AFXW.EXE
;	if ErrorLevel<>0
;	  WinActivate,ahk_pid %ErrorLevel%
;	else
;	  Run, ..\AFx\AFXW.EXE
;	return

;■ Win+FでEverythingのファイル検索
#F::Run, ..\AFx\tools\Everything\Everything.exe

;■ Win+Hで規定のブラウザでGoogle起動
#H::Run, https://www.google.co.jp/

;■ Win+TでToodledoを規定のブラウザで起動
#T::Run, https://www.toodledo.com/signin.php

;■ Win+GでChrome起動
#G::
Process,Exist,chrome.exe
if ErrorLevel<>0
  WinActivate,ahk_pid %ErrorLevel%
else
  Run, %localappdata%\Google\Chrome\Application\chrome.exe
return

;■ Win+NでEvernote起動
#N::
Process,Exist,evernote.exe
if ErrorLevel<>0
  WinActivate,ahk_pid %ErrorLevel%
else
  Run, C:\Program Files\Evernote\Evernote\Evernote.exe
return

;■ Win+Eでマイコンピュータを開く
#E::Run, .\MyCom.{20D04FE0-3AEA-1069-A2D8-08002B30309D}

;■ Win+Spaceでアクティブウィンドウを閉じる
LWin & Space::WinClose,A

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
; LWin & X::AltTab

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
 ^r::^h                          ; メモ帳でCtrl+HをCtrl+Rに置き換え
 ^w::Send,!ow                    ; Alt+Oで 書式メニューを表示し、 Wキーで 右端で折り返しを選択
#IfWinActive

;■ 入力補完
::kita-::
Clipboard=ｷﾀ━━━━━━(ﾟ∀ﾟ)━━━━━━ !!!!!
Send,^v
Return
::gm::b4b4r07@gmail.com
::vj::vj2sw3v1
::84::84841207
::48::48694062
::ba::babarot
::BA::BABAROTT
::b1::BABAROTT