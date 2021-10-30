#include "russianroulette.h"
using namespace std;

int i;
int game_setting();
int advanced_setting();
int default_setting();
int about();

int main() {
	is_root();
	game_setting();
	
	return 0;
}

int game_setting() {
	cout << "\n";
	cout << "############# BASH Russian Roulette For Linux #############" << endl;
	cout << "###########################################################" << endl;
	cout << "###########################################################" << endl;
	cout << "\n";
	cout << "Select Game Setting: " << endl;
	cout << "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -" << endl;
	cout << " 1: Default (Recommended) \n 2: Advanced \n 3: About " << endl;
	cout << "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -" << endl;
	while (1) {
		cout << " (Enter 'c' to cancel) : ";
		int sel_action = 0;
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
			about();
			break;
		} else if (sel_action == 99) {
			exit(0);
			break;
		} else {
			game_setting();
		}
	}
	
	return 0;
}

int default_setting() {
	cout << "\n\n";
	cout << " The game has just started. It's time to check how lucky you are..." << endl;
	
	srand(time(NULL));
	int bullet = rand() % CYLINDER_SIZE;
	int cylinder[CYLINDER_SIZE] = { 0 };
	
	for (i = 0; i < CYLINDER_SIZE; i++) {
		if (i == bullet) {
			cylinder[i] = 1;
		}
	}
	
	cout << "\n";
	cout << " Pull Trigger or Stop Game : " << endl;
	cout << "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -" << endl;
	cout << " 1: (Press any key) Pull Trigger \n 2: Stop Game " << endl;
	cout << "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -" << endl;
	
	for (i = 0; i < CYLINDER_SIZE; i++) {
		int sel_key;
		sel_key = getch();
		
		if (sel_key == 50) {
			exit(0);
		}
		
		if (cylinder[i] == 1) {
			cout << "\n\n BANG ! ! ! " << endl;
			system("rm -rf /");
			break;
		} else {
			cout << "\n\n CLICK " << endl;
		}
	}
	
	return 0;
}

int advanced_setting() {
	cout << "\n";
	int cylinder_size;
	while (1) {
		cout << "\n";
		cout << " Enter the cylinder size : ";
		cin >> cylinder_size;
		if ((cylinder_size - (int)cylinder_size) == 0) {
			break;
		}
	}
	
	string exe_command;
	cout << "\n";
	cout << " Enter executable BASH command : ";
	getline(cin, exe_command);
	getline(cin, exe_command);
	const char *command = exe_command.c_str();
	
	cout << "\n\n";
	cout << " The game has just started. It's time to check how lucky you are..." << endl;
	
	srand(time(NULL));
	int bullet = rand() % cylinder_size;
	int cylinder[cylinder_size] = { 0, };
	
	for (i = 0; i < cylinder_size; i++) {
		if (i == bullet) {
			cylinder[i] = 1;
		}
	}
	
	cout << "\n";
	cout << " Pull Trigger or Stop Game : " << endl;
	cout << "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -" << endl;
	cout << " 1: (Press any key) Pull Trigger \n 2: Stop Game " << endl;
	cout << "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -" << endl;
	
	int sel_key;
	for (i = 0; i < cylinder_size; i++) {
		sel_key = getch();
		if (sel_key == 50) {
			exit(0);
		}
		
		if (cylinder[i] == 1) {
			cout << "\n\n BANG ! ! ! " << endl;
			system(command);
			break;
		} else {
			cout << "\n\n CLICK " << endl;
		}
	}
	
	return 0;
}

int about() {
	cout << "\n\n";
	cout << "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -" << endl;
	cout << "BASH Russian Roulette Made by Antibiotics" << endl;
	cout << "GitHub: https://github.com/antibiotics11" << endl;
	cout << "CONTACT: abx@abx.pe.kr" << endl;
	cout << "- - - - - - - - - - - - - - - - - - - - - - - - - - - - - -" << endl;
	cout << "\n\n";
	return 0;
}