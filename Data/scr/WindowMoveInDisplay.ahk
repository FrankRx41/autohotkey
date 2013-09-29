#NoTrayIcon

^!Left::WinMove(-50,0)	; X������-50px�AY������0px�ړ�
^!Right::WinMove(50,0)	; X������+50px�AY������0px�ړ�
^!Up::WinMove(0,-50)	; X������0px�AY������-50px�ړ�
^!Down::WinMove(0,50)	; X������0px�AY������+50px�ړ�
WinMove(MoveX, MoveY) {
  SysGet, WorkArea, MonitorWorkArea
  WinGetPos, X, Y, W, H, A
  X += MoveX
  Y += MoveY
  X := (X < 0) ? 0 : X
  X := (X + W > WorkAreaRight) ? WorkAreaRight - W : X
  Y := (Y < 0) ? 0 : Y
  Y := (Y + H > WorkAreaBottom) ? WorkAreaBottom - H : Y
  WinMove, A, , %X%, %Y%
}