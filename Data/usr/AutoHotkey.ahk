;����������������������������������������
;��                                    ��
;��         AutoHotkey(BA)             ��
;��                                    ��
;����������������������������������������
;
;�� �ʒm�̈�ɕ\�����Ȃ�
;#NoTrayIcon

;�� �N������\�t�g�𑊑΃p�X�Ŏw�肷��
SetWorkingDir,%A_ScriptDir%

;��auto_execute_section
Run, ..\CLaunch\CLaunch.exe
Run, ..\Paster\Paster.exe
Run, ..\WheelRedirector\Wheel Redirector.exe
Run, ..\TrayVolume\TrayVolume.exe

;_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/

;�� ���}�b�s���O
AppsKey::LWin

;�� Shift�Ȃ���_��Ō�
;SC073::_

;�� Win�L�[�𖳌���
;LWin Up::Return ;WIN�L�[���������Ȃ��Ȃ�

;���}�E�X�ł̃W�F�X�`���[
;~RButton & WheelUp::Run, ..\AFx\AFXW.EXE -s
;~RButton & WheelDown::Run, ..\AFx\AFXW.EXE -s
~LButton & WheelUp::Run, ..\CLaunch\CLaunch.exe
~LButton & WheelDown::
	Process,Exist,chrome.exe
	if ErrorLevel<>0
	  WinActivate,ahk_pid %ErrorLevel%
	else
	  Run, ..\GoogleChrome\GoogleChromePortable.exe
	return

;�� Cntl+Shift��CLaunch�N��
Control & Shift::Run, ..\CLaunch\CLaunch.exe

;�� Win+A �ł��ӂ��N��
#A::Run, ..\AFx\AFXW.EXE -s

;�� Win+F��Everything�̃t�@�C������
#F::Run, ..\AFx\tools\Everything\Everything.exe

;�� Win+G�ŋK��̃u���E�U��Google�N��
#G::Run, ..\GoogleChrome\GoogleChromePortable.exe https://www.google.co.jp/

;�� Win+H�ŋK��̃u���E�U��http
#H::Run, https://www.google.co.jp/

;�� Win+C��Chrome�N��
#C::
Process,Exist,chrome.exe
if ErrorLevel<>0
  WinActivate,ahk_pid %ErrorLevel%
else
  Run, ..\GoogleChrome\GoogleChromePortable.exe
return

;�� Win+O��Opera�N��
#O::
Process,Exist,opera.exe
if ErrorLevel<>0
  WinActivate,ahk_pid %ErrorLevel%
else
  Run, ..\Opera\opera.exe
return

;��Win+E�Ń}�C�R���s���[�^���J��
#E::Run, ..\AFx\etc\MyComputer.{20D04FE0-3AEA-1069-A2D8-08002B30309D}

;�� Win+N��Evernote�N��
#N::Run, C:\Program Files\Evernote\Evernote\Evernote.exe

;�� Win+S�ŃT�N���G�f�B�^���J��
#S::Run, ..\AFx\tools\sakura\sakura.exe

;�� Win+Space�ŃA�N�e�B�u�E�B���h�E�����
LWin & Space::WinClose,A

;�� Alt+Space�ŃA�N�e�B�u�E�B���h�E�����
Alt & Space::WinClose,A

;�� Win+M�ŃA�N�e�B�u�E�B���h�E���ŏ���
#M::WinMinimize,A

;�� Win+�ϊ��ōő剻�g�O��
LWin & vk1Csc079::
    WinGet, tmp, MinMax, A
    If tmp = 1
        WinRestore, A
    Else
        WinMaximize, A
Return

;�� Opera
#IfWinActive ahk_class OperaWindowClass
F1::^w  ; �^�u���B
F2::^+Tab  ; ���̃^�u�B
F3::^Tab  ; �E�̃^�u�B
F4::^+b
F5::^r  ; F5�֎~�΍�B
!z::^+b
^Numpad0::^t
#IfWinActive

;�� Esc�������ŃE�B���h�E����
$Esc::
  KeyWait, Esc, T0.3
  if ErrorLevel
    send,!{F4}
  else
    send,{Esc}
  keywait, Esc
return

;�� ��Windows�L�[�{Z��Shift�{Alt+Tab�Ɠ��������
;LWin & X::AltTab

;�� ��Windows�L�[�{X��Alt+Tab�Ɠ��������
LWin & Z::ShiftAltTab

;�� Chrome��ɂĕϊ��L�[�Ŗ߂�L�[
#IfWinActive - Google Chrome ahk_class Chrome_WidgetWin_0
 ;vk1Dsc07B=���ϊ��Avk1Csc079=�ϊ�
 vk1Csc079::Send,{Backspace}
#IfWinActive

;�� Alt+G�Ŕ��]���������[�h��Google�Ō���
!G::                                            ;Win+G�L�[�Ɋ��蓖��
bk=%ClipboardAll%                               ;�N���b�v�{�[�h�̓��e���o�b�N�A�b�v
Clipboard=                                      ;�N���b�v�{�[�h���N���A
Send,^c                                         ;Ctrl+C�L�[�𑗐M
ClipWait                                        ;�N���b�v�{�[�h�Ƀe�L�X�g���i�[�����܂őҋ@
Run,..\GoogleChrome\GoogleChromePortable.exe http://www.google.com/search?q=%Clipboard%  ;�N���b�v�{�[�h�̓��e����������Google��URL���J��
Clipboard=%bk%                                  ;�o�b�N�A�b�v�������e�������߂�
return

;�� Everything�Ńt�@�C���p�X���R�s�[(Shift+C)
#IfWinActive,ahk_class EVERYTHING
	+C::
		ControlGetText, text,msctls_statusbar321, ahk_class EVERYTHING
		Clipboard=%text%
return

;�� �������ł̃R�}���h
#IfWinActive ahk_class Notepad
 ^r::^h
 ^w::Send,!ow
#IfWinActive

; --- �R�}���h�v�����v�g��ŁActrl+v �œ\���
#IfWinActive ahk_class ConsoleWindowClass
^v::
  keywait, ctrl
  Send, !{SPACE}ep  ; [�ҏW]��[�\���]
  return
#IfWinActive

;�� ���͕⊮
::gm::b4b4r07@gmail.com
::b4::b4b4r07@gmail.com
::b1::b1012231@fun.ac.jp
::c1::c10h14o@docomo.ne.jp
::vj::vj2sw3v1
::vj2::vj2sw3v1
::486::48694062
::848::84841207

^]::#tab

;�� �N���b�v�{�[�h�Ď��E�ۑ�
OnClipboardChange:
	if A_EventInfo = 1
		FileAppend, %clipboard%`n`n ********** `n`n, .\Data\clipboard.txt
return

