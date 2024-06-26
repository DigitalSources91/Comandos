@ECHO OFF

:MENU
ECHO.
ECHO .....................................
ECHO ESCOJA UNA DE LAS SIGUIENTES OPCIONES
ECHO .....................................
ECHO.
ECHO 1 - Conectarse a un equipo remoto
ECHO 2 - EXIT
ECHO.

SET /P M=Escoja un opcion, Luego presione ENTER:

IF %M%==1 GOTO :ADDR
IF %M%==2 GOTO :EOF


:ADDR
ECHO .......................................................
ECHO ESCRIBA LA DIRECCIÓN IP DEL EQUIPO QUE DESEA CONECTARSE
ECHO .......................................................
ECHO.

SET /P IP=Escriba, Luego presione ENTER:

GOTO :DEF

GOTO :EOF

:DEF
	CALL :CON "administrador" "Contraseña" "cmd.exe"
	

:CON
	set args=-Command C:\pstools\psexec.exe \\%IP%  -u %~1 -p %~2 -s %~3
	PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process powershell -ArgumentList '%args%' -Wait -PassThru}"
	GOTO :MENU

:EOF
exit