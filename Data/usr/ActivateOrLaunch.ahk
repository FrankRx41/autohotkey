;; �l�X�ȃP�[�X�ŃE�B���h�E���A�N�e�B�u�ɂ��� AutoHotKey �̊֐�
;; 1. �E�B���h�E���\������Ă���ꍇ�B
;; 2. �^�X�N�g���C�ɕ܂��Ă���ꍇ�B
;; 3. �A�v���P�[�V�������N�����Ă��Ȃ��ꍇ�͋N���B

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
;; �����ɂ̓R�}���h�̃t���p�X��n���B
#^p:: ActivateOrLaunch("D:\bin\AFx\AFXW.EXE")