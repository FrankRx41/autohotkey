/*
�������� �ȈՃ}�E�X�W�F�X�`���֐� "MoGe" ��������

�{�X�N���v�g�̓W�F�X�`������̊֐��݂̂ŒP�̂ŋN�����Ă�
�����N�����ɏI�����܂��B

�ȉ��̂悤�Ȃ��Ƃ͖{�X�N���v�g�ł͐��䂹���ɁA
�Ăяo�����ōs���ĖႤ�Ƃ����O��ł��B

�E�ǂ̂悤�ȏ����ŃW�F�X�`�����J�n���邩
�E�W�F�X�`���̌��ʂƂ��ĉ����s����

�܂�g�ݍ��ݑO���AutoHotkey�X�N���v�g��������l��
�ΏۂƂ��Ă��Ă��܂��B

==============================
  �������@
==============================

�ȉ��̉��ꂩ�̕��@�ŁA�C���N���[�h���s���B
  �E�{�X�N���v�g���ہX�R�s�y����
  �E#Include���Ŗ{�t�@�C�����w�肷��
  �E�֐����C�u�����X�N���v�g�Ƃ��Ĕz�u����

==============================
  ���쌴���Ɛݒ���@
==============================

�}�E�X�{�^�����g���K�ɂ��Ė{�֐����Ă΂��ƁA
�{�^������܂Ń}�E�X�̓��������߂� L / R /U / D ��4��̕������
�A�������u�W�F�X�`��������v�𐶐�����B

���̌�ȉ��̂悤�ȕ�����𐶐����āA�L���ȃT�u���[�`�����x���ł���ꍇ��
������Ăяo���B

  {���W���[���ړ���} . {��1����} . "_" . {�W�F�X�`��������}


��) �ȉ��̂悤�ɃX�N���v�g����������

    SetTitleMatchMode, RegEx
    #IfWinActive, ahk_class ExplorerWClass|CabinetWClass
    $RButton::$MoGe("Explorer")

    MoGe_Explorer_R:
      Send, {Browser_Forward}
      return
    MoGe_Explorer_L:
      Send, {Browser_Back}
      return

�G�N�X�v���[����ŁA�E�{�^�����Ői�ށA�E�{�^�����Ŗ߂�A�ƂȂ�B


==============================
  �J�X�^�}�C�Y
==============================
�T�u���[�`�����x���� "Moge_Init"�������鎖�Łu�����́v�J�X�^�}�C�Y���o���܂��B

  Moge_PenSize     : �y���̑���
  Moge_PenColor    : �y���F�B16�i���Ŏw��B�F����NG�B
  Moge_FontHeight  : �t�H���g�̍���(=�T�C�Y)
  Moge_FontWeight  : �t�H���g�̑���(0�`1000)
  Moge_FontName    : �t�H���g���B
  Moge_Sensitivity : ���x�B���̐��l�̃s�N�Z���������ړ�����������v�Z���s���B
                     �傫���ƁA�F���������Ȃ�B���������Ă��g���Ȃ��B

==============================
  ���C�Z���X
==============================
�p�u���b�N�h���C���ŁB

*/
SetTitleMatchMode, RegEx

; �ϐ��̏�����
Moge_Init:
	Moge_PenSize     = 3          ; (Int) �y���̑���
	Moge_PenColor    = 0x00FF00   ; (Int) �y���F(RRGGBB)
	;Moge_PenColor    = 0xFFFFFF   ; (Int) �y���F(RRGGBB)
	Moge_FontHeight  = 20         ; (Int) �t�H���g�̍���
	Moge_FontWeight  = 600        ; (Int) �t�H���g�̑���(0�`1000)
	Moge_FontName    = Arial      ; (Str) �t�H���g��
	Moge_Sensitivity = 30         ; (Int) ���x(�s�N�Z��)
	return

MoGe(prefix, timeout=1000, modulePrefix="MoGe_") {
	global Moge_PenSize,Moge_PenColor,Moge_FontHeight,Moge_FontWeight,Moge_FontName,Moge_Sensitivity
	static hModule
	SetBatchLines, 0
	SetWinDelay,-1
	Gosub, Moge_Init
	CoordMode, Mouse, Relative
	CoordMode, Tooltip, Relative
	; �{�^�����͎�������
	button := RegExReplace(A_ThisHotkey, "^\W+|\s.+", "", "", -1)
	; ���W�A���v�Z�p�Ȃǂ̕ϐ���������
	lastDir = "", moved:=false
	
	if (!hModule)
		hModule:=DllCall("LoadLibrary", "Str","gdi32.dll")
	
	MouseGetPos,,, targetHwnd
	IfWinNotExist, ahk_id %targetHwnd% ; Last Found Window
		return
	
	; �Ώۂ��A�N�e�B�u������
	WinActivate
	WinWaitActive
	MouseGetPos,ox,oy ; ���΍��W�ɂȂ��Ă���, o:original
	WinGetPos, tX, tY, tW, tH ; t:target
	
	; �}�E�X�ړ��ɂ���ăc�[���`�b�v��|�b�v�A�b�v���o�Ȃ��悤�ɗ}��
	WinSet, Disable
	
	; �`��̈�擾���擾(�E�B���h�E�S��)
	;  http://msdn.microsoft.com/ja-jp/library/cc410408.aspx
	hDC:=DllCall("GetWindowDC", "UInt", targetHwnd)
	
	; �y������ : http://msdn.microsoft.com/ja-jp/library/cc428348.aspx
	hPen:=DllCall("gdi32.dll\CreatePen"
		, "Int", 0                   ; �y���̃X�^�C�� (*1)
		, "Int", Moge_PenSize        ; �y���̕�
		, "Int", Moge_PenColor       ; �y���̐F
		, "UInt")
	; ���������y����I��
	;  http://msdn.microsoft.com/ja-jp/library/cc410576.aspx
	hOldPen:=DllCall("gdi32.dll\SelectObject", "UInt",hDC, "UInt",hPen)
	
	; �_���t�H���g����
	;  http://msdn.microsoft.com/ja-jp/library/cc428368.aspx
	hFont:=DllCall("gdi32.dll\CreateFontA"
		, "Int",  Moge_FontHeight    ; �t�H���g�̍���
		, "Int",  0                  ; ���ϕ�����
		, "Int",  0                  ; ������������̊p�x
		, "Int",  0                  ; �x�[�X���C���̊p�x
		, "Int",  Moge_FontWeight    ; �t�H���g�̑���
		, "UInt", 0                  ; �Α̂ɂ��邩�ǂ���
		, "UInt", 0                  ; ������t���邩�ǂ���
		, "UInt", 0                  ; ����������t���邩�ǂ���
		, "UInt", 0                  ; �����Z�b�g�̎��ʎq
		, "UInt", 0                  ; �o�͐��x
		, "UInt", 0                  ; �N���b�s���O���x
		, "UInt", 0                  ; �o�͕i��
		, "UInt", 0                  ; �s�b�`�ƃt�@�~��
		, "Str",  Moge_FontName      ; �t�H���g��
		, "UInt")
	hOldFont:=DllCall("gdi32.dll\SelectObject", "UInt",hDC, "UInt",hFont)
	
	; �W�F�X�`��������̕`��̈�
	;  http://msdn.microsoft.com/en-us/library/dd162897(VS.85).aspx
	VarSetCapacity(RECT, 16, 0x00)
	; �E�B���h�E�S�̂�`��̈�Ƃ���B(x1,y1)��VarSetCapacity�ŏ������ς�
	NumPut(tW, RECT, 8, "Int"), NumPut(th, RECT, 12, "Int")
	
	; �y���ړ�
	;  http://msdn.microsoft.com/ja-jp/library/cc410478.aspx
	DllCall("gdi32.dll\MoveToEx", "UInt",hDC, "Int",oX, "Int",oY, "UInt",0)
	
	pX:=oX, pY:=oY
	while GetKeyState(button, "P") 
	{
		; �^�C���A�E�g����
		if (A_TimeSinceThisHotkey > timeout && !moved)
			break
		
		MouseGetPos, x, y
		dx:=x-pX, dy:=y-pY, dist:=Sqrt(dx**2+dy**2)
		
		if (dist> 10) {
			; �w��̃y���ŕ`�� : http://msdn.microsoft.com/ja-jp/library/cc410428.aspx
			DllCall("gdi32.dll\LineTo", "UInt",hDC, "Int",x, "Int",y)
			drawn:=true ; �ĕ`��̈�
		}
		if (dist < Moge_Sensitivity)
			Continue
		
		moved:=true
		
		; �p�x�v�Z�A�킴�킴�x�ɕς��Ă���͓̂��ɈӖ��͂Ȃ�
		degree := 90*ATan(dy/dx)/Asin(1)
		degree := (dy>=0) ? (dx>0 ? degree : dx==0 ? 90 : 180+degree) : dx<0 ? 180+degree : dx==0 ? 270 : 360+degree
		
		dir := (degree <30 || degree > 330) ? "R" : (degree > 150 && degree<210) ? "L"
		     : (degree > 60 && degree < 120) ? "D" : (degree > 240 && degree < 300) ? "U"
		     : "" ; 1�`2��/4�`5��/7�`8��/10�`11���̎��͎����z��
		
		if !dir
			Continue
		
		gesture .= (lastDir != dir) ? dir : "" ; ���������������ǉ����Ȃ�
		lastDir := (dir) ? dir : lastDir
		
		pX:=x, pY:=y
		
		; ������`�� : �`��ʒu��ς������Ȃ�R�R
		;  http://msdn.microsoft.com/ja-jp/library/cc428474.aspx
		DllCall("user32.dll\DrawTextA"
			, "UInt", hDC              ; �f�o�C�X�R���e�L�X�g�̃n���h��
			, "Str",  gesture          ;  �`�悷��e�L�X�g
			, "Int",  StrLen(gesture)  ; �e�L�X�g�̒���
			, "UInt", &RECT            ; �e�L�X�g��`�悷�钷���`�̈�
			, "UInt", 0x28             ; �e�L�X�g�`��I�v�V���� (*2)
			, "Int")
	}
	
	; ���̃y���A�t�H���g�ɖ߂�
	DllCall("gdi32.dll\SelectObject", "UInt",hDC, "UInt",hOldPen)
	DllCall("gdi32.dll\SelectObject", "UInt",hDC, "UInt",hOldFont)
	; ���̊֐��Ő����������͔̂j��
	;  http://msdn.microsoft.com/ja-jp/library/cc428362.aspx
	DllCall("gdi32.dll\DeleteObject", "UInt",hPen)
	DllCall("gdi32.dll\DeleteObject", "UInt",hFont)
	; DC���
	DllCall("ReleaseDC", "UInt",0, "UInt",hDC)
	
	; �Ώۑ��̋����ĕ`��
	;  http://msdn.microsoft.com/ja-jp/library/cc410559.aspx
	if (drawn)
		DllCall("user32.dll\RedrawWindow"
			, "UInt", targetHwnd                                          ; �E�B���h�E�̃n���h��
			, "UInt", 0                                                   ; �X�V�����������`
			, "UInt", 0                                                   ; �X�V���������[�W�����̃n���h��
			, "UInt", 0x0001 | 0x0002 | 0x0004 | 0x0080 | 0x0100 | 0x0400 ; �ĕ`��t���O����Ȃ�z�� (*3)
			, "Int")
	
	WinSet, Enable ; ��������߂�
	
	; �W�F�X�`���������ꍇ�̓{�^��������
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
