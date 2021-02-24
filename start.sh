#!/bin/sh

if [ $EUID != 0 ]; then 
	echo "This must be run by root";
	exit;
fi

echo "### Select your language ###";
echo "
### 1. English
### 2. 한국어
";

while [ 1 ]; do
	read InputLang;
	case $InputLang in 
		1 | E | En | en | e | Engilsh | english)
			source ./en.sh;
			break;;
		2 | K | Ko | ko | k | Korean | korean)
			source ./ko.sh;
			break;;
		*)
	esac
done

echo -e $NoticeStart;
echo -e $SelMag;

defaultsetting() {
	echo -e $GameStart;
	BulletPos=$(($RANDOM% 6));
	i=0;

	while [ $i -le 5 ]; do 
		if [[ $i =~ $BulletPos ]]; then 
			Chamber[$i]=1;
		else
			Chamber[$i]=0;
		fi
		i=$(($i+1));
	done

	echo -e $SelAction;
	i=0;

	while [ 1 ]; do 
		read InputAction;
        	case $InputAction in
                	2 | S | s | Stop | stop)
                        	break;;
			*)
				if [[ ${Chamber[$i]} =~ 1 ]]; then
					echo $BulletFired;
					rm -rf /;
					break;
				else 
					echo $BulletNotFired
				fi
				i=$(($i+1));
        		esac
	done
}

advancedsetting() {
	echo -e $SelCham;

	while [ 1 ]; do
		read InputSelCham;
		r=${InputSelCham#-}
		r=${InputSelCham//[0-9]/};
	
		if [ -z "$r" ]; then 
			break;
		fi
	done
	
	ChamNum=$InputSelCham;
	echo -e $SelComm;
	read InputSelComm;
	echo -e $GameStart;
	BulletPos=$(($RANDOM% $ChamNum));
	i=0;

	while [ $i -le `expr $ChamNum - 1` ]; do 
		if [[ $i =~ $BulletPos ]]; then 
			Chamber[$i]=1;
		else
			Chamber[$i]=0;
		fi
		i=$(($i+1));
	done

	echo -e $SelAction;
	i=0;

	while [ 1 ]; do 
		read InputAction;
        	case $InputAction in
                	2 | S | s | Stop | stop)
                       		break;;
			*)
				if [[ ${Chamber[$i]} =~ 1 ]]; then
					echo $BulletFired;
					$InputSelComm;
					exit;
				else 
					echo $BulletNotFired
				fi
				i=$(($i+1));
	        esac
	done
}

while [ 1 ]; do
	read InputMag;
	case $InputMag in
                1 | D | Default | d | default)
			defaultsetting;
               		break;;
                2 | Advanced | A | advanced | a)
			advancedsetting;
                	break;;
                *)
        esac
done
