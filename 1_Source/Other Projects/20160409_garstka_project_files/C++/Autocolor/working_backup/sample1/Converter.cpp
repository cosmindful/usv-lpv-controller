#include <string>
#include <sstream>
#include <iostream>
#include "Converter.h"


std::string intToString(int number){
	std::stringstream ss;
	ss << number;
	return ss.str();
}
std::string dblToString(double number){
	std::stringstream ss;
	ss << number;
	return ss.str();
}