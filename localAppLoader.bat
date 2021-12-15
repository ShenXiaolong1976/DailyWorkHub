::Author    : Shen Xiaolong((xlshen@126.com))
::Copyright : free use,modify,spread, but MUST include this original two line information(Author and Copyright).
::usage     : call batchHandler.bat "localLoader://protocol:anyParameters"
::example   : call batchHandler.bat "localLoader://vscodeOpen:/local_vol1_nobackup/xiaoshen/tmp"

:: parameter %* example : "localLoader://vscodeOpen:/local_vol1_nobackup/xiaoshen/tmp/"

@if {"%_Echo%"}=={"1"} ( @echo on ) else ( @echo off )
echo %0 %*
call :parserProtocol %*
goto :End

:: ********************************* protocol interfaces ***********************************************************************************
:locatePath
@where tools_txtFile.bat 1>nul 2>nul || @set "path=%WinScriptPath%\common;%path%"
start explorer.exe /select, "%~f1"
goto :eof

:openFolder
@where tools_txtFile.bat 1>nul 2>nul || @set "path=%WinScriptPath%\common;%path%"
start explorer.exe "%~f1"
goto :eof

:editFile
@where tools_txtFile.bat 1>nul 2>nul || @set "path=%WinScriptPath%\common;%path%"
call :editFile%~x1 "%~f1"
goto :eof

:openFile
@where tools_txtFile.bat 1>nul 2>nul || @set "path=%WinScriptPath%\common;%path%"
call :openFile%~x1 "%~f1"
goto :eof

:clipboard
@where tools_userInput.bat 1>nul 2>nul || @set "path=%WinScriptPath%\common;%path%"
set "_tmpCmd=%~1"
set "_tmpCmd=%_tmpCmd:/=%"
call tools_userInput.bat readClipboard _tmpClipboardData
@where colorTxt.bat 1>nul 2>nul || @set "path=%WinScriptPath%\common;%path%"
if not  defined _tmpClipboardData   call colorTxt.bat  "{02}no data is in clipboard , and using default setting.{\n}{#}"
if      defined _tmpClipboardData   call colorTxt.bat "clipboard data : {0d} %_tmpClipboardData% {\n}{#}"
call :%_tmpCmd% %_tmpClipboardData%
goto :eof

:winscpOpen
:: vscode can't diff folder and file without extension name
call %WinScriptPath%\Companys\AMD\tools_dailyWork.bat scpOpenFolder %*
echo.
goto :eof

:sshLogin
:: vscode can't diff folder and file without extension name
set "tmpServer=%~1"
if {"%tmpServer:~-1%"}=={"/"} set "tmpServer=%tmpServer:~0,-1%"
call %WinScriptPath%\Companys\AMD\tools_dailyWork.bat sshLoginLinux %tmpServer%
echo.
goto :eof

:vscodeOpen
:: vscode can't diff folder and file without extension name
set "_tmp=%~1"
if not  {"%~2"}=={""}   call :vscodeOpen.remote %*
if      {"%~2"}=={""}   if      {"%_tmp:~1,1%"}=={":"} call :vscodeOpen.local %*
if      {"%~2"}=={""}   if not  {"%_tmp:~1,1%"}=={":"} call :vscodeOpen.remote %*
echo.
goto :eof


:vncConnect
@where vncviewer.exe 1>nul 2>nul || @set "path=C:\Program Files\RealVNC\VNC Viewer;%path%"
:: withoud password input : vncviewer -> File -> Export Connections : ... to generate the .vnc file
:: "C:\Program Files\RealVNC\VNC Viewer\vncviewer.exe" -config C:\temp\vncexport\srdcws451-1.vnc
start /B vncviewer.exe -config %1
echo.
goto :eof

:runCmd
@where vncviewer.exe 1>nul 2>nul || @set "path=C:\Program Files\RealVNC\VNC Viewer;%path%"
:: withoud password input : vncviewer -> File -> Export Connections : ... to generate the .vnc file
:: "C:\Program Files\RealVNC\VNC Viewer\vncviewer.exe" -config C:\temp\vncexport\srdcws451-1.vnc
set "tmpCmd=%~1"
if {"%tmpCmd:~-1%"}=={"/"} set "tmpCmd=%tmpCmd:~0,-1%"
start /B %tmpCmd%
goto :eof

:testURL
echo testURL : %*
start /B msg %username% /v /w /time:99999 "test message from %~nx0 : %*"
goto :eof

:: ******************************************* inner implement begin *************************************************************************
:parserProtocol
set "cmds=%~1"
set "localURL=%cmds:~12%"         &;rem remove protocol part localLoader:
:: echo localURL=%localURL%
if {"%localURL:~0,2%"}=={"//"}   set "localURL=%localURL:~2%"
:: echo localURL=%localURL%
set appVar=%localURL::=&;rem %
:: echo appVar=%appVar%
set "argVar=%localURL:*:=%"
:: echo argVar=%argVar%
call :%appVar% "%argVar%"
goto :eof

:editFile.txt
:editFile.log
:editFile.html
@where tools_txtFile.bat 1>nul 2>nul || @set "path=%WinScriptPath%\common;%path%"
start /B tools_txtFile.bat openTxtFile "%~f1"
goto :eof

:openFile.docx
:openFile.xlsx
:openFile.pptx
@where tools_txtFile.bat 1>nul 2>nul || @set "path=%WinScriptPath%\common;%path%"
echo open word file : %~f1
start /B explorer.exe "%~f1"
goto :eof

:vscodeOpen.remote
call %WinScriptPath%\Companys\AMD\tools_dailyWork.bat openLinuxFolder %*
echo.
goto :eof

:vscodeOpen.local
:: code.cmd --help
@where tools_error.bat 1>nul 2>nul || @set "path=%WinScriptPath%\common;%path%"
call tools_error.bat checkPathExist "%~1"
:: start /B code.cmd -n --locale zh-cn "%~1"
start /B code.cmd "%~1"
echo.
goto :eof

:errorMsg
echo.
echo %*
echo.
pause 
goto :End
goto :eof

:: ******************************************* inner implement end *************************************************************************

:End
echo %~fs0
exit