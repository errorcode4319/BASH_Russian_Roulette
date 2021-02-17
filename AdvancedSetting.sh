#!/bin/sh

source ./check.sh;
echo -e $SelCham;

while [ 1 ] 
do
	read InputSelCham;
	r=${InputSelCham#-}
	r=${InputSelCham//[0-9]/};
	
	if [ -z "$r" ] 
	then 
		break;
	fi
done
	

ChamNum=$InputSelCham;

echo -e $SelComm;
read InputSelComm;

echo -e $GameStart;

BulletPos=$(($RANDOM% $ChamNum));
i=0;

while [ $i -le `expr $ChamNum - 1` ] 
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
				$InputSelComm;
				exit;
			else 
				echo $BulletNotFired
			fi
			i=$(($i+1));
        esac
done
