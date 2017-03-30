@echo off

color 0A
MODE CON: COLS=32 LINES=8
cls
if exist replacer.bat del replacer.bat
if not exist bin mkdir bin

rmdir /s /q .\doc\
call :MIGRATEFILES
call :UPDATE
exit

:MIGRATEFILES
cls
title=Migrating obs Files
if exist .\bin\bin\ xcopy .\bin\bin\* .\bin\obs\bin\ /e /i /y
if exist .\bin\data\ xcopy .\bin\data\* .\bin\obs\data\ /e /i /y
if exist .\bin\obs-plugins\ xcopy .\bin\obs-plugins\* .\bin\obs\obs-plugins\ /e /i /y
if exist .\data\basic\ xcopy .\data\basic\* .\data\obs\basic\ /e /i /y
if exist .\data\crashes\ xcopy .\data\crashes\* .\data\obs\crashes\ /e /i /y
if exist .\data\logs\ xcopy .\data\logs\*" .\data\obs\logs\ /e /i /y
if exist .\data\plugin_config\ xcopy .\data\plugin_config\* .\data\obs\plugin_config\ /e /i /y
if exist .\data\profiler_data\ xcopy .\data\profiler_data\* .\data\obs\profiler_data\ /e /i /y
if exist .\data\updates\ xcopy .\data\updates\* .\data\obs\updates\ /e /i /y
if exist .\data\global.ini move .\data\global.ini .\data\obs\global.ini
if exist .\bin\bin\ rmdir /s /q .\bin\bin\
if exist .\bin\data\ rmdir /s /q .\bin\data\
if exist .\bin\obs-plugins\rmdir /s /q .\bin\obs-plugins\
if exist .\data\basic\ rmdir /s /q .\data\basic\
if exist .\data\crashes\ rmdir /s /q .\data\crashes\
if exist .\data\logs\ rmdir /s /q .\data\logs\
if exist .\data\plugin_config\ rmdir /s /q .\data\plugin_config\
if exist .\data\profiler_data\ rmdir /s /q .\data\profiler_data\
if exist .\data\updates\ rmdir /s /q .\data\updates\
exit /b

:UPDATE
cls
if not exist .\bin\wget.exe call :DOWNLOADWGET
.\bin\wget.exe https://raw.githubusercontent.com/MarioMasta64/EverythingPortable/master/launch_obs.bat
if exist launch_obs.bat echo del launcher.bat > replacer.bat
if exist launch_obs.bat echo start launch_obs.bat >> replacer.bat
if exist launch_obs.bat echo exit >> replacer.bat
start replacer.bat
exit /b

:DOWNLOADWGET
cls
title=Downloading WGET

:CHECKWGETDOWNLOADER
cls
if not exist .\bin\downloadwget.vbs call :CREATEWGETDOWNLOADER
if exist .\bin\downloadwget.vbs call :EXECUTEWGETDOWNLOADER
exit /b

:CREATEWGETDOWNLOADER
cls
echo ' Set your settings > .\bin\downloadwget.vbs
echo    strFileURL = "https://eternallybored.org/misc/wget/current/wget.exe" >> .\bin\downloadwget.vbs
echo    strHDLocation = "wget.exe" >> .\bin\downloadwget.vbs
echo. >> .\bin\downloadwget.vbs
echo ' Fetch the file >> .\bin\downloadwget.vbs
echo     Set objXMLHTTP = CreateObject("MSXML2.XMLHTTP") >> .\bin\downloadwget.vbs
echo. >> .\bin\downloadwget.vbs
echo     objXMLHTTP.open "GET", strFileURL, false >> .\bin\downloadwget.vbs
echo     objXMLHTTP.send() >> .\bin\downloadwget.vbs
echo. >> .\bin\downloadwget.vbs
echo If objXMLHTTP.Status = 200 Then >> .\bin\downloadwget.vbs
echo Set objADOStream = CreateObject("ADODB.Stream") >> .\bin\downloadwget.vbs
echo objADOStream.Open >> .\bin\downloadwget.vbs
echo objADOStream.Type = 1 'adTypeBinary >> .\bin\downloadwget.vbs
echo. >> .\bin\downloadwget.vbs
echo objADOStream.Write objXMLHTTP.ResponseBody >> .\bin\downloadwget.vbs
echo objADOStream.Position = 0    'Set the stream position to the start >> .\bin\downloadwget.vbs
echo. >> .\bin\downloadwget.vbs
echo Set objFSO = Createobject("Scripting.FileSystemObject") >> .\bin\downloadwget.vbs
echo If objFSO.Fileexists(strHDLocation) Then objFSO.DeleteFile strHDLocation >> .\bin\downloadwget.vbs
echo Set objFSO = Nothing >> .\bin\downloadwget.vbs
echo. >> .\bin\downloadwget.vbs
echo objADOStream.SaveToFile strHDLocation >> .\bin\downloadwget.vbs
echo objADOStream.Close >> .\bin\downloadwget.vbs
echo Set objADOStream = Nothing >> .\bin\downloadwget.vbs
echo End if >> .\bin\downloadwget.vbs
echo. >> .\bin\downloadwget.vbs
echo Set objXMLHTTP = Nothing >> .\bin\downloadwget.vbs
exit /b

:EXECUTEWGETDOWNLOADER
cls
cscript.exe .\bin\downloadwget.vbs
move wget.exe .\bin\
exit /b