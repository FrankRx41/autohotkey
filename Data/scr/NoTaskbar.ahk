#NoTrayIcon
#Persistent
  ; �^�X�N�o�[�̔�\����
  WinHide,ahk_class Shell_TrayWnd
  TaskBarHide = 1
return


$!2::
  ; �^�X�N�o�[�̔�\����
  if TaskBarHide =
  {
    WinHide,ahk_class Shell_TrayWnd
    TaskBarHide = 1
  }
  else
  {
    WinShow,ahk_class Shell_TrayWnd
    TaskBarHide =
  }
return