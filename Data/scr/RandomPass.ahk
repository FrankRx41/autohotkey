#NoTrayIcon

;�����_���p�X���[�h����
^!P::
  Char = 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz
  Num  = 10  ; �p�X���[�h�̌���
  Psw  = 
  While !(RegExMatch(Psw, "[0-9]") && RegExMatch(Psw, "[a-z]") && RegExMatch(Psw, "[A-Z]"))
  {
    Num := (Num < 3) ? 3 : Num
    Psw = 
    Loop, % Num
    {
      Random, Rdm, 1, StrLen(Char)
      Psw .= SubStr(Char, Rdm, 1)
    }
  }
  Clipboard = %Psw%
  AutoHideTooltip(Psw, 1500)
Return

;---�c�[���`�b�v���������֐�---
AutoHideTooltip(Txt, Time, X="", Y="")
{
  Tooltip, %Txt%, %X%, %Y%
  SetTimer, AutoHide, -%Time%
  Return
  AutoHide:
    Tooltip, 
  Return
}