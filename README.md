# Comandos
Este repositorio tiene el contenido de los comandos y scripts utilizados en el video: Guía Completa de Linea de Comandos en Windows: Desde Principiantes a Expertos.

La importancia de conocer la línea de comandos hoy en día, puede marcarle diferencia entre un usuario estándar y un experto informático. Ya que nos pueden agilizar nuestro trabajo día a día incluso con automatizaciones, ya que de él nace el inicio de la programación. Sin duda hasta nos puede ayudar a iniciar en un lenguaje de programación para proyectos personales.
¿ Cuáles de estos comandos utilizas en tu día a día ?

Nota: Los siguientes 15 grupos de comandos son facilitados para la comunidad con proposito de laboratorio y estudio,
Ejecutar con discresion y sin afectar la seguridad e integridad de ningun individuo, para propositos no eticos.


1) **comando execute**

control
control printers
msconfig
msinfo32
netplwiz
ncpa.cpl
appwiz.cpl
mstsc.exe
regedit.exe
lusrmgr.msc
diskmgmt.msc
compmgmt.msc
eventvwr.msc
services.msc
firefox.exe
chrome.exe
winword.exe
excel.exe
outlook.exe
powerpnt.exe

--------------------------------------------------

2) **Información del equipo**

//--Obtener informacion del CPU en PowerShell--//

wmic cpu get caption,deviceid,name,numberofcores,maxclockspeed,status

*//--Obtener informacion del mainboard en PowerShell--//*

wmic baseboard get product,Manufacturer,version,serialnumber,model,name

*//--Obtener informacion de la memoria en PowerShell--//*

wmic memorychip get devicelocator,Manufacturer,partnumber,capacity,speed,memorytype,formfactor

*//--Obtener informacion del disco duro en PowerShell--//*

diskpart
list volume

wmic diskdrive get model,serialNumber,size,mediaType 

wmic logicaldisk get size,freespace,caption

*//--Obtener Lista de programas instalados--//*

wmic product get name,version,vendor

*//--Obtener Microsoft Windows Key--//*

wmic path softwarelicensingservice get OA3xOriginalProductKey

*//--Obtener Lista de impresoras instalados--//*

wmic printer list brief,serialNumber

--------------------------------------------------

3) **Impresoras**

//--Obtener lista de impresoras desde CMD--//

powershell -command " Get-printer | Format-Table "

*//--Establecer impresora predeterminada desde CMD--//*

wmic printer where name="Nombre_impresora" call setdefualtprinter 

*//--Imprimir archivo desde CMD a impresora compartida--//*

print /d:\\%COMPUTERNAME%\"epson l355 Series" C:\Users\Usuario\Documents\archivo.txt

*//--Drivers Almacenados en el equipo--//*

printui.exe /s /t2

*//--Permitir compartir impresora USB--//*

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print" /v RpcAuthnLevelPrivacyEnabled /t REG_DWORD /d 0 /f 

--------------------------------------------------

4) **Punto de restauración**

//--Realizar punto de restauracion en CMD--//

wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Restore-Point", 100, 7

*//--Restaurar desde punto restauracion--//*

rstrui.exe

--------------------------------------------------

5) **Variables de entorno**

//--Mostrar Variables de entorno--//

set (muestra variables de entorno)

//--Crear variables de entorno--//

setx TMP "%USERPROFILE%\AppData\Local\Temp"
setx TEMP "%USERPROFILE%\AppData\Local\Temp"

--------------------------------------------------

6) **Procesos**

//--Listar Procesos/Tareas--//

tasklist

tasklist -?

*//--Filtrar Procesos/Tareas--//*

tasklist /fi "PID eq ####"

tasklist /fi "IMAGENAME eq winword.exe"

*//--Matar Procesos/Tareas--//*

taskkill /PID #### /F

taskkill /im winword.exe /f

---------------------------------------------------------------------------------------

7) **Busqueda de archivos**

//--Buscar archivos <nombre>.<formato> en unidad--//

C: (Cambia la ubicación a la ruta raiz de la unidad C)
dir /b/s *.pst
dir /b/s <nombre>.pdf

*//--Conectar unidad de red--//*

net use z: \\192.168.0.1-254\InfoEquipo <Contraseña> /user:192.168.0.1-254\administrador /PERSISTENT:YES

*//--Enviar a destino rtemoto--//*

xcopy ".\*.pst" "z:" /F /S

*//--Eliminar unidad asignada a destino rtemoto--//*

net use z: /delete

---------------------------------------------------------------------------------------

8) **SSH**

//--Conexione SSH <IP-LAN>--//

ssh administrador@192.168.0.1-254

--------------------------------------------------

9) **PStools**

//--Establecer conexion por consola--//

& C:\pstools\psexec.exe \\192.168.0.xxx -u <usuario> -p <contraeña> -s cmd.exe

& C:\pstools\psexec.exe \\192.168.0.xxx -u <usuario> -p <contraeña> -s powershell.exe

--------------------------------------------------

10) **;itigar errores de conexión en PStools**

//--Habilitar acceso remoto por consola a un equipo--//

sc config RemoteRegistry start= auto

net start remoteregistry

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v DenyTSConnections /t REG_DWORD /d 0 /f 

*//--Mitigar errores acceso denegado equipo remoto--//*

reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\system /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f

netsh advfirewall set allprofiles state off

net use \\127.0.0.1\Admin$ /user:administrador <Contraseña>

---------------------------------------------------------------------------------------

11) **Administrar servicios por consola**


=====/**/WINDOWS UPDATE SERVICE/**/=======


*//--Consultar desde powershell--//*

powershell -command " Get-Service wuauserv | Select-Object -Property Name, StartType, Status "

*//--Detener desde powershell--//*

powershell -command " Set-Service -Name wuauserv -StartupType Manual -Status Running "

net stop wuauserv

powershell -command " Set-Service -Name wuauserv -StartupType Disabled -Status Stopped "

*//--Iniciar desde powershell--//*

powershell -command " Set-Service -Name Spooler -StartupType Automatic -Status Running "

--------------------------------------------------------------------------------------------

======/**/SPOOLER SERVICE/**/=======


*//--Consultar desde powershell--//*

powershell -command " Get-Service Spooler | Select-Object -Property Name, StartType, Status "

*//--Detener desde powershell--//*

powershell -command " Set-Service -Name Spooler -StartupType Manual -Status Running "

tasklist /fi "IMAGENAME eq Spool*"

taskkill /im Spool* /f

powershell -command " Set-Service -Name Spooler -StartupType Disabled -Status Stopped "

*//--Iniciar desde powershell--//*

powershell -command " Set-Service -Name Spooler -StartupType Automatic -Status Running "


---------------------------------------------------------------------------------------

12) **Exportar Servicios a archivo  CSV**

Get-WmiObject Win32_service | select Name, DisplayName, State, PathName | export-csv -path "%USERPROFILE%\Documents\services.csv"

--------------------------------------------------

13) **Habilitar comandos de Linux en PowerShell**

Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux

DISM.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

DISM.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

--------------------------------------------------

14) **En caso de error de Windows Update**

net stop wuauserv

net stop cryptSvc

net stop bits

net stop msiserver

ren C:\Windows\SoftwareDistribution SoftwareDistribution.old

ren C:\Windows\System32\catroot2 catroot2.old

net start wuauserv

net start cryptSvc

net start bits

net start msiserver

--------------------------------------------------

15) **Recuperar desctores dañados del disco**

*//--Escaneo y repación de sectores dañados--//*

chkdsk /f /s /x

sfc /scannow

*//--Recuperar instancias de driver si el S.O. Prsenta Fallas--//*

DISM.exe /Online /Cleanup-image /CheckHealth

DISM.exe /Online /Cleanup-image /ScanHealth

DISM.exe /Online /Cleanup-image /RestoreHealth
