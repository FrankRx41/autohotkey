#NoTrayIcon

^!Left::WinMove(-50,0)	; X������-50px�AY������0px�ړ�
^!Right::WinMove(50,0)	; X������+50px�AY������0px�ړ�
^!Up::WinMove(0,-50)	; X������0px�AY������-50px�ړ�
^!Down::WinMove(0,50)	; X������0px�AY������+50px�ړ�
WinMove(MoveX, MoveY) {
  WinGetPos, X, Y, , , A
  X += MoveX
  Y += MoveY
  WinMove, A, , %X%, %Y%
}