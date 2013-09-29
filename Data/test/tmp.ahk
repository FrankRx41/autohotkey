;Main AutoHotkey File
;LastUpdate 2009/11/16
;�C���L�[: ^ Ctrl , ! Alt , + Shift , # Win
;[���ϊ�]    vk1Dsc07B
;[�ϊ�]      vk1Csc079
;[��/�S]     sc029
;[�J�i/����] vkF2sc070
;���s��`r , �ϐ����p����%hoge%
;����O��XButton1�A����XButton2
;�e�X�g�p
;F5::Reload
;����������������������������������������
;��                                    ��
;��             AutoHotkey             ��
;��                                    ��
;����������������������������������������
;
;�� �N������t�@�C���𑊑΃p�X�Ŏw�肷��
SetWorkingDir,%A_ScriptDir%

;�� �I�[�g�G�O�[�L���[�g�Z�N�V����
Run, ..\eClip\eClip.exe
Run, ..\AFx\AFXW.EXE -s -l"C:\" -r"..\..\"
Run, ..\clnch\clnch.exe

;�� �C���N���[�h�Z�N�V����
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
; �֐�
;-------------------------------------------

;������\��t���p�֐�
HotString(msg)
{
	bk=%ClipboardAll%
	Clipboard=%msg%
	Send,^v
	Clipboard=%bk%
}

;�����񋲂ݍ��ݗp�֐�
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

;�N���b�v�{�[�h�̒��g�ŕ����񋲂ݍ��ݗp�֐�
ClipSandString(start,end)
{
	bk=%ClipboardAll%
	Clipboard = %start%%clipboard%%end%
	Send,^v
	Clipboard=%bk%
}

;�I�������e�L�X�g���e�ł�����E���[�J���f�B���N�g���̎��̓G�N�X�v���[���N��
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

;��s�R�s�[���ǂ�
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

;Window�ړ��p�֐�
MoveWindow(xStep,yStep)
{
	WinGetPos,X,Y,,,A
	X:=X+xStep
	Y:=Y+yStep
	WinMove A,,X,Y
}

; �w��ԍ��̃��j�^�T�C�Y���擾����
GetMonitor(monitorNo, ByRef mX, ByRef mY, ByRef mW, ByRef mH)
{
	SysGet, m, MonitorWorkArea, %monitorNo%
	mX := mLeft
	mY := mTop
	mW := mRight - mLeft
	mH := mBottom - mTop
}

; �A�N�e�B�u�E�B���h�E�̍�����W���܂܂�郂�j�^���擾����
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

;�Ώۃ��j�^�ɃA�N�e�B�u�E�B���h�E���ړ�����(�������T�C�Y)
SendToTargetMonitor(monitorNo)
{
	WinGetPos, x, y, w, h, A
	GetMonitor(monitorNo, mX, mY, mW, mH)
	Random, rand, 50, 200
	WinMove, A,, mX + rand, mY, w, mH
}

;�A�N�e�B�u�ȃA�v���P�[�V�����Ɠ����ނ̃E�B���h�E�𐅕������ɕ��ׂ�(�ő�4���܂�)
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

;�S�ẴA�v���P�[�V���������ɖ߂�
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
; �}�E�X
;-------------------------------------------

;�� �}�E�X�ŋ[��CraftLaunch
~LButton & WheelUp::Run, ..\clnch\clnch.exe
~LButton & WheelDown::
	Process,Exist,chrome.exe
	if ErrorLevel<>0
		WinActivate,ahk_pid %ErrorLevel%
	else
		Run, %LocalAppData%\Google\Chrome\Application\chrome.exe,,Max
return

;�� �ȈՃ}�E�X�A�v���X�C�b�`
~XButton1 & WheelUp::AltTab
~XButton1 & WheelDown::ShiftAltTab

;�� �ȈՃ}�E�X�W�F�X�`��
SetTitleMatchMode, RegEx
#IfWinActive, ahk_class CabinetWClass|ExplorerWClass
$RButton::MoGe("Explorer")
#IfWinActive
; �i��
	MoGe_Explorer_R:
	Send, {Browser_Forward}
	return
; �߂�
	MoGe_Explorer_L:
	return
; ����
	MoGe_Explorer_DR:
	Send, !{F4}
	return
; ��̃t�H���_��
	MoGe_Explorer_U:
	Send, {Backspace}
	return
#IfWinActive

;�� �z�C�[���{�^�����N���b�N�Ō��ݎ����\��
;MButton::Msgbox,%A_Year%/%A_Mon%/%A_MDay%`n%A_Hour%��%A_Min%��%A_Sec%�b

;�� �z�C�[���{�^�����N���b�N�ŃA�N�e�B�u�E�B���h�E���ŏ���
MButton::WinMinimize,A

;�� XButton2�ł��ӂ��N��
XButton2::Run, ..\AFx\AFXW.EXE -s

;-------------------------------------------
; �z�b�g�L�[�֘A
;-------------------------------------------

;�� Cntl+Shift��CLaunch�N��
;Control & Shift::Run, ..\CLaunch\CLaunch.exe
;Shift & Control::Run, ..\CLaunch\CLaunch.exe

;�� Win+A�ł��ӂ��N��
#A::Run, ..\AFx\AFXW.EXE -s

;�� Win+F��Everything�̃t�@�C������
#F::Run, ..\AFx\tools\Everything\Everything.exe

;�� Win+Q�ŃN�C�b�N�^�[�~�l�[�^�[
#Q::
	Run, ..\qt0\qt0.exe
	Sleep, 1000
	FileDelete, *.ini
Return

;�� Win+G�ŋK��̃u���E�U��Google�N��
#G::Run,  https://www.google.co.jp/

;�� Win+H�ŋK��̃u���E�U��http����
;#H::Run, https://www.google.co.jp/

;�� Win+P��Paper Plane xUI�N��
#P::
Process,Exist,ppcw.exe
if ErrorLevel<>0
	WinActivate,ahk_pid %ErrorLevel%
else
	Run, ..\PPx\PPCW.EXE
Return

;�� Win+C��Chrome�N��
#C::
Process,Exist,chrome.exe
if ErrorLevel<>0
	WinActivate,ahk_pid %ErrorLevel%
else
	Run, %LocalAppData%\Google\Chrome\Application\chrome.exe,,Max
Return

;�� Win+O��Opera�N��
#O::
Process,Exist,opera.exe
if ErrorLevel<>0
	WinActivate,ahk_pid %ErrorLevel%
else
	Run, ..\Opera\opera.exe
Return

;�� Win+E�ŃG�N�X�v���[���i�f�X�N�g�b�v�j
#E::Run, %USERPROFILE%\Desktop\

;�� Win+N��Evernote�N��
#N::Run, C:\Program Files\Evernote\Evernote\Evernote.exe,,Max

;�� Win+S�ŃT�N���G�f�B�^���J��
#S::Run, ..\AFx\tools\sakura\sakura.exe

;�� Win+ALt��cltc�N��
;#Alt::Run, ..\cltc\cltc.exe
;!LWin::Run, ..\cltc\cltc.exe
;!RWin::Run, ..\cltc\cltc.exe

;�� Ctrl2�񉟂���eClip
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

;�� Shift2�񉟂���cltc
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

;�� Ctrl+Space��IME�X�C�b�`���[
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

;�� CapsLock��IME�X�C�b�`
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
;sc029 vkF3sc029 vkF4sc029 => [��/�S]
;��vkf0sc03A / sc03a
;���ǂ�����CapsLock

;-------------------------------------------
; �A�N�e�B�u�E�B���h�E�֘A
;-------------------------------------------

;�� �A�N�e�B�u���j�^�̔����T�C�Y�ɂ��č��E�Ɋ񂹂�
;#Left::

;�� �ŏ����ƕ���
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

;�� �A�N�e�B�u�E�B���h�E����ɍŎ�O
#W::WinSet, Topmost, Toggle,A

;�� �A�N�e�B�u�ȃA�v���P�[�V�����Ɠ����ނ̃E�B���h�E�𐅕������ɕ��ׂ�(�ő�4���܂�)
#T::TileMove()

;�� Win+Space�ŃA�N�e�B�u�E�B���h�E�����
LWin & Space::WinClose,A
RWin & Space::WinClose,A

;�� Alt+Space�ŃA�N�e�B�u�E�B���h�E�����
Alt & Space::WinClose,A

;�� Win+M�ŃA�N�e�B�u�E�B���h�E���ŏ���
#M::WinMinimize,A

;�� Win+�ϊ��ōő剻�g�O��
LWin & vk1Csc079::
	WinGet, tmp, MinMax,A
	If tmp = 1
		WinRestore,A
	else
		WinMaximize,A
Return

;�� Esc�������ŃE�B���h�E����
$Esc::
	KeyWait, Esc, T0.3
		if ErrorLevel
			Send,!{F4}
		else
    		Send,{Esc}
	Keywait, Esc
Return

;�� �_�u���E�N���b�N�ŃA�N�e�B�u�E�B���h�E���N���[�Y
~RButton::
If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
{
	Sleep, 100
	Send, {Esc}
	WinClose,A
}
Return

;�� ��Windows�L�[�{X��Alt+Tab�Ɠ��������
LWin & Z::ShiftAltTab

;�� ��Windows�L�[�{Z��Shift�{Alt+Tab�Ɠ��������
;LWin & X::AltTab

;�� Ctrl+G�Ŕ��]���������[�h��Google�Ō���
^G::
bk=%ClipboardAll%
Clipboard=
Send, ^c
ClipWait
Run, http://www.google.com/search?q=%Clipboard%
Clipboard=%bk%
Return

;-------------------------------------------
; �A�v���P�[�V�����ŗL�ݒ�
;-------------------------------------------

;�� �^�X�N�o�[�ŉ��ʕύX
#IfWinActive,ahk_class Shell_TrayWnd
	~WheelUp::Send, {Volume_Up}
	~WheelDown::Send, {Volume_Down}
	~MButton::Send, {Volume_Mute}
	Up::Send, {Volume_Up}
	Down::Send, {Volume_Down}
	Right::Send, {Volume_Mute}
	Left::Send, {Volume_Mute}
Return

;�� Windows�t�H�g�r���[�A
#IfWinActive ahk_class Photo_Lightweight_Viewer 
	Esc::send,!{F4}
#IfWinActive

;�� �G�N�X�v���[��
#IfWinActive ahk_class CabinetWClass 
	Esc::send,!{F4}
#IfWinActive

;�� Everything�Ńt�@�C���p�X���R�s�[(Shift+C)
#IfWinActive,ahk_class EVERYTHING
	+C::
		ControlGetText, text,msctls_statusbar321, ahk_class EVERYTHING
		Clipboard=%text%
Return

;�� ������
#IfWinActive ahk_class Notepad
	^r::^h
	^w::Send,!ow
	Esc::Send !{F4}
#IfWinActive

;�� �y�C���g
#IfWinActive ahk_class MSPaintApp
	Esc::Send !{F4}
#IfWinActive

;�� �R�}���h�v�����v�g
#IfWinActive ahk_class ConsoleWindowClass
	^v::
		Keywait, ctrl
		Send, !{Space}ep
		return
#IfWinActive

;�� Chrome
#IfWinActive ahk_class Chrome_WidgetWin_1
;~vk1Dsc07B=���ϊ��Avk1Csc079=�ϊ��AvkF2sc070=�J�i����
	F1::^w                          ;�^�u�����
	;F2::^t                          ;�V�K�^�u
	;F3::^+n                         ;�V�[�N���b�g���[�h
	F4::^+o                         ;�u�b�N�}�[�N
	F6::^+t                         ;�ŋߕ����^�u
	MButton::^w                     ;�^�u�����
	vk1Dsc07B::^w                   ;�^�u�����[���ϊ�]
	vk1Csc079::Send,{Backspace}     ;�������P�߂�[�ϊ�]
	vkF2sc070::^Tab                 ;�^�u�ړ�[�A�v���P�[�V�����L�[]
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

;�� Opera
#IfWinActive ahk_class OperaWindowClass
	F1::^w             ;�^�u��
	F2::^+Tab          ;���̃^�u
	F3::^Tab           ;�E�̃^�u
	F4::^+b            ;�u�b�N�}�[�N
	!z::^+b            ;�u�b�N�}�[�N
	^Numpad0::^t       ;SpeedDial
#IfWinActive

;�� ���n
#IfWinActive ahk_class TFormMain
	Esc::send,!{F4}
#IfWinActive

;�� �t�@�C�����K�w������
#IfWinActive ahk_class WindowsForms10.Window.8.app.0.378734a
	Esc::Send, !{F4}
	return
#IfWinActive

;�� SumatraPDF
#IfWinActive ahk_class SUMATRA_PDF_FRAME
	Esc::Send, !{F4}
	;j::Send, {Right}
	;k::Send, {Left}
	h::Send, {Right}
	j::Send, {Down}
	k::Send, {Up}
	l::Send, {Left}
#IfWinActive

;�� PPe
#IfWinActive ahk_class PPeditW
	Esc::Send, !{F4}
#IfWinActive

;�� DF
#IfWinActive DF 
	Esc::Send, !{F4}
#IfWinActive

;�� FileSum
#IfWinActive FileSum
	Esc::Send, !{F4}
#IfWinActive

;�� �t�@�C�������w�肵�Ď��s
#IfWinActive ahk_class #32770
; ��3�����܂��̓t���l�[��
; ***�ȉ��I�[�����[�U�ݒ�***
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
; ���̑�
;-------------------------------------------

;�� �ʒm�̈�ɕ\�����Ȃ�
;#NoTrayIcon

;�� ���}�b�s���O
;AppsKey::LWin

;�� �L�[�𖳌���
LWin Up::Return
RWin Up::Return
;��[��/�S]�L�[
;sc029::return
;��[�J�i/����]�L�[
vkF2sc070::return

;�� ���͕⊮�n
::gm::b4b4r07@gmail.com
::b4::b4b4r07@gmail.com
::b1::b1012231@fun.ac.jp
::c1::c10h14o@docomo.ne.jp
::vj::vj2sw3v1
::486::48694062
::848::84841207

;�� Shift+DEL�ŃJ�[�\���s���폜
+DEL::Send,{Home}+{End}{Delete}

;�� Ctrl+L�ł��̍s��I������
^L::Send,{End}+{Home}

;�� ���ϊ�+C�ŃJ�[�\���s���N���b�v�{�[�h�֓]��
~vk1Dsc07B & C::Send,{Home}+{End}^c

;�� ���ϊ�+V�ŃJ�[�\���s�ɓ\��t��
~vk1Dsc07B & V::Send,{Home}+{End}^v

;�� ���ϊ�+���ŃJ�[�\���s�擪
~vk1Dsc07B & Left::Send,{Home}

;�� ���ϊ�+���ŃJ�[�\���s����
~vk1Dsc07B & Right::Send,{End}

;�� Ctrl+���ŃJ�[�\���s�擪
;Ctrl & Left::Send,{Home}

;�� Ctrl+���ŃJ�[�\���s����
;Ctrl & Right::Send,{End}

;�� Shift�Ȃ���_��Ō�
;SC073::_

;�� �e�X�g�i�����j
#K::
if(COMPUTERNAME=="BABAROTT-PC")
	Run, notepad.exe
else
	Run, mspaint.exe
Return

;�� �N���b�v�{�[�h�Ď��E�e�L�X�g�ۑ�
OnClipboardChange:
	if A_EventInfo = 1
		FileAppend, %clipboard%`n`n ********** `n`n, .\Data\clipboard.txt
return

;; test
^[::Send, {Esc}
#V::Run, C:\bin\vim\gvim.exe