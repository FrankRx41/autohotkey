;; 様々なケースでウィンドウをアクティブにする AutoHotKey の関数
;; 1. ウィンドウが表示されている場合。
;; 2. タスクトレイに閉まってある場合。
;; 3. アプリケーションが起動していない場合は起動。

#include TaskTrayIcon.ahk
ActivateOrLaunch(commandPath="") {
    SplitPath, commandPath, appName
    Process, exist, %appName%
    appPID:=errorlevel
    if (appPID <> 0)
    {
       ; there's the window
       WinGet, WIN,, ahk_pid %appPID%
       IfWinExist, ahk_id %WIN%
       {
           WinActivate
       }
       ; the window is hidden in task tray
       else
       {
           DetectHiddenWindows,On
           cnt:=Tray_GetCount()
           Loop,%cnt%{
               Tray_GetInfo(A_Index,hwnd,uid,msg,icon)
               WinGet,pn,ProcessName,ahk_id %hwnd%
               if(pn=appName){
                   PostMessage,%msg%,%uid%,0x203,,ahk_id %hwnd%
                   break
               }
           }
           DetectHiddenWindows,Off
       }
    }
    ; not running
    else
        Run, % commandPath
    return
}
;; 引数にはコマンドのフルパスを渡す。
#^p:: ActivateOrLaunch("D:\bin\AFx\AFXW.EXE")