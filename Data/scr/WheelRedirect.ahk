/*
�}�E�X�z�C�[����]���J�[�\�����̃R���g���[���Ƀ��_�C���N�g	by���s�点��y�[�W�Ǘ��l

MouseGetPos��AltMethod=1�Ŏ��s������A
WM_NCHITTEST���b�Z�[�W�ŃJ�[�\�������Y�R���g���[���̏ォ�ǂ������m�F���A
�R���g���[���O��������AltMethod���g�킸�Ɏ擾���������ƂŁA
���m�ɃJ�[�\�����̃R���g���[���𑀍�ł���B
*/
*WheelDown::
CoordMode,Mouse,Screen
MouseGetPos,x,y,hwnd,ctrl,3
wp:=0xFF880000|GetKeyState("LButton")|GetKeyState("RButton")<<1|GetKeyState("Shift")<<2|GetKeyState("Ctrl")<<3|GetKeyState("MButton")<<4|GetKeyState("XButton1")<<5|GetKeyState("XButton2")<<6
lp:=y<<16|x
IfWinExist,ahk_id %hwnd%
{
	SendMessage,0x84,0,%lp%,,ahk_id %ctrl%
	If ErrorLevel=4294967295
		MouseGetPos,,,,ctrl,2
	Loop,%A_EventInfo%
		PostMessage,0x020A,%wp%,%lp%,,ahk_id %ctrl%
}
return

*WheelUp::
CoordMode,Mouse,Screen
MouseGetPos,x,y,hwnd,ctrl,3
wp:=0x00780000|GetKeyState("LButton")|GetKeyState("RButton")<<1|GetKeyState("Shift")<<2|GetKeyState("Ctrl")<<3|GetKeyState("MButton")<<4|GetKeyState("XButton1")<<5|GetKeyState("XButton2")<<6
lp:=y<<16|x
IfWinExist,ahk_id %hwnd%
{
	SendMessage,0x84,0,%lp%,,ahk_id %ctrl%
	If ErrorLevel=4294967295
		MouseGetPos,,,,ctrl,2
	Loop,%A_EventInfo%
		PostMessage,0x020A,%wp%,%lp%,,ahk_id %ctrl%
}
return
