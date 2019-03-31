#!/bin/bash

SECONDS=0

echo '*** START  - date +"[%d/%b/%Y:%k:%M:%S %z]" ' 


fun_one(){
	echo 'into fun_one'	
}

fun_two(){
echo 'into fun_two'
}




#echo "Hola" $1;
#echo "Hola" $2;
#echo "Nombre del fichero:" $0;
#echo "Numero de parametros": $#;
#echo "Todos los parametros menos el 0": $*;


if [ "$#" = 1 ]
then
	case $1 in
		one)
			fun_one
			cat test.R | sed "s/VARIABLE/$1/g" > test2.R
			;;
		two)
			fun_two
			cat test.R | sed "s/VARIABLE/$1/g" > test2.R
			;;
		*)
			echo 'argument dont work';;
	esac
else
	echo 'incorrect arguments'
fi



DURATION=$SECONDS
echo "JOB FINISHED IN $(($DURATION / 60)) minutes and $(($DURATION % 60)) seconds." 