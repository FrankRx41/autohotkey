;AutoHotKey for SteelSeries Xai
;LastUpdate 2009/11/16
;http://neue.cc/
;MEMO
;�C���L�[: ^ Ctrl , ! Alt , + Shift , # Win
;���s��`r , �ϐ����p����%hoge%
;Xai�̉E��O��Pause�A�E����ScrollLock�Ƃ���
;����O��XButton1�A����XButton2
;Center��Ctrl�Ƃ��ACtrl�{���E��O���A�v���ŗL�L�[�Ƃ���

;Test�p
;F5::Reload

;���ˑ��Œ�ϐ�
GyazoPath = "C:\Program Files (x86)\Gyazo\gyazowin.exe"
IrfanViewPath = "C:\Program Files (x86)\IrfanView\i_view32.exe"

;-------------------------------------------
;�֐�
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
;�}�E�X
;-------------------------------------------

MButton::Shift
;����O
XButton1::BackSpace
;����
XButton2::Send,!{F4}
+XButton2::Send,^!{F4}
;�E��O
Pause::SearchSelectedText()
;�E��
ScrollLock::WinMinimize, A
+ScrollLock::WinSet,AlwaysOnTop,TOGGLE,A

;-------------------------------------------
;�L�[�{�[�h
;-------------------------------------------

;���ϊ�
;�\���L�[�]�[��
vk1Dsc07B & e::Send,{Up}
vk1Dsc07B & s::Send,{Left}
vk1Dsc07B & d::Send,{Down}
vk1Dsc07B & f::Send,{Right}
vk1Dsc07B & w::Send,{PgUp}
vk1Dsc07B & r::Send,{PgDn}
vk1Dsc07B & q::Send,{Home}
vk1Dsc07B & a::Send,{End}
vk1Dsc07B & t::Send,^{Home}
vk1Dsc07B & g::Send,^{End}
vk1Dsc07B & z::Send,^{Left}
vk1Dsc07B & c::Send,^{Right}
vk1Dsc07B & x::Send,{End}+{Home}
vk1Dsc07B & v::Send,{End}{Enter}
vk1Dsc07B & b::Send,{Up}{End}{Enter}
vk1Dsc07B & Tab::TileMove()
;���L�[(�}���`�f�B�X�v���C�ł̃E�B���h�E�ړ�)
vk1Dsc07B & Left::SendToTargetMonitor(3)
vk1Dsc07B & Right::SendToTargetMonitor(1)
vk1Dsc07B & Up::SendToTargetMonitor(4)
vk1Dsc07B & Down::SendToTargetMonitor(2)

;�ϊ�
vk1Csc079 & a::SandString("<a href="""">","</a>")
vk1Csc079 & c::SandString("<pre lang=""csharp"">`r","`r</pre>")
vk1Csc079 & j::SandString("<pre lang=""javascript"">`r","`r</pre>")
vk1Csc079 & f::SandString("<pre lang=""fsharp"">`r","`r</pre>")
vk1Csc079 & Left::MoveWindow(-100,0)
vk1Csc079 & Right::MoveWindow(100,0)
vk1Csc079 & Up::MoveWindow(0,-100)
vk1Csc079 & Down::MoveWindow(0,100)

;Windows�L�[
;�A�N�e�B�u���j�^�̔����T�C�Y�ɂ��č��E�Ɋ񂹂�
#Left::
    GetActiveMonitor(x, y, w, h)
    WinGet, id, ID, A
    WinMove, ahk_id %id%,,x, y, w / 2 , h
    return
#Right::
    GetActiveMonitor(x, y, w, h)
    WinGet, id, ID, A
    WinMove, ahk_id %id%,,x + w / 2, y, w / 2 , h
    return
;�ŏ����ƕ���
#Up::RestoreAll()
#Down::#d

;Insert
Ins::
    Send,!{PrintScreen}
    ClipWait, 1, 1
    Run,%IrfanViewPath% /clippaste
    return
^Ins::Run, %GyazoPath%

;Application�L�[
AppsKey & c::Run,calc.exe
AppsKey & d::Run,cmd.exe
AppsKey & n::Run,notepad.exe

;-------------------------------------------
;�A�v���P�[�V�����ŗL�ݒ�
;-------------------------------------------

;�tⳎ�
#IfWinActive, ahk_class THUSENSHI
F1::WinMove, A,,,,480,45

; Firefox
#IfWinActive,ahk_class MozillaUIWindowClass
XButton2::Send,^w
^XButton2::Send,!{F4}
+XButton1::Send,^{Left} ;�^�u�����Ɉړ�(Firefox���ŃL�[�J�X�^�}�C�Y�ς�)
+Pause::Send,^{Right}

;Notepad++
#IfWinActive,ahk_class Notepad++
F5::Reload ;AutoHotKey�̃X�N���v�g�X�V
^Left::Send,^+{Tab}
^Right::Send,^{Tab}
^c:: LineCopy()

;DOS��
#IfWinActive,ahk_class ConsoleWindowClass
^v::ControlSend,,%clipboard%

;Visual Studio
#IfWinActive,ahk_class wndclass_desked_gsk
^w::Send,^{F4} ;�^�u�����
XButton2::Send,^{F4}
+XButton2::Send,!{F4}
+XButton1::Send,^- ;��`����߂�
+Pause::Send,{F12} ;��`�ֈړ�

;�ϊ�
vk1Csc079 & c::
	HotString("/// <summary></summary>")
	Loop,10
        Send,{Left}
	return