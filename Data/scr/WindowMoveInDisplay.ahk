#NoTrayIcon

^!Left::WinMove(-50,0)	; X方向に-50px、Y方向に0px移動
^!Right::WinMove(50,0)	; X方向に+50px、Y方向に0px移動
^!Up::WinMove(0,-50)	; X方向に0px、Y方向に-50px移動
^!Down::WinMove(0,50)	; X方向に0px、Y方向に+50px移動
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