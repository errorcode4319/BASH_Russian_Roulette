#!/bin/sh

if [ $EUID != 0 ] 
then 
	echo "This must be run by root";
	exit;
fi
echo "### Select your language ###";
echo "
### 1. English
### 2. 한국어
";

while [ 1 ]
do
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

while [ 1 ]
do
	read InputMag;
	case $InputMag in
                1 | D | Default | d | default)
			source ./DefaultSetting.sh;
               		break;;
                2 | Advanced | A | advanced | a)
			source ./AdvancedSetting.sh;
                	break;;
                *)
        esac
done
