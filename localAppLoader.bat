::Author    : Shen Xiaolong((xlshen@126.com))
::Copyright : free use,modify,spread, but MUST include this original two line information(Author and Copyright).
::usage     : call batchHandler.bat "localLoader://protocol:anyParameters"
::example   : call batchHandler.bat "localLoader://vscodeOpen:C:/temp/DailyWorkHub/"

:: parameter %* example : "localLoader://vscodeOpen:C:/temp/DailyWorkHub/"

@if {"%_Echo%"}=={"1"} ( @echo on ) else ( @echo off )
echo %0 %*
call :parserProtocol %*
goto :End

:: ********************************* protocol interfaces ***********************************************************************************
:locatePath
start explorer.exe /select, "%~f1"
goto :eof

:openFolder
start explorer.exe "%~f1"
goto :eof

:editFile
call :editFile%~x1 "%~f1"
goto :eof

:openFile
call :openFile%~x1 "%~f1"
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
start /B notepad.exe "%~f1"
goto :eof

:openFile.docx
:openFile.xlsx
:openFile.pptx
echo open word file : %~f1
start /B explorer.exe "%~f1"
goto :eof

:vscodeOpen.remote
echo vscodeOpen remote path : %*
echo customize your action here.
pause
echo.
goto :eof

:vscodeOpen.local
:: code.cmd --help
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