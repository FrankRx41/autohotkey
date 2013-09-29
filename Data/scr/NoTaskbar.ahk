#NoTrayIcon
#Persistent
  ; タスクバーの非表示化
  WinHide,ahk_class Shell_TrayWnd
  TaskBarHide = 1
return


$!2::
  ; タスクバーの非表示化
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