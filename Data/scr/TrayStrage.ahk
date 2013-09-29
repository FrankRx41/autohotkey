#NoTrayIcon

^LWin::
  CoordMode, Mouse, Screen
  MouseGetPos, X, Y
  IfWinActive, ahk_class NotifyIconOverflowWindow
    WinHide, ahk_class NotifyIconOverflowWindow
  Else
  {
    DetectHiddenWindows, On
    WinMove, ahk_class NotifyIconOverflowWindow, , %X%, %Y%
    WinShow, ahk_class NotifyIconOverflowWindow
    WinActivate, ahk_class NotifyIconOverflowWindow
    SetTimer, NIOFHide, 100
  }
Return
NIOFHide:
  IfWinNotActive, ahk_class NotifyIconOverflowWindow
  {
    WinHide, ahk_class NotifyIconOverflowWindow
    SetTimer, NIOFHide, OFF
  }
Return