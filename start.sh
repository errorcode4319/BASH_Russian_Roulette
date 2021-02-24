#!/bin/sh

if [ $EUID != 0 ]; then 
	echo -e "This must be run by root\ntry \"sudo sh start.sh\"";
	exit;
fi

echo "### Select your language ###";
echo -e "\n### 1. English\n### 2. 한국어\n";

while [ -z $LangSet ]; do
	read -p ">> " InputLang;
	case $InputLang in 
		1 | E | En | en | e | Engilsh | english)
			source ./en.sh;
			LangSet=true;;
		2 | K | Ko | ko | k | Korean | korean)
			source ./ko.sh;
			LangSet=true;;
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
		read -p ">> " InputSelCham;
		r=${InputSelCham#-}
		r=${InputSelCham//[0-9]/};
	
		if [ -z "$r" ]; then 
			break;
		fi
	done
	
	ChamNum=$InputSelCham;
	echo -e $SelComm;
	read -p ">> " InputSelComm;
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
	read -p ">> " InputMag;
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
