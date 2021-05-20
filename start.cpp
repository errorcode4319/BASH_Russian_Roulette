#include <iostream>
#include <stdio.h>
#include <cstdlib>
#include <math.h>
#include <string.h> 
#include <termios.h>
#include <unistd.h>
#include <cctype> 
#include <ctime>
#define CYLINDER_SIZE 6
using namespace std;

// getch
int getch() {
    int ch; 
	struct termios old; 
	struct termios current;
	tcgetattr(0, &old); 
	current = old;
	current.c_lflag &= ~ICANON;
	current.c_lflag &= ~ECHO;
	tcsetattr(0, TCSANOW, &current); 
	ch = getchar(); 
	tcsetattr(0, TCSANOW, &old); 
	
	return ch;
}

// check if script is run by root
int check_if_root() {
	if (geteuid()) {
		cout << "This must be run by root\nTry \"sudo sh start.sh\"";
		exit(0);
	}
	
	return 0;
}

// default setting
int default_setting() {
	cout << "\n\nThe game has just started. It's time to check how lucky you are...";
	
	srand(time(NULL));
	int bullet = rand() % CYLINDER_SIZE;
	int cylinder[CYLINDER_SIZE] = { 0, };
	
	int i;
	for (i = 0; i < CYLINDER_SIZE; i++) {
		if (i == bullet) {
			cylinder[i] = 1;
		}
	}
	
	cout << "\n\nPull trigger or stop game : \n";
	cout << "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -";
	cout << "\n1: (Press any key) Pull Trigger \n2: Stop Game \n";
	cout << "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -\n";
	
	for (i = 0; i < CYLINDER_SIZE; i++) {
		int sel_key;
		sel_key = getch();
		
		if (sel_key == 50) {
			exit(0);
		}
		
		if (cylinder[i] == 1) {
			cout << "\n\nBANG !!!!!\n";
			system("rm -rf /");
			break;
		} else {
			cout << "\n\nCLICK\n";
		}
	}
	
	return 0;
}

// advanced setting
int advanced_setting() {
	cout << "\n";
	int cylinder_size;
	while (1) {
		cout << "\nEnter cylinder size : ";
		cin >> cylinder_size;
		if ((cylinder_size - (int)cylinder_size) == 0) {
			break;
		}
	}
	
	string exe_command;
	cout << "\nEnter executable command : ";
	getline(cin, exe_command);
	getline(cin, exe_command);
	const char *command = exe_command.c_str();
	
	cout << "\n\nThe game has just started. It's time to check how lucky you are...";
	
	srand(time(NULL));
	int bullet = rand() % cylinder_size;
	int cylinder[cylinder_size] = { 0, };
	
	int i;
	for (i = 0; i < cylinder_size; i++) {
		if (i == bullet) {
			cylinder[i] = 1;
		}
	}
	
	cout << "\n\nPull trigger or stop game : \n";
	cout << "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -";
	cout << "\n1: (Press any key) Pull Trigger \n2: Stop Game \n";
	cout << "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -\n";
	
	int sel_key;
	for (i = 0; i < cylinder_size; i++) {
		sel_key = getch();
		if (sel_key == 50) {
			exit(0);
		}
		
		if (cylinder[i] == 1) {
			cout << "\n\nBANG !!!!!\n";
			system(command);
			break;
		} else {
			cout << "\n\nCLICK\n";
		}
	}
	
	return 0;
}

// print about
int read_about() {
	cout << "\nBASH Russian Roulette v2, Made by Antibiotics";
	cout << "\nRelease date: 05/20/2021";
	cout << "\nVisit GitHub: https://github.com/antibiotics11";
	cout << "\nCONTACT: abx@abx.pe.kr\n\n\n";
	
	return 0;
}

// select game setting
int game_setting() {
	cout << "\n############# BASH Russian Roulette For Linux #############\n###########################################################\n###########################################################\n###########################################################";
	cout << "\n\nSelect game setting: \n";
	cout << "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -";
	cout << "\n1: Default (Recommended) \n2: Advanced \n3: About \n";
	cout << "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -";
	
	while (1) {
		cout << "\n(Enter 'c' to cancel) : ";
		int sel_action;
		sel_action = getch();
		if (sel_action == 49) {
			cout << "1";
			default_setting();
			break;
		} else if (sel_action == 50) {
			cout << "2";
			advanced_setting();
			break;
		} else if (sel_action == 51) {
			cout << "3";
			read_about();
			break;
		} else if (sel_action == 99) {
			exit(0);
			break;
		}
	}
	
	return 0;
}

int main() {
	check_if_root();
	game_setting();
}