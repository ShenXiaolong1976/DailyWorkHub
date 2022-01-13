::Author    : Shen Xiaolong((xlshen@126.com))
::Copyright : free use,modify,spread, but MUST include this original two line information(Author and Copyright).
::usage     : call batchHandler.bat "localLoader://protocol:anyParameters"
::example   : call batchHandler.bat "localLoader://vscodeOpen:/local_vol1_nobackup/xiaoshen/tmp"

:: parameter %* example : "localLoader://vscodeOpen:C:/work/shenxiaolong/core/WinScript/userSetting/contextMenu/localAppLoader/"

::@set _Echo=1
set _Stack=%~nx0
@if {"%_Echo%"}=={"1"} ( @echo on ) else ( @echo off )
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo. & @echo [+++++ %~nx0] commandLine: %0 %*
where "%~nx0" 1>nul 2>nul || set "path=%~dp0;%path%"
call :parserProtocol %*
goto :End %*

:: ********************************* protocol interfaces ***********************************************************************************
:locatePath
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@where tools_txtFile.bat 1>nul 2>nul || @set "path=%WinScriptPath%\common;%path%"
start explorer.exe /select, "%~f1"
goto :eof

:openFolder
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@where tools_txtFile.bat 1>nul 2>nul || @set "path=%WinScriptPath%\common;%path%"
start explorer.exe "%~f1"
goto :eof

:editFile
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@where tools_txtFile.bat 1>nul 2>nul || @set "path=%WinScriptPath%\common;%path%"
call :editFile%~x1 "%~f1"
goto :eof

:openFile
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@where tools_txtFile.bat 1>nul 2>nul || @set "path=%WinScriptPath%\common;%path%"
call :openFile%~x1 "%~f1"
goto :eof

:clipboard
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
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
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
:: vscode can't diff folder and file without extension name
echo private erase:  use your customized command line to open the winscp.
pause
echo.
goto :eof

:sshLogin
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
:: vscode can't diff folder and file without extension name
set "tmpServer=%~1"
if {"%tmpServer:~-1%"}=={"/"} set "tmpServer=%tmpServer:~0,-1%"
echo private erase:  use your customized command line to open the ssh.
pause
echo.
goto :eof

:vscodeOpen
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
:: vscode can't diff folder and file without extension name
set "_tmp=%~1"
if not  {"%~2"}=={""}   call :vscodeOpen.remote %*
if      {"%~2"}=={""}   if      {"%_tmp:~1,1%"}=={":"} call :vscodeOpen.local %*
if      {"%~2"}=={""}   if not  {"%_tmp:~1,1%"}=={":"} call :vscodeOpen.remote %*
echo.
goto :eof


:vncConnect
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@where vncviewer.exe 1>nul 2>nul || @set "path=C:\Program Files\RealVNC\VNC Viewer;%path%"
:: withoud password input : vncviewer -> File -> Export Connections : ... to generate the .vnc file
:: "C:\Program Files\RealVNC\VNC Viewer\vncviewer.exe" -config C:\temp\vncexport\srdcws451-1.vnc
start /B vncviewer.exe -config %1
echo.
goto :eof

:runCmd
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@where vncviewer.exe 1>nul 2>nul || @set "path=C:\Program Files\RealVNC\VNC Viewer;%path%"
set "tmpCmd=%~1"
if {"%tmpCmd:~-1%"}=={"/"} set "tmpCmd=%tmpCmd:~0,-1%"
start /B %tmpCmd%
goto :eof

:testURL
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
echo testURL : %*
start /B msg %username% /v /w /time:99999 "test message from %~nx0 : %*"
goto :eof

:: ******************************************* inner implement begin *************************************************************************
:parserProtocol
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
set "cmds=%~1"
call :parserProtocol.escapeBlank
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

:parserProtocol.escapeBlank
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
if defined _Debug echo before : %cmds%
:: re-escape blank char with # because localLoader protocol needs to use # to escape blank char. else an illegal char is embedded.
:: example   : <a href="localLoader://runCmd:cmd.exe /c C:/work/sync_svnRepo_all.bat"> update svn repo to cloud disk  </a> 
:: escape to : <a href="localLoader://runCmd:cmd.exe!/c!C:/work/sync_svnRepo_all.bat"> update svn repo to cloud disk  </a> 
:: example : start /B cmd.exe /c c:\temp\myScript.bat "enable"
set "cmds=%cmds:!= %"
if defined _Debug echo after  : %cmds%
goto :eof

:editFile.txt
:editFile.log
:editFile.html
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@where tools_txtFile.bat 1>nul 2>nul || @set "path=%WinScriptPath%\common;%path%"
call tools_txtFile.bat openTxtFile "%~f1"
goto :eof

:openFile.docx
:openFile.xlsx
:openFile.pptx
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@where tools_txtFile.bat 1>nul 2>nul || @set "path=%WinScriptPath%\common;%path%"
echo open word file : %~f1
start /B explorer.exe "%~f1"
goto :eof

:vscodeOpen.remote
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
echo private erase:  use your customized command line to open the remote linux folder.
pause
echo.
goto :eof

:vscodeOpen.local
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
:: code.cmd --help
@where tools_error.bat 1>nul 2>nul || @set "path=%WinScriptPath%\common;%path%"
call tools_error.bat checkPathExist "%~1"
echo private erase:  use your customized command line to open the local folder.
pause
echo.
goto :eof

:errorMsg
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
echo.
echo %*
echo.
pause 
goto :End
goto :eof

:: ******************************************* inner implement end *************************************************************************
:End
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [----- %~nx0] commandLine: %0 %* & @echo.
