#i:: 
	WinGet, OutputProcessName, ProcessName, A 
	MouseGetPos, MouseX, MouseY 
	
	ToolTip, %A_Mon%/%A_MDay%(%A_DDD%)`n%A_Hour%:%A_Min%, %mouseX%, %mouseY%, 1 

	Sleep, 3000 
	ToolTip, , , 1 

return

#p::
MouseGetPos,X,Y
ToolTip,‚±‚ñ‚É‚¿‚Í,X,Y,1
Sleep,10000
ToolTip
return