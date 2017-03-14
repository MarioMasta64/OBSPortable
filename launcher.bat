@echo off
Color 0A
title PORTABLE OBS LAUNCHER
set nag=BE SURE TO TURN CAPS LOCK OFF! (never said it was on just make sure)
set new_version=OFFLINE
cls
if exist replacer.bat del replacer.bat
del version.txt
del version.txt.1

:FOLDERCHECK
cls
if not exist %CD%\bin mkdir %CD%\bin
if not exist %CD%\doc mkdir %CD%\doc
if not exist %CD%\extra mkdir %CD%\extra
if not exist %CD%\data mkdir %CD%\data

:VERSION
cls
echo 2 > %CD%\doc\version.txt
set /p current_version=<%CD%\doc\version.txt

:CREDITS
cls
if exist %CD%\doc\license.txt goto OBSCHECK
echo ================================================== > %CD%\doc\license.txt
echo =              Script by MarioMasta64            = >> %CD%\doc\license.txt
:: REMOVE SPACE AFTER VERSION HITS DOUBLE DIGITS
echo =            Script Version: v%current_version%-beta            = >> %CD%\doc\license.txt
echo ================================================== >> %CD%\doc\license.txt
echo =You may Modify this WITH consent of the original= >> %CD%\doc\license.txt
echo = creator, as long as you include a copy of this = >> %CD%\doc\license.txt
echo =      as you include a copy of the License      = >> %CD%\doc\license.txt
echo ================================================== >> %CD%\doc\license.txt
echo =    You may also modify this script without     = >> %CD%\doc\license.txt
echo =         consent for PERSONAL USE ONLY          = >> %CD%\doc\license.txt
echo ================================================== >> %CD%\doc\license.txt

:CREDITSREAD
cls
title PORTABLE OBS LAUNCHER - ABOUT
setlocal enabledelayedexpansion
for /f "DELIMS=" %%i in (%CD%\doc\license.txt) do (
	echo %%i
)
endlocal
pause

:OBSCHECK
cls
if not exist %CD%\bin\bin\64bit\obs64.exe goto :FILECHECK
goto WGETUPDATE

:FILECHECK
cls
if not exist %CD%\extra\OBS-Studio-18.0.1-Full.zip call :DOWNLOADOBS
:: if not exist <DLL STUFF> call :DOWNLOAD DLL STUFF
if not exist %CD%\bin\extractobs.vbs call :EXTRACTOBS
goto OBSCHECK

:DOWNLOADOBS
if exist OBS-Studio-18.0.1-Full.zip goto MOVEOBS
if not exist %CD%\bin\wget.exe call :DOWNLOADWGET
%CD%\bin\wget.exe https://github.com/jp9000/obs-studio/releases/download/18.0.1/OBS-Studio-18.0.1-Full.zip

:MOVEOBS
cls
move OBS-Studio-18.0.1-Full.zip %CD%\extra\OBS-Studio-18.0.1-Full.zip
goto FILECHECK

:WGETUPDATE
cls
wget https://eternallybored.org/misc/wget/current/wget.exe
move wget.exe %CD%\bin\
goto MENU

:DOWNLOADWGET
cls
call :CHECKWGETDOWNLOADER
exit /b

:CHECKWGETDOWNLOADER
cls
if not exist %CD%\bin\downloadwget.vbs call :CREATEWGETDOWNLOADER
if exist %CD%\bin\downloadwget.vbs call :EXECUTEWGETDOWNLOADER
exit /b

:CREATEWGETDOWNLOADER
cls
echo ' Set your settings > %CD%\bin\downloadwget.vbs
echo    strFileURL = "https://eternallybored.org/misc/wget/current/wget.exe" >> %CD%\bin\downloadwget.vbs
echo    strHDLocation = "wget.exe" >> %CD%\bin\downloadwget.vbs
echo. >> %CD%\bin\downloadwget.vbs
echo ' Fetch the file >> %CD%\bin\downloadwget.vbs
echo     Set objXMLHTTP = CreateObject("MSXML2.XMLHTTP") >> %CD%\bin\downloadwget.vbs
echo. >> %CD%\bin\downloadwget.vbs
echo     objXMLHTTP.open "GET", strFileURL, false >> %CD%\bin\downloadwget.vbs
echo     objXMLHTTP.send() >> %CD%\bin\downloadwget.vbs
echo. >> %CD%\bin\downloadwget.vbs
echo If objXMLHTTP.Status = 200 Then >> %CD%\bin\downloadwget.vbs
echo Set objADOStream = CreateObject("ADODB.Stream") >> %CD%\bin\downloadwget.vbs
echo objADOStream.Open >> %CD%\bin\downloadwget.vbs
echo objADOStream.Type = 1 'adTypeBinary >> %CD%\bin\downloadwget.vbs
echo. >> %CD%\bin\downloadwget.vbs
echo objADOStream.Write objXMLHTTP.ResponseBody >> %CD%\bin\downloadwget.vbs
echo objADOStream.Position = 0    'Set the stream position to the start >> %CD%\bin\downloadwget.vbs
echo. >> %CD%\bin\downloadwget.vbs
echo Set objFSO = Createobject("Scripting.FileSystemObject") >> %CD%\bin\downloadwget.vbs
echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> %CD%\bin\downloadwget.vbs
echo Set objFSO = Nothing >> %CD%\bin\downloadwget.vbs
echo. >> %CD%\bin\downloadwget.vbs
echo objADOStream.SaveToFile strHDLocation >> %CD%\bin\downloadwget.vbs
echo objADOStream.Close >> %CD%\bin\downloadwget.vbs
echo Set objADOStream = Nothing >> %CD%\bin\downloadwget.vbs
echo End if >> %CD%\bin\downloadwget.vbs
echo. >> %CD%\bin\downloadwget.vbs
echo Set objXMLHTTP = Nothing >> %CD%\bin\downloadwget.vbs
exit /b

:EXECUTEWGETDOWNLOADER
cls
cscript.exe %CD%\bin\downloadwget.vbs
move wget.exe %CD%\bin\
exit /b

:EXTRACTOBS
cls
call :CHECKOBSEXTRACTOR
exit /b

:CHECKOBSEXTRACTOR
cls
if not exist %CD%\bin\%CD%\bin\extractobs.vbs call :CREATEOBSEXTRACTOR
if exist %CD%\bin\%CD%\bin\extractobs.vbs call :EXECUTEOBSEXTRACTOR
exit /b

:CREATEOBSEXTRACTOR
echo. > %CD%\bin\extractobs.vbs
echo 'The location of the zip file. >> %CD%\bin\extractobs.vbs
echo ZipFile="%CD%\extra\OBS-Studio-18.0.1-Full.zip" >> %CD%\bin\extractobs.vbs
echo 'The folder the contents should be extracted to. >> %CD%\bin\extractobs.vbs
echo ExtractTo="%CD%\bin\" >> %CD%\bin\extractobs.vbs
echo. >> %CD%\bin\extractobs.vbs
echo 'If the extraction location does not exist create it. >> %CD%\bin\extractobs.vbs
echo Set fso = CreateObject("Scripting.FileSystemObject") >> %CD%\bin\extractobs.vbs
echo If NOT fso.FolderExists(ExtractTo) Then >> %CD%\bin\extractobs.vbs
echo    fso.CreateFolder(ExtractTo) >> %CD%\bin\extractobs.vbs
echo End If >> %CD%\bin\extractobs.vbs
echo. >> %CD%\bin\extractobs.vbs
echo 'Extract the contants of the zip file. >> %CD%\bin\extractobs.vbs
echo set objShell = CreateObject("Shell.Application") >> %CD%\bin\extractobs.vbs
echo set FilesInZip=objShell.NameSpace(ZipFile).items >> %CD%\bin\extractobs.vbs
echo objShell.NameSpace(ExtractTo).CopyHere(FilesInZip) >> %CD%\bin\extractobs.vbs
echo Set fso = Nothing >> %CD%\bin\extractobs.vbs
echo Set objShell = Nothing >> %CD%\bin\extractobs.vbs
echo. >> %CD%\bin\extractobs.vbs

:EXECUTEOBSEXTRACTOR
cls
cscript.exe %CD%\bin\extractobs.vbs
exit /b

:MENU
cls
title PORTABLEOBSLAUNCHER - MAIN MENU
echo %NAG%
set nag=SELECTION TIME!
echo 1. reinstall obs [not a feature yet]
echo 2. launch obs
echo 3. reset obs [not a feature yet]
echo 4. uninstall obs
echo 5. update program
echo 6. about
echo 7. exit
set /p choice="enter a number and press enter to confirm: "
if %choice%==1 goto NEW
if %choice%==2 goto DEFAULT
if %choice%==3 goto SELECT
if %choice%==4 goto DELETE
if %choice%==5 goto UPDATECHECK
if %choice%==6 goto ABOUT
if %choice%==7 goto EXIT
set nag="PLEASE SELECT A CHOICE 1-7"
goto MENU

:NULL
set nag="NOT A FEATURE YET!"
goto MENU

:NEW
goto NULL

:DEFAULT
title DO NOT CLOSE
set path=%path%;%~d0\dll
xcopy /q %CD%\data\* %appdata%\obs-studio\ /e /i /y
rmdir /s /q %CD%\data
cls
echo OBS IS RUNNING
cd %CD%\bin\bin\64bit\
obs64.exe -portable
goto EXIT

:SELECT
goto NULL

:DELETE
cls
title PORTABLE OBS LAUNCHER - UNINSTALL OBS
echo %NAG%
set nag=SELECTION TIME!
echo type "yes" to uninstall obs
echo or anything else to cancel
set /p choice="are you sure: "
if %choice%==yes call :NOWDELETING 0
goto MENU

:NOWDELETING
set choice=%1
if %choice%==1 title PORTABLE OBS LAUNCHER - RESETTING OBS
if %choice%==0 title PORTABLE OBS LAUNCHER - UNINSTALLING OBS
cls
echo %NAG%ING
rmdir /s /q %CD%\extra
rmdir /s /q %CD%\doc
rmdir /s /q %CD%\bin\Steam
cls
if %choice%==1 title PORTABLE OBS INSTALLER - RESET
if %choice%==0 title PORTABLE OBS INSTALLER - UNINSTALLED
if %choice%==1 echo OBS HAS BEEN RESET
if %choice%==0 echo OBS HAS BEEN UNINSTALLED
pause
exit /b

:UPDATECHECK
cls
if exist version.txt del version.txt
if not exist %CD%\bin\wget.exe call :DOWNLOADWGET
%CD%\bin\wget.exe https://raw.githubusercontent.com/MarioMasta64/OBSPortable/master/version.txt
set /p new_version=<version.txt
if %new_version%==OFFLINE goto ERROROFFLINE
if %current_version% EQU %new_version% goto LATEST
if %current_version% LSS %new_version% goto NEWUPDATE
if %current_version% GTR %new_version% goto NEWEST
goto ERROROFFLINE

:LATEST
cls
title PORTABLE OBS LAUNCHER - LATEST BUILD :D
echo you are using the latest version!!
echo Current Version: v%current_version%
echo New Version: v%new_version%
echo ENTER TO CONTINUE
pause
goto MENU

:NEWUPDATE
cls
echo %NAG%
set nag=SELECTION TIME!
title PORTABLE OBS LAUNCHER - OLD BUILD D:
echo you are using an older version
echo enter yes or no
echo Current Version: v%current_version%
echo New Version: v%new_version%
set /p choice="Update?: "
if %choice%==yes goto UPDATE
if %choice%==no goto MENU
set nag="please enter YES or NO"
goto NEWUPDATE

:UPDATE
cls
if not exist %CD%\bin\wget.exe call :DOWNLOADWGET
%CD%\bin\wget.exe https://raw.githubusercontent.com/MarioMasta64/OBSPortable/master/launcher.bat
if exist launcher.bat.1 goto REPLACERCREATE
goto ERROROFFLINE

:REPLACERCREATE
cls
echo del launcher.bat >> replacer.bat
echo rename launcher.bat.1 launcher.bat >> replacer.bat
echo start launcher.bat >> replacer.bat
start replacer.bat
exit

:NEWEST
cls
cls
title PORTABLE OBS LAUNCHER - TEST BUILD :0
echo YOURE USING A TEST BUILD MEANING YOURE EITHER
echo CLOSE TO ME OR YOURE SOME SORT OF PIRATE
echo Current Version: v%current_version%
echo New Version: v%new_version%
echo ENTER TO CONTINUE
pause
start launcher.bat
exit

:ABOUT
cls
del %CD%\doc\license.txt
start launcher.bat
exit

:ERROROFFLINE
cls
set nag="YOU SEEM TO BE OFFLINE PLEASE RECONNECT TO THE INTERNET TO USE THIS FEATURE"
goto MENU

:ERROR
cls
echo ERROR OCCURED
pause

:EXIT
cd ..
cd ..
cd ..
xcopy /q %appdata%\obs-studio\* %CD%\data\ /e /i /y
rmdir /s /q %appdata%\obs-studio
exit