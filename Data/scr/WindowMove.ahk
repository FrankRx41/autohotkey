#NoTrayIcon

^!Left::WinMove(-50,0)	; X方向に-50px、Y方向に0px移動
^!Right::WinMove(50,0)	; X方向に+50px、Y方向に0px移動
^!Up::WinMove(0,-50)	; X方向に0px、Y方向に-50px移動
^!Down::WinMove(0,50)	; X方向に0px、Y方向に+50px移動
WinMove(MoveX, MoveY) {
  WinGetPos, X, Y, , , A
  X += MoveX
  Y += MoveY
  WinMove, A, , %X%, %Y%
}