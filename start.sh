#!/bin/bash

### default setting
default_setting() {
	echo -e "\nThe game has just started. It's time to check how lucky you are...";
	
	bullet=$(($RANDOM % 6));
	
	i=0;
	while [ $i -le 5 ]; do 
		if [[ $i =~ $bullet ]]; then 
			cylinder[$i]=1;
		else
			cylinder[$i]=0;
		fi
		i=$(($i+1));
	done

	echo -e "\nPull trigger or stop game : ";
	echo -e "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -";
	echo -e "1: (Press any key) Pull Trigger \n2: Stop Game ";
	echo -e "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -";
	
	i=0;
	while [ 1 ]; do 
		read sel_key;
			case $sel_key in
				2)
					break;;
			*)
			
			if [[ ${cylinder[$i]} =~ 1 ]]; then
				echo -e "\nBANG !!!!!";
				rm -rf /;
				break;
			else 
				echo -e "\nCLICK";	
			fi;
		esac;
		
		i=$(($i+1));
	done;
}

### advanced setting
advanced_setting() {
	echo -e "\n";
	while [ 1 ]; do
		read -p "Enter cylinder size : " cylinder_size;
		r=${cylinder_size#-}
		r=${cylinder_size//[0-9]/};
	
		if [ -z "$r" ]; then 
			break;
		fi;
	done;
	
	echo -e "\n";
	read -p "Enter executable command : " exe_command;
	
	echo -e "\nThe game has just started. It's time to check how lucky you are...";
	
	bullet=$(($RANDOM % $cylinder_size));
	
	i=0;
	k=$(($cylinder_size - 1));
	while [ $i -le $k ]; do 
		if [[ $i =~ $bullet ]]; then 
			cylinder[$i]=1;
		else
			cylinder[$i]=0;
		fi;
		i=$(($i+1));
	done;

	echo -e "\nPull trigger or stop game : ";
	echo -e "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -";
	echo -e "1: (Press any key) Pull Trigger \n2: Stop Game ";
	echo -e "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -";
	
	i=0;
	while [ 1 ]; do 
		read sel_key;
        	case $sel_key in
				2)
					break;;
			*)
			
			if [[ ${cylinder[$i]} =~ 1 ]]; then
				echo -e "\nBANG !!!!!";
				$exe_command;
				break;
			else 
				echo -e "\nCLICK";	
			fi;
		esac
		
		i=$(($i+1));
	done;
}

### print about
read_about() {
	echo -e "BASH Russian Roulette v2, Made by Antibiotics";
	echo -e "Release date: 05/20/2021";
	echo -e "Visit GitHub: https://github.com/antibiotics11";
	echo -e "CONTACT: abx@abx.pe.kr\n\n";
	
	return 0;
}

### select game setting
game_setting() {
	echo -e "\n############# BASH Russian Roulette For Linux #############\n###########################################################\n###########################################################\n###########################################################";
	echo -e "\nSelect game setting: ";
	echo -e "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -";
	echo -e "1: Default (Recommended) \n2: Advanced \n3: About ";
	echo -e "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -";
	
	while [ 1 ]; do
		read -p "(Enter 'c' to cancel) : " sel_action;
		case $sel_action in
			1 | D | Default | d | default)
				default_setting;
				break;;
			2 | Advanced | A | advanced | a)
				advanced_setting;
				break;;
			3 | About | about)
				read_about;
				break;;
			c | C)
				exit;
				break;;
			*)
		esac;
	done;
	
	return 0;
}


if [ $EUID != 0 ]; then 
	echo -e "This must be run by root\nTry \"sudo sh start.sh\"";
	exit;
fi;

check_if_root;
game_setting;
