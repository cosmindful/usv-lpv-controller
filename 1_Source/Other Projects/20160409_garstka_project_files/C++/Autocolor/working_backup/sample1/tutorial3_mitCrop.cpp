// Michael Garstka
// Ping Pong Ball tracker
/*
#include <sstream>
#include <string>
#include <iostream>
#include <fstream>
#include <opencv\highgui.h>
#include <opencv\cv.h>
#include <ctime>




using namespace cv;

//initial min and max HSV filter values.
//these will be changed using trackbars
// HSV colorspace used to filter colors
//halogen licht an 

int H_MIN = 0;
int H_MAX = 26;
int S_MIN = 153;
int S_MAX = 256;
int V_MIN = 62;
int V_MAX = 256;

 //scheinwerfer an und halogen licht aus
//int H_MIN = 0;
//int H_MAX = 17;
//int S_MIN = 232;
//int S_MAX = 256;
//int V_MIN = 97;
//int V_MAX = 256;

//specify capture width and height
const int FRAME_WIDTH = 1920;
const int FRAME_HEIGHT = 1200;
//max number of objects to be detected in frame
const int MAX_NUM_OBJECTS=1;
//minimum and maximum object area
const int MIN_OBJECT_AREA = 10*10;
const int MAX_OBJECT_AREA = FRAME_HEIGHT*FRAME_WIDTH/1.5;
//names that will appear at the top of each window
const string windowName = "Original Image";
const string windowName1 = "HSV Image";
const string windowName2 = "Thresholded Image";
const string windowName3 = "Cropped Image";
const string trackbarWindowName = "Trackbars";
// initialize vectors to store x,y positions of object over time
vector<int> xpos;
vector<int> ypos;
vector<double> tpos;
// define size of cropped square in (px by px)
const int SQUARE_SIZE = 150;

void on_trackbar( int, void* )
{//This function gets called whenever a
	// trackbar position is changed
	// ich glaube nur eine dummy funktion, wenn die trackbar geschoben wird

}
string intToString(int number){
	std::stringstream ss;
	ss << number;
	return ss.str();
}
string dblToString(double number){
	std::stringstream ss;
	ss << number;
	return ss.str();
}

void createTrackbars(){
	//create window for trackbars

	// namedWindow(Window Name,int flag for Options (WINDOW_NORMAL, WINDOW_AUTOSIZE, WINDOW_OPENGL))
    namedWindow(trackbarWindowName,0);
	//create memory to store trackbar name on window
	char TrackbarName[50];
	sprintf( TrackbarName, "H_MIN", H_MIN);
	sprintf( TrackbarName, "H_MAX", H_MAX);
	sprintf( TrackbarName, "S_MIN", S_MIN);
	sprintf( TrackbarName, "S_MAX", S_MAX);
	sprintf( TrackbarName, "V_MIN", V_MIN);
	sprintf( TrackbarName, "V_MAX", V_MAX);
	//create trackbars and insert them into window
	//3 parameters are: the address of the variable that is changing when the trackbar is moved(eg.H_LOW),
	//the max value the trackbar can move (eg. H_HIGH), 
	//and the function that is called whenever the trackbar is moved(eg. on_trackbar)
	//                                  ---->    ---->     ---->      
    createTrackbar( "H_MIN", trackbarWindowName, &H_MIN, H_MAX, on_trackbar );
    createTrackbar( "H_MAX", trackbarWindowName, &H_MAX, H_MAX, on_trackbar );
    createTrackbar( "S_MIN", trackbarWindowName, &S_MIN, S_MAX, on_trackbar );
    createTrackbar( "S_MAX", trackbarWindowName, &S_MAX, S_MAX, on_trackbar );
    createTrackbar( "V_MIN", trackbarWindowName, &V_MIN, V_MAX, on_trackbar );
    createTrackbar( "V_MAX", trackbarWindowName, &V_MAX, V_MAX, on_trackbar );


}
void drawObject(int x, int y,Mat &frame){

	//use some of the openCV drawing functions to draw crosshairs
	//on your tracked image!

    //UPDATE:JUNE 18TH, 2013
    //added 'if' and 'else' statements to prevent
    //memory errors from writing off the screen (ie. (-25,-25) is not within the window!)

	circle(frame,Point(x,y),20,Scalar(255,0,0),2);
    if(y-25>0)
    line(frame,Point(x,y),Point(x,y-25),Scalar(255,0,0),2);
    else line(frame,Point(x,y),Point(x,0),Scalar(255,0,0),2);
    if(y+25<FRAME_HEIGHT)
    line(frame,Point(x,y),Point(x,y+25),Scalar(255,0,0),2);
    else line(frame,Point(x,y),Point(x,FRAME_HEIGHT),Scalar(255,0,0),2);
    if(x-25>0)
    line(frame,Point(x,y),Point(x-25,y),Scalar(255,0,0),2);
    else line(frame,Point(x,y),Point(0,y),Scalar(255,0,0),2);
    if(x+25<FRAME_WIDTH)
    line(frame,Point(x,y),Point(x+25,y),Scalar(255,0,0),2);
    else line(frame,Point(x,y),Point(FRAME_WIDTH,y),Scalar(255,0,0),2);

	putText(frame,intToString(x)+","+intToString(y),Point(x,y+30),1,1,Scalar(255,0,0),2);

}
void morphOps(Mat &thresh){

	//create structuring element that will be used to "dilate" and "erode" image.
	//the element chosen here is a 3px by 3px rectangle
	// getStructuringElement(shape,size of structuring element) returns a structuring element of the specified size and shape for morphological operations
	Mat erodeElement = getStructuringElement( MORPH_RECT,Size(3,3));
    //dilate with larger element so make sure object is nicely visible
	Mat dilateElement = getStructuringElement( MORPH_RECT,Size(8,8));

	//erode(inputArray source, outputArray destination,inputArray kernel) Gegenteil von dilate
	erode(thresh,thresh,erodeElement);
	erode(thresh,thresh,erodeElement);

	//dilate(inputArray source, outputArray destination,inputArray kernel). Rechteck wird über das Bild geführt und ersetzt alle Pixel mit dem Maximalwert --> Aufhellung
	dilate(thresh,thresh,dilateElement);
	dilate(thresh,thresh,dilateElement);
	


}

// function will compute x and y coordinate of detected object from camera image and treshold
void trackFilteredObject(int &x, int &y, Mat threshold, Mat &cameraFeed, bool &objectDetected){

	Mat temp;
	// copy the threshold matrix to matrix temp
	threshold.copyTo(temp);
	//these two vectors needed for output of findContours
	vector< vector<Point> > contours;
	vector<Vec4i> hierarchy;
	//find contours of filtered image using openCV findContours function
	// findContours(inputArray image, outputArrayofArrays contours, each contour is stored as vector of points,hierachy contains additional information about image topology,...)
	findContours(temp,contours,hierarchy,CV_RETR_CCOMP,CV_CHAIN_APPROX_SIMPLE );
	//use moments method to find our filtered object
	double refArea = 0;

	// if something is found:
	if (hierarchy.size() > 0) 
	{
		int numObjects = hierarchy.size();
        //if number of objects greater than MAX_NUM_OBJECTS we have a noisy filter
        if(numObjects<=MAX_NUM_OBJECTS)
		{
			// for loop syntax for(init;condition;increment)
			for (int index = 0; index >= 0; index = hierarchy[index][0]) 
			{
				// calculate flächenträgheitsmoment from contours
				Moments moment = moments((cv::Mat)contours[index]);
				// save object area from moment class
				double area = moment.m00;

				//if the area is less than 20 px by 20px then it is probably just noise
				//if the area is the same as the 3/2 of the image size, probably just a bad filter
				//iteration and compare it to the area in the next iteration.
                if(area>MIN_OBJECT_AREA && area<MAX_OBJECT_AREA )
				{
					// compute x,y coordinates of the centroid
					x = moment.m10/area;
					y = moment.m01/area;
					// set objectFound boolean to true
					objectDetected = true;
				}
				else objectDetected = false;


			}
			

		}

	}
	else objectDetected = false;
}


double computeFPS(clock_t clock1,clock_t clock2)
{
	double diffticks = clock1-clock2;
	double diffs =(diffticks)/CLOCKS_PER_SEC;
	double fps = 10/diffs;
	return fps;
}

double computeTime(clock_t clock1,clock_t clock2)
{
	double diffticks = clock1-clock2;
	double diffs =(diffticks)/CLOCKS_PER_SEC;
	return diffs;
}
void cropCoordinates(int x,int y,int &x_crop, int &y_crop, int &w_crop, int &h_crop)
{
	/*
	if (x<SQUARE_SIZE/2 ||  x > FRAME_WIDTH-SQUARE_SIZE/2 || y < SQUARE_SIZE/2 || y > FRAME_HEIGHT-SQUARE_SIZE/2)
	{
		x_crop = 0;
		y_crop = 0;
		w_crop = FRAME_WIDTH;
		h_crop = FRAME_HEIGHT;
	}
	else
	{
		x_crop = x-SQUARE_SIZE/2;
		y_crop = y-SQUARE_SIZE/2;
		w_crop = SQUARE_SIZE;
		h_crop = SQUARE_SIZE;
	}
	// ADD /* LATER WHEN UNCOMMENTING
	
	if (x < SQUARE_SIZE/2) x_crop = 0;
	else if( x > FRAME_WIDTH-SQUARE_SIZE/2) x_crop = FRAME_WIDTH-SQUARE_SIZE;
	else x_crop = x - SQUARE_SIZE/2;

	if (y < SQUARE_SIZE/2) y_crop = 0;
	else if (y > FRAME_HEIGHT-SQUARE_SIZE/2) y_crop = FRAME_HEIGHT-SQUARE_SIZE;
	else y_crop = y - SQUARE_SIZE/2;

	w_crop = SQUARE_SIZE;
	h_crop = SQUARE_SIZE;
	
}

int main(int argc, char* argv[])
{

	//Matrix to store each frame of the webcam feed, Mat is an opencv c++ n-dimensional array class
	Mat cameraFeed, croppedFrame;
	//matrix storage for HSV image
	Mat HSV;
	//matrix storage for binary threshold image
	Mat threshold;
	//x and y values for the location of the object
	int x=0, y=0;
	int x_crop = 0, y_crop = 0, w_crop = 200, h_crop = 200;
	//create slider bars for HSV filtering
	createTrackbars();
	//video capture object to acquire webcam feed is created with object name "capture"
	VideoCapture capture;
	//open capture object at location zero (default location for webcam)
	capture.open(0);
	//set height and width of capture frame
	capture.set(CV_CAP_PROP_FRAME_WIDTH,FRAME_WIDTH);
	capture.set(CV_CAP_PROP_FRAME_HEIGHT,FRAME_HEIGHT);
	// set number of frames per second
	capture.set(CV_CAP_PROP_FPS,100);
	//start an infinite loop where camera feed is copied to cameraFeed matrix
	//all of our operations will be performed within this loop

	namedWindow(windowName1,WINDOW_NORMAL);
	namedWindow(windowName2,WINDOW_NORMAL);
	namedWindow(windowName3,WINDOW_NORMAL);
	namedWindow(windowName,WINDOW_NORMAL);
	//namedWindow(windowName4,WINDOW_NORMAL);


	// define variables for time measurements
	clock_t start, stop, stampstart, stampstop;
	// define counter for loop counts
	int counter = 0;
	double measuredFPS = 0;
	bool objectDetected = false;
	// loop until closed
	stampstart = clock();
	// create text file to store data and delete previous data
	std::ofstream data;
	data.open("data.txt");
	data << "x y t\n";
	data.close();

	while(1){

		if (counter == 0)
		{
			start = clock();
		}
		counter +=1;


		//capture.read(Mat& image) grabs,decodes and returns the nexxt video frame and stores image to matrix camerafeed
		capture.read(cameraFeed);


		// Try to find object in cropped image (proximity of previous position)
		if(objectDetected == true)
		{
			cropCoordinates(x,y,x_crop,y_crop,w_crop,h_crop);
			cameraFeed(Rect(x_crop,y_crop,w_crop,h_crop)).copyTo(croppedFrame);
			cvtColor(croppedFrame,HSV,COLOR_BGR2HSV);
			inRange(HSV,Scalar(H_MIN,S_MIN,V_MIN),Scalar(H_MAX,S_MAX,V_MAX),threshold);
			morphOps(threshold);
			trackFilteredObject(x,y,threshold,croppedFrame,objectDetected);
			x = x_crop + x;
			y = y_crop + y;
			xpos.push_back(x);
			ypos.push_back(y);
			stampstop = clock();
			tpos.push_back(computeTime(stampstop, stampstart));
			imshow(windowName3,croppedFrame);


		}
		// otherwise try to find object in whole image
		if (objectDetected == false)
		{
			cvtColor(cameraFeed,HSV,COLOR_BGR2HSV);
			inRange(HSV,Scalar(H_MIN,S_MIN,V_MIN),Scalar(H_MAX,S_MAX,V_MAX),threshold);
			morphOps(threshold);
			trackFilteredObject(x,y,threshold,cameraFeed,objectDetected);
			xpos.push_back(x);
			ypos.push_back(y);
			stampstop = clock();
			tpos.push_back(computeTime(stampstop, stampstart));
		}
		

		

		// Add information to camera feed
		line(cameraFeed,Point(SQUARE_SIZE/2,0),Point(SQUARE_SIZE/2,FRAME_HEIGHT),Scalar(255,255,255),2,8);
		line(cameraFeed,Point(FRAME_WIDTH-SQUARE_SIZE/2,0),Point(FRAME_WIDTH-SQUARE_SIZE/2,FRAME_HEIGHT),Scalar(255,255,255),2,8);
		line(cameraFeed,Point(0,SQUARE_SIZE/2),Point(FRAME_WIDTH,SQUARE_SIZE/2),Scalar(255,255,255),2,8);
		line(cameraFeed,Point(0,FRAME_HEIGHT-SQUARE_SIZE/2),Point(FRAME_WIDTH,FRAME_HEIGHT-SQUARE_SIZE/2),Scalar(255,255,255),2,8);
		if (objectDetected==true)
		{
			putText(cameraFeed,"Object Found at: x="+intToString(x)+"px , y="+intToString(y)+"px",Point(0,50),2,1,Scalar(255,0,0),2);
			//draw object location on screen, input centroid position and current camera frame
			drawObject(x,y,cameraFeed);
		}
		else putText(cameraFeed,"No Object Found! ADJUST FILTER",Point(0,50),1,2,Scalar(255,0,0),2);

		
		putText(cameraFeed,"FPS="+dblToString(measuredFPS),Point(0,100),1,2,Scalar(255,0,0),2);



		// Display Images);


		//imshow(windowname string,mat image) displays an image in the specified window
		imshow(windowName2,threshold);
		imshow(windowName,cameraFeed);
		imshow(windowName1,HSV);

		// save data to text file
		data.open("data.txt", std::ios_base::app);
		data << intToString(x) + " " + intToString(y) + " " + dblToString(computeTime(stampstop, stampstart)) + "\n";
		data.close();


		if (counter == 10){
			stop = clock();
			measuredFPS = computeFPS(stop,start);
			counter = 0;
		}
		//delay 30ms so that screen can refresh.
		//image will not appear without this waitKey() command
		waitKey(1);
	}


	



	return 0;
}
*/