/*
■■■■ 簡易マウスジェスチャ関数 "MoGe" ■■■■

本スクリプトはジェスチャ判定の関数のみで単体で起動しても
何も起きずに終了します。

以下のようなことは本スクリプトでは制御せずに、
呼び出し側で行って貰うという前提です。

・どのような条件でジェスチャを開始するか
・ジェスチャの結果として何を行うか

つまり組み込み前提でAutoHotkeyスクリプトが書ける人を
対象としていています。

==============================
  導入方法
==============================

以下の何れかの方法で、インクルードを行う。
  ・本スクリプトを丸々コピペする
  ・#Include文で本ファイルを指定する
  ・関数ライブラリスクリプトとして配置する

==============================
  動作原理と設定方法
==============================

マウスボタンをトリガにして本関数が呼ばれると、
ボタン押上までマウスの動きを解釈し L / R /U / D の4種の文字列を
連結した「ジェスチャ文字列」を生成する。

その後以下のような文字列を生成して、有効なサブルーチンラベルである場合は
それを呼び出す。

  {モジュール接頭辞} . {第1引数} . "_" . {ジェスチャ文字列}


例) 以下のようにスクリプトを書いた時

    SetTitleMatchMode, RegEx
    #IfWinActive, ahk_class ExplorerWClass|CabinetWClass
    $RButton::$MoGe("Explorer")

    MoGe_Explorer_R:
      Send, {Browser_Forward}
      return
    MoGe_Explorer_L:
      Send, {Browser_Back}
      return

エクスプローラ上で、右ボタン→で進む、右ボタン←で戻る、となる。


==============================
  カスタマイズ
==============================
サブルーチンラベルの "Moge_Init"をいじる事で「多少の」カスタマイズが出来ます。

  Moge_PenSize     : ペンの太さ
  Moge_PenColor    : ペン色。16進数で指定。色名はNG。
  Moge_FontHeight  : フォントの高さ(=サイズ)
  Moge_FontWeight  : フォントの太さ(0～1000)
  Moge_FontName    : フォント名。
  Moge_Sensitivity : 感度。この数値のピクセル分だけ移動したら方向計算を行う。
                     大きいと、認識が悪くなる。小さすぎても使えない。

==============================
  ライセンス
==============================
パブリックドメインで。

*/
SetTitleMatchMode, RegEx

; 変数の初期化
Moge_Init:
	Moge_PenSize     = 3          ; (Int) ペンの太さ
	Moge_PenColor    = 0x00FF00   ; (Int) ペン色(RRGGBB)
	;Moge_PenColor    = 0xFFFFFF   ; (Int) ペン色(RRGGBB)
	Moge_FontHeight  = 20         ; (Int) フォントの高さ
	Moge_FontWeight  = 600        ; (Int) フォントの太さ(0～1000)
	Moge_FontName    = Arial      ; (Str) フォント名
	Moge_Sensitivity = 30         ; (Int) 感度(ピクセル)
	return

MoGe(prefix, timeout=1000, modulePrefix="MoGe_") {
	global Moge_PenSize,Moge_PenColor,Moge_FontHeight,Moge_FontWeight,Moge_FontName,Moge_Sensitivity
	static hModule
	SetBatchLines, 0
	SetWinDelay,-1
	Gosub, Moge_Init
	CoordMode, Mouse, Relative
	CoordMode, Tooltip, Relative
	; ボタン名は自動生成
	button := RegExReplace(A_ThisHotkey, "^\W+|\s.+", "", "", -1)
	; ラジアン計算用などの変数を初期化
	lastDir = "", moved:=false
	
	if (!hModule)
		hModule:=DllCall("LoadLibrary", "Str","gdi32.dll")
	
	MouseGetPos,,, targetHwnd
	IfWinNotExist, ahk_id %targetHwnd% ; Last Found Window
		return
	
	; 対象をアクティブ化する
	WinActivate
	WinWaitActive
	MouseGetPos,ox,oy ; 相対座標になってから, o:original
	WinGetPos, tX, tY, tW, tH ; t:target
	
	; マウス移動によってツールチップやポップアップが出ないように抑制
	WinSet, Disable
	
	; 描画領域取得を取得(ウィンドウ全体)
	;  http://msdn.microsoft.com/ja-jp/library/cc410408.aspx
	hDC:=DllCall("GetWindowDC", "UInt", targetHwnd)
	
	; ペン生成 : http://msdn.microsoft.com/ja-jp/library/cc428348.aspx
	hPen:=DllCall("gdi32.dll\CreatePen"
		, "Int", 0                   ; ペンのスタイル (*1)
		, "Int", Moge_PenSize        ; ペンの幅
		, "Int", Moge_PenColor       ; ペンの色
		, "UInt")
	; 生成したペンを選択
	;  http://msdn.microsoft.com/ja-jp/library/cc410576.aspx
	hOldPen:=DllCall("gdi32.dll\SelectObject", "UInt",hDC, "UInt",hPen)
	
	; 論理フォント生成
	;  http://msdn.microsoft.com/ja-jp/library/cc428368.aspx
	hFont:=DllCall("gdi32.dll\CreateFontA"
		, "Int",  Moge_FontHeight    ; フォントの高さ
		, "Int",  0                  ; 平均文字幅
		, "Int",  0                  ; 文字送り方向の角度
		, "Int",  0                  ; ベースラインの角度
		, "Int",  Moge_FontWeight    ; フォントの太さ
		, "UInt", 0                  ; 斜体にするかどうか
		, "UInt", 0                  ; 下線を付けるかどうか
		, "UInt", 0                  ; 取り消し線を付けるかどうか
		, "UInt", 0                  ; 文字セットの識別子
		, "UInt", 0                  ; 出力精度
		, "UInt", 0                  ; クリッピング精度
		, "UInt", 0                  ; 出力品質
		, "UInt", 0                  ; ピッチとファミリ
		, "Str",  Moge_FontName      ; フォント名
		, "UInt")
	hOldFont:=DllCall("gdi32.dll\SelectObject", "UInt",hDC, "UInt",hFont)
	
	; ジェスチャ文字列の描画領域
	;  http://msdn.microsoft.com/en-us/library/dd162897(VS.85).aspx
	VarSetCapacity(RECT, 16, 0x00)
	; ウィンドウ全体を描画領域とする。(x1,y1)はVarSetCapacityで初期化済み
	NumPut(tW, RECT, 8, "Int"), NumPut(th, RECT, 12, "Int")
	
	; ペン移動
	;  http://msdn.microsoft.com/ja-jp/library/cc410478.aspx
	DllCall("gdi32.dll\MoveToEx", "UInt",hDC, "Int",oX, "Int",oY, "UInt",0)
	
	pX:=oX, pY:=oY
	while GetKeyState(button, "P") 
	{
		; タイムアウト判定
		if (A_TimeSinceThisHotkey > timeout && !moved)
			break
		
		MouseGetPos, x, y
		dx:=x-pX, dy:=y-pY, dist:=Sqrt(dx**2+dy**2)
		
		if (dist> 10) {
			; 指定のペンで描画 : http://msdn.microsoft.com/ja-jp/library/cc410428.aspx
			DllCall("gdi32.dll\LineTo", "UInt",hDC, "Int",x, "Int",y)
			drawn:=true ; 再描画の為
		}
		if (dist < Moge_Sensitivity)
			Continue
		
		moved:=true
		
		; 角度計算、わざわざ度に変えているのは特に意味はない
		degree := 90*ATan(dy/dx)/Asin(1)
		degree := (dy>=0) ? (dx>0 ? degree : dx==0 ? 90 : 180+degree) : dx<0 ? 180+degree : dx==0 ? 270 : 360+degree
		
		dir := (degree <30 || degree > 330) ? "R" : (degree > 150 && degree<210) ? "L"
		     : (degree > 60 && degree < 120) ? "D" : (degree > 240 && degree < 300) ? "U"
		     : "" ; 1～2時/4～5時/7～8時/10～11時の時は持ち越し
		
		if !dir
			Continue
		
		gesture .= (lastDir != dir) ? dir : "" ; 同一方向だったら追加しない
		lastDir := (dir) ? dir : lastDir
		
		pX:=x, pY:=y
		
		; 文字列描画 : 描画位置を変えたいならココ
		;  http://msdn.microsoft.com/ja-jp/library/cc428474.aspx
		DllCall("user32.dll\DrawTextA"
			, "UInt", hDC              ; デバイスコンテキストのハンドル
			, "Str",  gesture          ;  描画するテキスト
			, "Int",  StrLen(gesture)  ; テキストの長さ
			, "UInt", &RECT            ; テキストを描画する長方形領域
			, "UInt", 0x28             ; テキスト描画オプション (*2)
			, "Int")
	}
	
	; 元のペン、フォントに戻す
	DllCall("gdi32.dll\SelectObject", "UInt",hDC, "UInt",hOldPen)
	DllCall("gdi32.dll\SelectObject", "UInt",hDC, "UInt",hOldFont)
	; この関数で生成したものは破棄
	;  http://msdn.microsoft.com/ja-jp/library/cc428362.aspx
	DllCall("gdi32.dll\DeleteObject", "UInt",hPen)
	DllCall("gdi32.dll\DeleteObject", "UInt",hFont)
	; DC解放
	DllCall("ReleaseDC", "UInt",0, "UInt",hDC)
	
	; 対象窓の強制再描画
	;  http://msdn.microsoft.com/ja-jp/library/cc410559.aspx
	if (drawn)
		DllCall("user32.dll\RedrawWindow"
			, "UInt", targetHwnd                                          ; ウィンドウのハンドル
			, "UInt", 0                                                   ; 更新したい長方形
			, "UInt", 0                                                   ; 更新したいリージョンのハンドル
			, "UInt", 0x0001 | 0x0002 | 0x0004 | 0x0080 | 0x0100 | 0x0400 ; 再描画フラグからなる配列 (*3)
			, "Int")
	
	WinSet, Enable ; 無効化を戻す
	
	; ジェスチャが無い場合はボタンを押す
	If (!gesture) {
		Send, {blind}{%button% Down}
		KeyWait, %button%
		Send, {%button% Up}
	}
	
	func:=modulePrefix . prefix "_" gesture
	If IsLabel(func)
		Gosub, %func%
}
/*
(*1) CreatePen
	PS_SOLID            0x0000
	PS_DASH             0x0001
	PS_DOT              0x0002
	PS_DASHDOT          0x0003
	PS_DASHDOTDOT       0x0004
	PS_NULL             0x0005
	PS_INSIDEFRAME      0x0006
	PS_USERSTYLE        0x0007
*/

/*
(*2) DrawText
	DT_TOP              0x00000000
	DT_LEFT             0x00000000
	DT_CENTER           0x00000001
	DT_RIGHT            0x00000002
	DT_VCENTER          0x00000004
	DT_BOTTOM           0x00000008
	DT_WORDBREAK        0x00000010
	DT_SINGLELINE       0x00000020
	DT_EXPANDTABS       0x00000040
	DT_TABSTOP          0x00000080
	DT_NOCLIP           0x00000100
	DT_EXTERNALLEADING  0x00000200
	DT_CALCRECT         0x00000400
	DT_NOPREFIX         0x00000800
	DT_INTERNAL         0x00001000

	DT_EDITCONTROL      0x00002000
	DT_PATH_ELLIPSIS    0x00004000
	DT_END_ELLIPSIS     0x00008000
	DT_MODIFYSTRING     0x00010000
	DT_RTLREADING       0x00020000
	DT_WORD_ELLIPSIS    0x00040000
*/

/*
(*3) RedrawWindow
	RDW_INVALIDATE      0x0001
	RDW_INTERNALPAINT   0x0002
	RDW_ERASE           0x0004
	RDW_VALIDATE        0x0008
	RDW_NOINTERNALPAINT 0x0010
	RDW_NOERASE         0x0020
	RDW_NOCHILDREN      0x0040
	RDW_ALLCHILDREN     0x0080
	RDW_UPDATENOW       0x0100
	RDW_ERASENOW        0x0200
	RDW_FRAME           0x0400
	RDW_NOFRAME         0x0800
*/
