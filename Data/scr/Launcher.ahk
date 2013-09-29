#NoTrayIcon

Menu,univ,Add,univ.,univ
Menu,univ,Add
Menu,univ,Add,Toodledo,univ/2do
Menu,univ,Add,auth,univ/auth
Menu,univ,Add,STUDENT,univ/student
Menu,univ,Add,WebDAV,univ/webdav
Menu,univ,Add,Webmail,univ/webmail
Menu,univ,Add,Moodle,univ/moodle
Menu,univ,Add,Hope,univ/hope
Menu,univ,Add,Hope2,univ/hope2
Menu,univ,Add,Algo,univ/algo
Menu,univ,Add,Robot,univ/robot

Menu,univ,Color,0xAAAAAA
univ:
	return
univ/2do:
	Run, https://www.toodledo.com/signin.php
	return
univ/auth:
	Run, http://auth.fun.ac.jp/.exe
	return
univ/student:
	Run, https://student.fun.ac.jp/up/faces/login/Com00501A.jsp
	return
univ/webdav:
	Run, https://webdav.fun.ac.jp/proself/login/login.go?AD=init
	return
univ/webmail:
	Run, https://webmail.fun.ac.jp/
	return
univ/moodle:
	Run, http://vle.c.fun.ac.jp/moodle/login/index.php
	return
univ/hope:
	Run, http://hope.c.fun.ac.jp/
	return
univ/hope2:
	Run, http://hope2013.c.fun.ac.jp/
	return
univ/algo:
	Run, http://portal.fun.ac.jp/course/2013Algo/
	return
univ/robot:
	Run, http://hope2013.c.fun.ac.jp/course/view.php?id=46
	return

#b::
	CoordMode, Menu, Screen
	Menu,univ,Show,700,500
return
