/*
#include<opencv\cv.h>
#include<opencv\highgui.h>
#include<iostream>
#include<ctime>
using namespace std;


clock_t start, stop;

double computeFPS(clock_t clock1,clock_t clock2)
{
	double diffticks = clock1-clock2;
	double diffs =(diffticks)/CLOCKS_PER_SEC;
	double fps = 100/diffs;
	return fps;
}

int counter = 0;
bool counting = true;
int a = 0;
int main(){

	while(a<500)
	{
		a++;
		if (counter == 0)
		{
			start = clock();
		}
		counter +=1;

		for (int i = 0; i<1; i++)
		{
		cout<<"value of i:" << i << endl;
		}

		if (counter == 100)
		{
			 stop = clock();
			cout << "FPS: "<<double(computeFPS(stop,start)) << " s" << endl;

			counter = 0;
		}
	
	
	}



return 0;}

	*/