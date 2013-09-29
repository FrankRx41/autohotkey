;;コピーして検索/開く
; F8::
^g::
  Clipboard =
  Send, ^c
  ClipWait, 1
  SplitPath, Clipboard, Name, Dir, Ext, NoExt, Drive
  IfInString, Drive, http://
    Run, %Clipboard%
  Else If(Drive != "")
    Run, http://www.google.com/search?as_qdr=y16&q=%NoExt%
  Else If(Clipboard != "")
    Run, http://www.google.com/search?as_qdr=y16&q=%Clipboard%
Return
