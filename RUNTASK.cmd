@ECHO OFF

:MENU
ECHO.
ECHO ...................................................................
ECHO PRESIONE 1, 2, 3, 4, 5, 6, 7 para ejecutar una tarea, 8 para SALIR.
ECHO ...................................................................
ECHO.
ECHO 1 - Eliminar Archivo Temporales
ECHO 2 - Reiniciar Servicios de Impresora / Share Print
ECHO 3 - Detener Servicios de Windows Update
ECHO 4 - Iniciar Servicios de Windows Update
ECHO 5 - Liberar direccion IP / Obtener nueva IP
ECHO 6 - Establecer red en DHCP
ECHO 7 - Establecer red con parametros estaticos
ECHO 8 - EXIT
ECHO.

SET /P M=Escoja 1, 2, 3, 4, 5, 6, 7, 8 Luego presione ENTER:
IF %M%==1 GOTO SPEED
IF %M%==2 GOTO SPOLL
IF %M%==3 GOTO WUSTOP
IF %M%==4 GOTO WUSTART
IF %M%==5 GOTO LIBIP
IF %M%==6 GOTO DHCP
IF %M%==7 GOTO STATIC
IF %M%==8 GOTO EOF

:SPEED
del /s /f /q c:\windows\temp\*.*
rd /s /q c:\windows\temp
md c:\windows\temp
del /s /f /q C:\WINDOWS\Prefetch
del /s /f /q %temp%\*.*
rd /s /q %temp%
md %temp%
deltree /y c:\windows\tempor~1
deltree /y c:\windows\temp
deltree /y c:\windows\tmp
deltree /y c:\windows\ff*.tmp
deltree /y c:\windows\prefetch
deltree /y c:\windows\history
deltree /y c:\windows\cookies
deltree /y c:\windows\recent
deltree /y c:\windows\spool\printers
CLS
GOTO MENU

:SPOLL
reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled
IF %errorlevel%==0 (
GOTO RUN
) ELSE (
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f 
GOTO RUN
)

:RUN
powershell -executionpolicy remotesigned -Command "& {Set-Service -Name Spooler -StartupType Manual -Status Running; taskkill /im Spool* /f; Set-Service -Name Spooler -StartupType Manual -Status Stopped; Get-Service Spooler | Select-Object -Property Name, StartType, Status; Set-Service -Name Spooler -StartupType Automatic -Status Running; Get-Service Spooler | Select-Object -Property Name, StartType, Status}"
CLS
GOTO MENU

:WUSTOP
echo ......................................................
echo Seleccione el Index de la tarjeta de red a configurar:
echo ......................................................
wmic nicconfig get Index,IPAddress,description,macaddress
set /p IND=Ingrese el numero del Index:
WMIC NICCONFIG WHERE Index=%IND% CALL EnableDHCP
powershell -executionpolicy remotesigned -Command "& {Set-Service -Name wuauserv -StartupType Manual -Status Running; net stop wuauserv; Set-Service -Name wuauserv -StartupType Disabled -Status Stopped}"
CLS
GOTO MENU

:WUSTART
echo ......................................................
echo Seleccione el Index de la tarjeta de red a configurar:
echo ......................................................
wmic nicconfig get Index,IPAddress,description,macaddress
set /p IND=Ingrese el numero del Index:
WMIC NICCONFIG WHERE Index=%IND% CALL EnableStatic ("192.168.0.98"),("255.255.255.0")
WMIC NICCONFIG WHERE Index=%IND% CALL SetGateways ("192.168.0.100"),(1)
WMIC NICCONFIG WHERE Index=%IND% CALL SetDNSServerSearchOrder ("186.5.11.4","186.5.56.4")
powershell -executionpolicy remotesigned -Command "& {net start wuauserv; Set-Service -Name wuauserv -StartupType Manual -Status Running; Set-Service -Name wuauserv -StartupType Automatic -Status Running}"
CLS
GOTO MENU

:LIBIP
ipconfig/release
ipconfig/flushdns
ipconfig/renew
ipconfig/registerdns
ipconfig/all
CLS
GOTO MENU

:DHCP
WMIC NICCONFIG GET index,description,IPAddress
SET /P D=Escoja una interfaz del listado. Luego presione ENTER:
WMIC NICCONFIG WHERE Index=%D% CALL EnableDHCP
ipconfig/all
CLS
GOTO MENU

:STATIC
echo ......................................................
echo Seleccione el Index de la tarjeta de red a configurar:
echo ......................................................
wmic nicconfig get Index,IPAddress,description,macaddress
set /p IND=Ingrese el numero del Index:
cls
echo ........................................................................................
echo Ingrese los siguientes datos para la configuracion de la tarjeta de red con Index %IND%:
echo ........................................................................................
set /p IP=Ingrese la direccion IP:
set /p MSK=Ingrese la mascara de subred:
set /p GTW=Ingrese la puerta de enlace:
set /p DNSP=Ingrese el DNS primario:
set /p DNSS=Ingrese el DNS secundario:
cls
echo .................................................
echo Configurando la tarjeta de red con Index %IND%...
echo .................................................
wmic nicconfig where Index=%IND% CALL EnableStatic %IP%,%MSK%
wmic nicconfig where Index=%IND% CALL SetGateways %GTW%,1
wmic nicconfig where Index=%IND% CALL SetDNSServerSearchOrder %DNSP%,%DNSS%
echo .................................................................................
echo La tarjeta de red con Index %IND% ha sido configurada con los siguientes valores:
echo .................................................................................
wmic nicconfig where Index=%IND% GET IPAddress,IPSubnet,DNSServerSearchOrder,GatewayCostMetric
pause
GOTO MENU

:EOF
exit