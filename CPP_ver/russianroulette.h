#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <cctype> 
#include <ctime>
#include <math.h>
#include <string.h> 
#include <termios.h>
#include <unistd.h>
#define CYLINDER_SIZE 6

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

int is_root() {
	if (geteuid()) {
		std::cout << "This must be run by root\nTry \"sudo sh start.sh\"";
		exit(0);
	}
	
	return 0;
}
