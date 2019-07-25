#! /bin/bash

#Encontrar installation manager 

sep="###########################################"

hn=$(hostname)
hostName="$hn"

ip=$(hostname -I | awk '{print $1}')
ipadd="$ip"

cmd1=$(locate --basename '\AppServer')
cmd2=$(locate --basename '\Appserver')

ruta1="$cmd1"
ruta2="$cmd2"

#Usuario actual y doc temporal
u=$(whoami)
userL="$u"

dtemp="/home/$userL/temp.txt"

#Solicitar usuario y contraseña de WAS
echo ""
echo "Iniciando recoleccion de datos"
echo ""
#echo $sep

echo "$sep">> $dtemp
echo "Nombre del servidor: $hostName">> $dtemp
echo "">> $dtemp

echo "$sep">> $dtemp
echo "IP del servidor: $ipadd">> $dtemp
echo "">> $dtemp
echo "$sep">> $dtemp

#read -p "Introduce el usuario de WAS de este servidor: " userWAS
#read -p "Introduce la contraseña de WAS de este servidor: " passWAS

######################################

r01=$(pwd)
r02="$r01"
array01=($(cat $r02/datos.txt))

usWAS="${array01[0]}"
uWAS="$usWAS"
paWAS="${array01[1]}"
pWAS="$paWAS"

######################################

echo $sep

if [ -d $ruta1 ]; then 

	echo ""

	echo "La ruta de WAS es: $ruta1">> $dtemp
	
	echo "">> $dtemp

	cmd_01=$($ruta1/bin/versionInfo.sh)
	
	echo $sep>> $dtemp
	echo "Informacion de intalacion de WAS">> $dtemp
	echo $sep>> $dtemp
	echo "">> $dtemp
	
	echo "$cmd_01">> $dtemp

	cmd_02=$($ruta1/bin/manageprofiles.sh -listProfiles)
	
	echo "">> $dtemp
	echo $sep>> $dtemp
	echo "Lista de los perfiles instalados en el servidor">> $dtemp
	echo $sep>> $dtemp
	echo "">> $dtemp
	
	echo "$cmd_02">> $dtemp
	
	#cmd_03=$(ls $ruta1/profiles)
	#cmd_04=$(cat $cmd_03/logs/AboutThisProfile.txt)

	array_01=($(ls $ruta1/profiles))
	
	echo "">> $dtemp
	echo $sep>> $dtemp
	echo "Acerca de los perfiles">> $dtemp
	echo $sep>> $dtemp
	echo "">> $dtemp
	
	for i in ${array_01[@]}; do 

		echo $i>> $dtemp
		cat $ruta1/profiles/$i/logs/AboutThisProfile.txt>> $dtemp
		echo "">> $dtemp	

	 	#n=n+1
	done
	#echo "$cmd_04"

	echo "">> $dtemp
	echo $sep>> $dtemp
	echo "Acerca de las aplicaciones">> $dtemp
	echo $sep>> $dtemp
	echo "">> $dtemp

	profile="${array_01[0]}"

	#Informacion de las aplicaciones
	#$ruta1/profiles/$profile/bin/wsadmin.sh -lang jython -user $userWAS -password $passWAS -f /home/$userL/media/script.py>> $dtemp
	$ruta1/profiles/$profile/bin/wsadmin.sh -lang jython -user $uWAS -password $pWAS -f /home/$userL/media/infoApp.py>> $dtemp

	#Contar numero de aplicaciones
	echo "">> $dtemp
	rt=$(whoami)
	rt1="/home/$rt"
	appTemp="$rt1/file.txt"
	
	$ruta1/profiles/$profile/bin/wsadmin.sh -lang jython -user $uWAS -password $pWAS -c 'print AdminApp.list()'> $appTemp
	
	mapfile -t array_03 < $appTemp

	let numApp=${#array_03[@]}-1
	echo $sep>> $dtemp
	echo "Numero de aplicaciones instaladas: $numApp">> $dtemp
	rm $appTemp

	#informacion de los servidores
	echo "">> $dtemp
	echo $sep>> $dtemp
	echo "Acerca de los Websphere Application Servers">> $dtemp
	echo $sep>> $dtemp
	echo "">> $dtemp
	
	#$ruta1/profiles/$profile/bin/wsadmin.sh -lang jython -user $userWAS -password $passWAS -f /home/$userL/media/jvm.py>> $dtemp
	$ruta1/profiles/$profile/bin/wsadmin.sh -lang jython -user $uWAS -password $pWAS -f /home/$userL/media/infoServ.py>> $dtemp

	nCpu=$(grep -c ^processor /proc/cpuinfo)
	numcpu="$nCpu"
	echo "">> $dtemp
	echo $sep>> $dtemp
	echo "Numero de CPU's del servidor: $numcpu">> $dtemp
	
	echo "">> $dtemp
	echo $sep>> $dtemp
	let mem=$(grep MemTotal /proc/meminfo | awk '{print $2}')
	let ram=mem/1000
	
	echo "Memoria RAM del servidor: $ram MB">> $dtemp 

	echo "">> $dtemp

	echo "La recoleccion se ha completado"
	echo ""
	
	#read -p "Nombre del archivo: " nameFile
	
	rutaFile="/home/$userL/test/$hostName.txt"
	echo "">> $rutaFile
	cat $dtemp>> $rutaFile
	
	echo "El archivo se guardo en $rutaFile"
	
	rm $dtemp


#En caso de no ser la primera opcion	
elif [ -d $ruta2 ]; then 
	
	echo "La ruta de WAS es: $ruta2">> $dtemp

	echo "">> $dtemp

	cmd_01=$($ruta2/bin/versionInfo.sh)
	
	echo $sep>> $dtemp
	echo "Informacion de intalacion de WAS">> $dtemp
	echo $sep>> $dtemp
	echo "">> $dtemp
	
	echo "$cmd_01">> $dtemp

	cmd_02=$($ruta2/bin/manageprofiles.sh -listProfiles)
	
	echo "">> $dtemp
	echo $sep>> $dtemp
	echo "Lista de los perfiles instalados en el servidor">> $dtemp
	echo $sep>> $dtemp
	echo "">> $dtemp
	
	echo "$cmd_02">> $dtemp
	
	#cmd_03=$(ls $ruta1/profiles)
	#cmd_04=$(cat $cmd_03/logs/AboutThisProfile.txt)

	array_01=($(ls $ruta2/profiles))
	
	echo "">> $dtemp
	echo $sep>> $dtemp
	echo "Acerca de los perfiles">> $dtemp
	echo $sep>> $dtemp
	echo "">> $dtemp
	
	for i in ${array_01[@]}; do 

		echo $i>> $dtemp
		cat $ruta2/profiles/$i/logs/AboutThisProfile.txt>> $dtemp
		echo "">> $dtemp	

	 	#n=n+1
	done
	#echo "$cmd_04"

	echo "">> $dtemp
	echo $sep>> $dtemp
	echo "Acerca de las aplicaciones">> $dtemp
	echo $sep>> $dtemp
	echo "">> $dtemp

	profile="${array_01[0]}"

	#Informacion de las aplicaciones
	#$ruta1/profiles/$profile/bin/wsadmin.sh -lang jython -user $userWAS -password $passWAS -f /home/$userL/media/script.py>> $dtemp
	$ruta2/profiles/$profile/bin/wsadmin.sh -lang jython -user $uWAS -password $pWAS -f /home/$userL/media/infoApp.py>> $dtemp

	#Contar numero de aplicaciones
	echo "">> $dtemp
	rt=$(whoami)
	rt1="/home/$rt"
	appTemp="$rt1/file.txt"
	
	$ruta2/profiles/$profile/bin/wsadmin.sh -lang jython -user $uWAS -password $pWAS -c 'print AdminApp.list()'> $appTemp
	
	mapfile -t array_03 < $appTemp

	let numApp=${#array_03[@]}-1
	echo $sep>> $dtemp
	echo "Numero de aplicaciones instaladas: $numApp">> $dtemp
	rm $appTemp

	#informacion de los servidores
	echo "">> $dtemp
	echo $sep>> $dtemp
	echo "Acerca de los Websphere Application Servers">> $dtemp
	echo $sep>> $dtemp
	echo "">> $dtemp
	
	#$ruta1/profiles/$profile/bin/wsadmin.sh -lang jython -user $userWAS -password $passWAS -f /home/$userL/media/jvm.py>> $dtemp
	$ruta2/profiles/$profile/bin/wsadmin.sh -lang jython -user $uWAS -password $pWAS -f /home/$userL/media/infoServ.py>> $dtemp

	nCpu=$(grep -c ^processor /proc/cpuinfo)
	numcpu="$nCpu"
	echo "">> $dtemp
	echo $sep>> $dtemp
	echo "Numero de CPU's del servidor: $numcpu">> $dtemp
	
	echo "">> $dtemp
	echo $sep>> $dtemp
	let mem=$(grep MemTotal /proc/meminfo | awk '{print $2}')
	let ram=mem/1000
	
	echo "Memoria RAM del servidor: $ram MB">> $dtemp 

	echo "">> $dtemp

	echo "La recoleccion se ha completado"
	echo ""
	
	#read -p "Nombre del archivo: " nameFile
	
	rutaFile="/home/$userL/test/$hostName.txt"
	echo "">> $rutaFile
	cat $dtemp>> $rutaFile
	
	echo "El archivo se guardo en $rutaFile"
	
	rm $dtemp

else 
	
	"No hay una instalacion de WAS en el servidor"

fi 
	
	echo ""
	echo $sep
	echo ""
	echo "Listo"
