;-------------------------------------------------------------
; 関数
;-------------------------------------------------------------

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

;選択したテキスト内容でぐぐる
;ローカルディレクトリの時はエクスプローラ起動
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
