; Main AutoHotkey File
; LastUpdate 2012/11/16
; �C���L�[: ^ Ctrl , ! Alt , + Shift , # Win
; [���ϊ�]    vk1Dsc07B
; [�ϊ�]      vk1Csc079
; [��/�S]     sc029
; [�J�i/����] vkF2sc070
; ���s��`r , �ϐ����p����%hoge%
; ����O��XButton1�A����XButton2
; �e�X�g�p
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

;�� �N������t�@�C���𑊑΃p�X�Ŏw�肷��
SetWorkingDir,%A_ScriptDir%

;�� �I�[�g�G�O�[�L���[�g�Z�N�V����
Run, ..\eClip\eClip.exe
Run, ..\AFXW\AFXW.EXE -s -l"C:\" -r"D:\"
Run, ..\clnch\clnch.exe
;Run, ..\CLaunch\CLaunch.exe

;�� �C���N���[�h
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
; �}�E�X�ݒ�
;-------------------------------------------------------------
;�� �}�E�X�ŋ[��CraftLaunch
;~LButton & WheelUp::Run, ..\CLaunch\CLaunch.exe
~LButton & WheelUp::AltTab
~LButton & WheelDown::
	Process, Exist, chrome.exe
	if ErrorLevel<>0
		WinActivate, ahk_pid %ErrorLevel%
	else
		Run, %LocalAppData%\Google\Chrome\Application\chrome.exe,,Max
return

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
Send, {Browser_Back}
return
; ����
MoGe_Explorer_DR:
Send, !{F4}
return
; ��̃t�H���_��
MoGe_Explorer_U:
Send, {Backspace}
return

;-------------------------------------------------------------
; �L�[�ݒ�
;-------------------------------------------------------------

;�� Win+A�ł��ӂ��N��
#A::Run, ..\AFXW\AFXW.EXE -s

;�� Win+C��Chrome�N��
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

;�� Win+E�ŃG�N�X�v���[���i�f�X�N�g�b�v�j
#E::Run, %USERPROFILE%\Desktop\

;�� Win+F��Everything�̃t�@�C������
#F::Run, ..\Everything\Everything.exe

;�� Win+G�ŋK��̃u���E�U��Google�N��
#G::Run,  https://www.google.co.jp/

;�� Win+N��Evernote�N��
#N::Run, C:\Program Files\Evernote\Evernote\Evernote.exe

;�� Win+V��gVim���J��
#V::
Process,Exist,gvim.exe
if ErrorLevel<>0
	WinActivate,ahk_pid %ErrorLevel%
else
	Run, ..\Vim\gvim.exe
Return

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

;�� Shift+DEL�ŃJ�[�\���s���폜
+DEL::Send,{Home}+{End}{Delete}

;�� Ctrl+L�ł��̍s��I������
^L::Send,{End}+{Home}

;�� Control+[��Esc����
^[::Send, {Esc}

;���L�[�𖳌��� {{{
;Windows�L�[
LWin Up::Return
RWin Up::Return
;[��/�S]�L�[
sc029::return
;[�J�i/����]�L�[
vkF2sc070::return
;[���ϊ�]�L�[
vk1Dsc07B::return
;[�ϊ�]�L�[
vk1Csc079::return
; }}}

;�� ���͕⊮�n
::b4::b4b4r07@gmail.com

;-------------------------------------------------------------
; �E�B���h�E����֘A
;-------------------------------------------------------------

;�� ���ׂĂ̍ŏ����E�B���h�E�����X�g�A
#U::RestoreAll()

;�� �A�N�e�B�u�E�B���h�E����ɍŎ�O
#W::WinSet, Topmost, Toggle, A

;�� �A�N�e�B�u�ȃA�v���P�[�V�����Ɠ����ނ̃E�B���h�E�𐅕������ɕ��ׂ�(�ő�4���܂�)
#T::TileMove()

;�� Win+Space�ŃA�N�e�B�u�E�B���h�E�����
LWin & Space::WinClose, A
RWin & Space::WinClose, A

;�� ��Windows�L�[�{X��Alt+Tab�Ɠ��������
LWin & Z::AltTab

;�� Alt+Space�ŃA�N�e�B�u�E�B���h�E�����
Alt & Space::WinClose, A
#Q::WinClose, A

;�� Win+M�ŃA�N�e�B�u�E�B���h�E���ŏ���
#M::WinMinimize, A

;�� Win+S �ōő剻�g�O��
#S::
WinGet, Now, MinMax ,A
If(Now)
	WinRestore, A
Else
	WinMaximize, A
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

;; ;�� �_�u���E�N���b�N�ŃA�N�e�B�u�E�B���h�E���N���[�Y
;; ~RButton::
;; If (A_PriorHotKey = A_ThisHotKey and A_TimeSincePriorHotkey < 500)
;; {
;; 	Sleep, 100
;; 	Send, {Esc}
;; 	WinClose,A
;; }
;; Return

;-------------------------------------------------------------
; �A�v���P�[�V�����ŗL�ݒ�
;-------------------------------------------------------------
^h::
IfWinNotActive ahk_class TAfxWForm
IfWinNotActive ahk_class Chrome_WidgetWin_1
	;;^h::Send, {BS}
	Send, {BS}
Return

;�� Windows��ł̑���
#h::Send, {Left}
#j::Send, {Down}
#k::Send, {Up}
#l::Send, {Right}

;�� �^�X�N�o�[�ŉ��ʕύX
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

;�� Windows�t�H�g�r���[�A
#IfWinActive ahk_class Photo_Lightweight_Viewer
	Esc::send,!{F4}
#IfWinActive

;�� �G�N�X�v���[��
#IfWinActive ahk_class CabinetWClass
	Esc::send,!{F4}
#IfWinActive


;�� AFXW��̃A�N�V����
#IfWinActive ahk_class TLogForm
	h::Send, {Left}
	j::Send, {Down}
	k::Send, {Up}
	l::Send, {Right}
#IfWinActive

;�� Everything�Ńt�@�C���p�X���R�s�[(Shift+C)
#IfWinActive,ahk_class EVERYTHING
	+C::
		ControlGetText, text,msctls_statusbar321, ahk_class EVERYTHING
		Clipboard=%text%
Return

;�� Vim
#IfWinActive ahk_class Vim
	#V::Send, +{INS}
#IfWinActive

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
	F1::^w                          ;�^�u�����
	F2::^t                          ;�V�K�^�u
	F3::^+n                         ;�V�[�N���b�g���[�h
	F4::^+o                         ;�u�b�N�}�[�N
	F6::^+t                         ;�ŋߕ����^�u
	vkF2sc070::^Tab                 ;�^�u�ړ�[�A�v���P�[�V�����L�[]
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
	h::Send, {Left}
	j::Send, {Down}
	k::Send, {Up}
	l::Send, {Right}
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
	h::Send, {Left}
	j::Send, {Down}
	k::Send, {Up}
	l::Send, {Right}
#IfWinActive

;�� ���ӂ��̏����ł̑���
#IfWinActive ahk_class CLTCMainWindow
	h::Send, {Left}
	j::Send, {Down}
	k::Send, {Up}
	l::Send, {Right}
#IfWinActive

;�� ���ӂ��̏����ł̑���2
#IfWinActive ahk_class TFinfoForm
	^h::Send, {Left}
	^j::Send, {Down}
	^k::Send, {Up}
	^l::Send, {Right}
#IfWinActive

;�� ���ӂ��̏����ł̑���3
#IfWinActive ahk_class TFinf2Form
	^h::Send, {Left}
	^j::Send, {Down}
	^k::Send, {Up}
	^l::Send, {Right}
#IfWinActive

;�� ���ӂ��̏����ł̑���4
#IfWinActive ahk_class TOverForm
	^h::Send, {Left}
	^j::Send, {Down}
	^k::Send, {Up}
	^l::Send, {Right}
#IfWinActive

;�� ���ӂ��ł̊g������
#IfWinActive ahk_class TExRenForm
	^h::Send, {Left}
	^j::Send, {Down}
	^k::Send, {Up}
	^l::Send, {Right}
#IfWinActive

;�� eClip�ł̖�󑀍�
#IfWinActive ahk_class eClipMainClass
	^h::Send, {Left}
	^j::Send, {Down}
	^k::Send, {Up}
	^l::Send, {Right}
#IfWinActive

;�� clnch�ł̖�󑀍�
#IfWinActive ahk_class ClnchWindowClass
	^h::Send, {Left}
	^j::Send, {Down}
	^k::Send, {Up}
	^l::Send, {Right}
#IfWinActive

;�� �t�@�C�������w�肵�Ď��s
#IfWinActive ahk_class #32770
; ��3�����܂��̓t���l�[��
; ***�ȉ��I�[�����[�U�ݒ�***
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
