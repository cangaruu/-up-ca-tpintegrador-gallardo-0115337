#!/bin/bash

function mostrar_menu(){
    echo "1) Pedir un numero entero y mostrar esa cantidad de elemenos de la sucesion de Fibonacci"
    echo "2) Pedir un numero entero y mostrar por pantalla ese numero en forma invertida"
    echo "3) Pedir una cadena de caracteres y evaluar si es palindromo o no"
    echo "4) Pedir el path a un archivo de texto y mostrar por pantalla la cantidad de lineas que tiene"
    echo "5) Pedir el ingreso de 5 numeros enteros y mostrarlos por pantalla en forma ordenada"
    echo "6) Pedir el path a un directorio y mostrar por pantalla cuantos archivos de cada tipo contiene (No se tiene en cuenta ./ y ../)"
    echo "7) Salir"
    echo "-------------------------------------------------------------"
}

# ---------------------------- PROGRAMA PRINCIPAL ---------------------------- #
OPCION=0
mostrar_menu
while true; do
    read -p "Ingrese una opcion: " OPCION # Mensaje y read en la misma linea
    case $OPCION in
        1)  NUMERO=0
            read -p "Ingrese un numero: " NUMERO
            COMIENZO=0
	    CONSECUTIVO=1
	    echo "Sucesion Fibonacci: "
	    for (( i=0; i<NUMERO; i++ ))
	    do
	        echo -n "$COMIENZO "
	        ULTIMO=$((COMIENZO + CONSECUTIVO))
	        COMIENZO=$CONSECUTIVO
	        CONSECUTIVO=$ULTIMO
	    done
        ;;

        2)  read -p "Ingrese un numero a invertir: " n
	    echo $n | rev
	    ;;

        3)  LEN=0
	    I=1
	    read -p "Ingrese una cadena de caracteres: " STR
	    LEN=`echo $STR | wc -m`
	    LEN=`expr $LEN - 1`
	    if [ ! $LEN -eq 0 ]; then
	        MITAD=`expr $LEN / 2`
	        while [ $I -le $MITAD ]; do
	            C1=`echo $STR|cut -c$I`
	            C2=`echo $STR|cut -c$LEN`
	            if [ $C1 != $C2 ]; then
	                echo "La cadena no es capicua"
			echo "Adios $(whoami) !"
			exit
	            fi
	            I=`expr $I + 1`
	            LEN=`expr $LEN - 1`
	        done
	        echo "La cadena es capicua"
	    else
	        echo "ERROR: La cadena ingresada es incorrecta"
	    fi;;


        4)  archivo_texto=""
	    read -p "Ingrese el path al archivo de texto: " archivo_texto
	    if test -d $archivo_texto; then
	        echo "$archivo_texto es un directorio, no se pueden determinar lineas."
	    elif test -f $archivo_texto; then
	        echo "$archivo_texto es un archivo"
		echo "La cantidad de lineas es: "
		cat $archivo_texto | wc -l
	    else
	        echo "$archivo_texto no existe"
	    fi;;


        5)  read -p "Ingrese el primer numero: " n1
	    read -p "Ingrese el segundo numero: " n2
	    read -p "Ingrese el tercer numero: " n3
	    read -p "Ingrese el cuarto numero: " n4
	    read -p "Ingrese el quinto numero: " n5
	    echo "Ordenando"
	    echo -e "$n1\n$n2\n$n3\n$n4\n$n5" | sort -n
	    ;;
	6)
	    directorio=""
            read -p "Ingrese el path del directorio: " directorio
            if test -d $directorio; then
                echo "$directorio es un directorio"
		echo "Cantidad de archivos en $directorio : "
	        ls -l $directorio | egrep -c '^-'
		echo "Cantidad de directorios en $directorio : "
		ls -l | egrep -c '^d'
		echo "Cantidad de archivos de tipo 'Link': "
		ls -l | egrep -c '^l'
		echo "Cantidad de dispositivos de bloque: "
		ls -l | egrep -c '^b'
		echo "Cantidad de dispositivos de caracteres: "
		ls -l | egrep -c '^c'
		echo "Cantidad de archivos de tipo 'pipe':"
		ls -l | egrep -c '^p'
		echo "Cantidad de archivos de tipo 'socket': "
		ls -l | egrep -c '^s'

            elif test -f $directorio; then
                echo "$directorio es un archivo, no un directorio"
            else
                echo "$archivo_texto no existe"
            fi;;

	7) echo "Adios $(whoami) !";;
        *) echo "Opcion incorrecta";;
    esac
done
exit 0
