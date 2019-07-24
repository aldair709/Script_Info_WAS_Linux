#! /bin/bash

#Encontrar installation manager 

sep="###########################################"

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

	#$ruta1/profiles/$profile/bin/wsadmin.sh -lang jython -user $userWAS -password $passWAS -f /home/$userL/media/script.py>> $dtemp
	$ruta1/profiles/$profile/bin/wsadmin.sh -lang jython -user $uWAS -password $pWAS -f /home/$userL/media/script.py>> $dtemp

	echo "">> $dtemp
	echo $sep>> $dtemp
	echo "Acerca de los Websphere Application Servers">> $dtemp
	echo $sep>> $dtemp
	echo "">> $dtemp
	
	#$ruta1/profiles/$profile/bin/wsadmin.sh -lang jython -user $userWAS -password $passWAS -f /home/$userL/media/jvm.py>> $dtemp
	$ruta1/profiles/$profile/bin/wsadmin.sh -lang jython -user $uWAS -password $pWAS -f /home/$userL/media/jvm.py>> $dtemp

	echo "La recoleccion se ha completado"
	echo ""
	
	read -p "Nombre del archivo: " nameFile
	
	rutaFile="/home/$userL/$nameFile.txt"
	echo "">> $rutaFile
	cat $dtemp>> $rutaFile
	
	echo "El archivo se guardo en $rutaFile"
	
	rm $dtemp


#En caso de no ser la primera opcion	
elif [ -d $ruta2 ]; then 
	
	echo "La ruta de WAS es: $ruta2"

else 
	
	"No hay una instalacion de WAS en el servidor"

fi 
	
	echo ""
	echo $sep
	echo ""
	echo "Listo"

#echo $cmd1
