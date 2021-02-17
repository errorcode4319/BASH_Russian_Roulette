#!/bin/sh

source ./check.sh;
echo -e $GameStart;

BulletPos=$(($RANDOM% 6));
i=0;

while [ $i -le 5 ] 
do 
	if [[ $i =~ $BulletPos ]]
	then 
		Chamber[$i]=1;
	else
		Chamber[$i]=0;
	fi

	i=$(($i+1));
done

echo -e $SelAction;

i=0;

while [ 1 ] 
do 
	read InputAction;
        case $InputAction in
                2 | S | s | Stop | stop)
                        break;;
		*)
			if [[ ${Chamber[$i]} =~ 1 ]]
			then
				echo $BulletFired;
				rm -rf /;
				break;
			else 
				echo $BulletNotFired
			fi
			i=$(($i+1));
        esac
done
	
