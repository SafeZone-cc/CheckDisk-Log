@set @x=0; /*
@echo off
SetLocal EnableExtensions
Color 1A
:begin
cls
echo.
echo CheckDisk Log by Dragokas              [  SafeZone.cc  ]
echo.
echo.

if "%~1"=="Admin" goto Begin_Check

echo 1. �믮����� �஢��� ��᪠ � ᮡ��� �����.
echo.
echo 2. ���쪮 ᮡ��� �����.
echo.
echo.
set ch=
set /p ch="������ ���� � ������ ENTER: "
if "%ch%"=="1" goto ForceCheck
if "%ch%"=="2" goto Logs
goto begin

:LOGS
echo ����祭�� ���� �஢�ન ��᪠
echo.
echo ��������, �������� ...
echo.

cd /d "%~dp0"
cd "Log Parser 2.2"
del "%~dp0CheckDisk.html" 2>NUL

set "Query=SELECT TimeGenerated, replace_str(Message,'. ','.<br>') AS Message, RecordNumber INTO ..\CheckDisk.html From Application WHERE EventID IN (1001; 26214; 26226) AND SourceName IN ('Chkdsk'; 'Wininit'; 'Winlogon') AND EventType = 4 ORDER BY TimeGenerated DESC"
LogParser.exe "%Query%" -i:EVT -o:TPL -tpl:Custom.tpl -FileMode 1 -noEmptyFile ON >NUL

echo.
ping -n 3 127.1 >NUL
if not exist "%~dp0CheckDisk.html" goto Check

echo ����娢���� ���� "CheckDisk.html" � �뫮��� �� ��㬥,
echo ��� ��� ����뢠�� ������.

explorer /select,"%~dp0CheckDisk.html"
pause >NUL
Exit /B

:Check
echo ��� �� ������ ���� � �஢�થ ��᪠.
echo ���� �������� �஢��� ��⥬���� ��᪠ ᥩ�� ?
echo.
echo ^>^>^>^>^> ���ॡ���� ��१���㧪� ��⥬� !!! ^<^<^<^<^<
echo.
echo ������ Y ��� � � ������ ENTER ��� ���⢥ত����.
set ch=
set /p ch="(Y)es (�)� / (N)o (�)��: "
if /i "%ch%" neq "Y" if /i "%ch%" neq "�" exit /B

:ForceCheck
net session >NUL 2>NUL || (
  echo �������筮 �ࠢ !!!
  echo ����室��� ����᪠�� ��� 䠩� �ࠢ�� ������� ��� "�� ����� �����������".
  echo.
  echo ����訢�� �ਢ������ ...
  cscript.exe //nologo //e:jscript "%~fs0" "Admin"
  Exit /B
)

:Begin_Check
echo Y|chkdsk %SystemDrive% /f /r
cscript.exe //nologo //e:jscript "%~fs0" "Shedule"
shutdown -r -t 10
Exit /B

*/
  switch (WScript.Arguments(0)) {
      case "Admin": {
		new ActiveXObject('Shell.Application').ShellExecute (WScript.ScriptFullName,'Admin','','runas',1);
        break;
	  }
      case "Shedule": {
        var WSHShell = new ActiveXObject('WScript.Shell');
        var key = 'HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\RunOnce\\CheckDiskLog';
        WSHShell.RegWrite (key, 'cmd.exe /c start "" cmd.exe /c "' + WScript.ScriptFullName + '"', 'REG_SZ');
        break;
      }
  }