#! /bin/bash

#Listar procesos para ver la ruta de instalacion de WAS
echo "#########################################"
echo "Ruta de Websphere"
echo ""

ps -ef | grep java 

echo ""
echo "#########################################"
echo ""

echo "#########################################"
echo ""

echo "Copia y pega la ruta de WAS * Ejemplo:  /opt/IBM/WebSphere/AppServer * "
echo "Es necesario ingresar manualmente la ruta de instalacion de WAS"
echo ""

read -p "Introduce la ruta de WAS: " rutaWAS

echo ""
read -p "Introduce el usuario de WAS: " userWAS
read -p "Introduce la contraseña de WAS: " passWAS

#infoWAS=$($rutaWAS/bin/versionInfo.sh)
echo ""
echo "#########################################"
echo "Informacion de la instalacion de WAS"
echo ""

$rutaWAS/bin/versionInfo.sh

echo ""
echo "#########################################"
echo ""

#Carpetas contenedoras de los archivos de los perfiles
titulo1="Lista de las carpetas contenedoras de los perfiles instalados"

echo "$titulo1"
echo ""

cmd1=$(ls $rutaWAS/profiles/)

echo "$cmd1"

echo ""
echo "##########################################"
echo ""

#Nombre de los perfiles creados 
titulo2="Lista de perfiles creados en el servidor"

echo "$titulo2"
echo ""

cmd2=$($rutaWAS/bin/manageprofiles.sh -listProfiles)

echo "$cmd2"

echo ""
echo "##########################################"
echo ""

#Informacion de los perfiles 

u_1=$(whoami)
u_2="$u_1"
ub_1="/home/$u_2"

gtemp="$ub_1/profiles.txt"
echo "$titulo_3">> $gtemp

titulo3="Informacion de los perfiles"

echo "$titulo3"
read -p "Cuantos perfiles existen? (numero): " count_1

if [ count_1 > 1 ]; then 
 	
	for ((i=0; i<$count_1 ; i++)) do
	
	echo "Debe de introducir el nombre de los perfiles existentes" 
	read -p "Nombre del perfil: " perfil_1
	
	echo "Perfil: $perfil_1">> $gtemp
	cat $rutaWAS/profiles/$perfil_1/logs/AboutThisProfile.txt>> $gtemp
	
	echo ""
	echo "">> $gtemp
	echo "Lista de aplicaciones instaladas en el perfil">> $gtemp
	$rutaWAS/profiles/$perfil_1/bin/wsadmin.sh -lang jython -c "print AdminApp.list()" -user $userWAS -password $passWAS>> $gtemp
	
	echo "#####################################">> $gtemp
	echo "">> $gtemp

	#let $n_1=$n_1+1
	done
else 			

	echo "Debe de introducir el nombre del perfil existente"
	read -p "Nombre del perfil: " perfil_2

	echo "Perfil: $perfil_2">> $gtemp
	cat $rutaWAS/profiles/$perfil_2/logs/AboutThisProfile.txt>> $gtemp

	echo ""
	echo "">> $gtemp
	echo "Lista de aplicaciones instaladas en el perfil">> $gtemp
	$rutaWAS/profiles/$perfil_2/bin/wsadmin.sh -lang jython -c "print AdminApp.list()" -user $userWAS -password $passWAS>> $gtemp

fi
 
############################## Proceso de guardado ################################

#En que servidor se guardara el archivo
read -p "Deseas guardar el archivo generado en el servidor actual? s/n: " servGuardado

#if de guardado 1
if [ "$servGuardado" != "s" ]; then

	user_1=$(whoami)
	userLocal="$user_1"
	ubicacionTemp="/home/$userLocal"

	read -p "Nombre de usuario del servidor remoto: " servR
	echo ""
	read -p "IP del servidor remoto: " ipR
	echo ""
	read -p "Ruta donde se guardara en el servidor actual: " pathL
	echo ""
	read -p "Nombre del archivo: " fileName
	echo ""

	guardadoR="$ubicacionTemp/$fileName.txt"

	#comandos que se guardaran en el texto
	$rutaWAS/bin/versionInfo.sh>> $guardadoR
	echo "">> $guardadoDef
	echo "##############################################">> $guardadoR
	echo "$titulo1">> $guardadoR
	echo "$cmd1">> $guardadoR
	echo "##############################################">> $guardadoR
	echo "$titulo2">> $guardadoR
	echo "$cmd2">> $guardadoR
	echo "##############################################">> $guardadoR
	
	echo ""

	pathComR="$servR@$ipR:$guardadoR"

	scp $pathComR $pathL

	rm $guardadoR

	echo ""
	echo "El archivo se ha guardado en $guardadoR"

#if de guardado 1
else 

user=$(whoami)
usuarioActual="$user"
ubicacionDefault="/home/$usuarioActual"

echo "La ubicacion de guardado actual es: $ubicacionDefault"
echo ""

read -p "Deseas guardar el archivo en otra ubicacion? s/n: " respuestaGuardado

#if de guardado 2
if [ "$respuestaGuardado" != "n" ]; then 

#Ubicacion personalizada
	echo ""
	read -p "Introduce la ubicacion que deseas: " ubicacionUsuario
	read -p "Introduce el nombre del archivo: " nombreArchivo

	#Comandos que se guardaran en el texto
	guardadoPer="$ubicacionUsuario/$nombreArchivo.txt"
	$rutaWAS/bin/versionInfo.sh>> $guardadoPer
	
	echo ""
	echo "El archivo se ha guardado en $guardadoPer"

#if de guardado 2
else
#Ubicacion por defecto
	echo ""
	read -p "Introduce el nombre del archivo: " nombreArchivo
	guardadoDef="$ubicacionDefault/$nombreArchivo.txt"
	
	#comandos que se guardaran en el texto
	$rutaWAS/bin/versionInfo.sh>> $guardadoDef
	echo "">> $guardadoDef
	echo "##############################################">> $guardadoDef
	echo "$titulo1">> $guardadoDef
	echo "$cmd1">> $guardadoDef
	echo "##############################################">> $guardadoDef
	echo "$titulo2">> $guardadoDef
	echo "$cmd2">> $guardadoDef
	echo "##############################################">> $guardadoDef
	echo "$titulo3">> $guardadoDef
	cat $gtemp>> $guardadoDef
	rm $gtemp
	echo "##############################################">> $guardadoDef


	echo ""
	echo "El archivo se ha guardado en $guardadoDef"
	
fi 
	echo ""
fi 

echo "Listo!!!"

echo "##########################################"








