$COMP= cmd.exe /c wmic computersystem get Name
$IP= cmd.exe /c wmic nicconfig get index,caption,ipaddress
$OS= cmd.exe /c wmic os get Caption
$CPU= cmd.exe /c wmic cpu get caption,deviceid,name,numberofcores,maxclockspeed,status
$MB= cmd.exe /c wmic baseboard get product,Manufacturer,version,serialnumber,model,name
$MEM= cmd.exe /c wmic memorychip get devicelocator,Manufacturer,partnumber,capacity,speed,memorytype,formfactor
$DSK1= cmd.exe /c wmic diskdrive get model,serialNumber,size,mediaType
$DSK2= cmd.exe /c wmic logicaldisk get size,freespace,caption
$PROG= cmd.exe /c wmic product get name,version,vendor
$Content = $COMP + $IP + $OS + $CPU + $MB + $MEM + $DSK1 + $DSK2 + $PROG
$NAME= (Get-CimInstance -ClassName Win32_ComputerSystem).Name

Add-Content -Path C:\Temp\$NAME-Info.txt -Value ($Content)