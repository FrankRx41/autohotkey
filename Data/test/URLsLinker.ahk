Menu,univ,Add,main(&1),univ
Menu,univ,Add
Menu,univ,Add, Toodledo ,univ/toodledo

Menu,univ,Color,0xAAAAAA
univ:
	return
univ/toodledo:
	Run, https://www.toodledo.com/signin.php
	return

#b::
	CoordMode, Menu, Screen
	Menu,univ,Show,700,500
return
