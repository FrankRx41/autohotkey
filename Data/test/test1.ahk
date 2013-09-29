Menu,foobar,Add,main(&1),foobar
Menu,foobar,Add
Menu,foobar,Add,&auth,foobar/auth
Menu,foobar,Add,&student,foobar/student
Menu,foobar,Add,&webdav,foobar/webdav
Menu,foobar,Add,web&mail,foobar/webmail
Menu,foobar,Add,Moo&dle,foobar/Moodle

Menu,foobar,Color,0xFF33FF
foobar:
	return
foobar/auth:
	Run, http://auth.fun.ac.jp/.exe
	return
foobar/student:
	Run, https://student.fun.ac.jp/up/faces/login/Com00501A.jsp
	return
foobar/webdav:
	Run, https://webdav.fun.ac.jp/proself/login/login.go?AD=init
	return
foobar/webmail:
	Run, https://webmail.fun.ac.jp/
	return
foobar/Moodle:
	Run, http://vle.c.fun.ac.jp/moodle/login/index.php
	return
foobar/test:
InputBox, UserInput, メッセージ, メッセージをどうぞ。,, 640, 200
if ErrorLevel
    MsgBox, 48, メッセージ, Cancel ボタンが押されたか、もしくはウィンドウが閉じられました。
else
    MsgBox, 64, メッセージ, 「%UserInput%」が入力されました。
	return

	foobar/exit:
param := SubStr(A_ThisLabel, 7)
	;Run, C:\app\media\foobar2000\foobar2000.exe %param%, C:\app\media\foobar2000\
Return

; If InputChar=b
; {
; 	CoordMode, Menu, Screen
; 	Menu,foobar,Show,700,500
; }
#P::
	CoordMode, Menu, Screen
	Menu,foobar,Show,700,500
	return
