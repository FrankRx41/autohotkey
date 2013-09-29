#NoTrayIcon

^!C::
  MouseGetPos, X, Y
  PixelGetColor, color, %X%, %Y%, RGB
  StringReplace, color, color, 0x, #
  Clipboard = %color%
  ClipWait, 1
  Tooltip, %Color%
  Sleep, 1500
  Tooltip,
Return