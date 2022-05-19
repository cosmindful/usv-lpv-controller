/*
// Michael Garstka
// Ping Pong Ball tracker
// Version of 21.12.15
#include <sstream>
#include <string>
#include <iostream>
#include <fstream>
#include <opencv\highgui.h>
#include <opencv\cv.h>
#include <ctime>
#include <opencv2/video/video.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/core/core.hpp>

#include "ImageAquisition.h"
#include "DataOutput.h"


using namespace cv;


// define size of cropped square in (px by px)
const int SQUARE_SIZE = 250;


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


//scheinwerfer an und halogen licht aus
int H_MIN = 0;
int H_MAX = 17;
int S_MIN = 232;
int S_MAX = 256;
int V_MIN = 97;
int V_MAX = 256;

//names that will appear at the top of each window
const std::string originalImage = "Original Image";
const std::string hsvImage = "HSV Image";
const std::string thresholdedImage = "Thresholded Image";
const std::string croppedImage = "Cropped Image";
const std::string trackbarWindowName = "Trackbars";


void on_trackbar(int, void*)
{//This function gets called whenever a
	// trackbar position is changed
	// ich glaube nur eine dummy funktion, wenn die trackbar geschoben wird

}

void createTrackbars(){
	//create window for trackbars

	// namedWindow(Window Name,int flag for Options (WINDOW_NORMAL, WINDOW_AUTOSIZE, WINDOW_OPENGL))
	cv::namedWindow(trackbarWindowName, 0);
	//create memory to store trackbar name on window
	char TrackbarName[50];
	sprintf(TrackbarName, "H_MIN", H_MIN);
	sprintf(TrackbarName, "H_MAX", H_MAX);
	sprintf(TrackbarName, "S_MIN", S_MIN);
	sprintf(TrackbarName, "S_MAX", S_MAX);
	sprintf(TrackbarName, "V_MIN", V_MIN);
	sprintf(TrackbarName, "V_MAX", V_MAX);
	//create trackbars and insert them into window
	//3 parameters are: the address of the variable that is changing when the trackbar is moved(eg.H_LOW),
	//the max value the trackbar can move (eg. H_HIGH), 
	//and the function that is called whenever the trackbar is moved(eg. on_trackbar)
	//                                  ---->    ---->     ---->      
	cv::createTrackbar("H_MIN", trackbarWindowName, &H_MIN, H_MAX, on_trackbar);
	cv::createTrackbar("H_MAX", trackbarWindowName, &H_MAX, H_MAX, on_trackbar);
	cv::createTrackbar("S_MIN", trackbarWindowName, &S_MIN, S_MAX, on_trackbar);
	cv::createTrackbar("S_MAX", trackbarWindowName, &S_MAX, S_MAX, on_trackbar);
	cv::createTrackbar("V_MIN", trackbarWindowName, &V_MIN, V_MAX, on_trackbar);
	cv::createTrackbar("V_MAX", trackbarWindowName, &V_MAX, V_MAX, on_trackbar);
}

void drawObject(int x, int y, cv::Mat &frame){

	//use some of the openCV drawing functions to draw crosshairs
	//on your tracked image!

	//UPDATE:JUNE 18TH, 2013
	//added 'if' and 'else' statements to prevent
	//memory errors from writing off the screen (ie. (-25,-25) is not within the window!)

	circle(frame, cv::Point(x, y), 20, cv::Scalar(255, 0, 0), 2);
	if (y - 25>0)
		line(frame, cv::Point(x, y), cv::Point(x, y - 25), cv::Scalar(255, 0, 0), 2);
	else line(frame, cv::Point(x, y), cv::Point(x, 0), cv::Scalar(255, 0, 0), 2);
	if (y + 25<FRAME_HEIGHT)
		line(frame, cv::Point(x, y), cv::Point(x, y + 25), cv::Scalar(255, 0, 0), 2);
	else line(frame, cv::Point(x, y), cv::Point(x, FRAME_HEIGHT), cv::Scalar(255, 0, 0), 2);
	if (x - 25>0)
		line(frame, cv::Point(x, y), cv::Point(x - 25, y), cv::Scalar(255, 0, 0), 2);
	else line(frame, cv::Point(x, y), cv::Point(0, y), cv::Scalar(255, 0, 0), 2);
	if (x + 25<FRAME_WIDTH)
		line(frame, cv::Point(x, y), cv::Point(x + 25, y), cv::Scalar(255, 0, 0), 2);
	else line(frame, cv::Point(x, y), cv::Point(FRAME_WIDTH, y), cv::Scalar(255, 0, 0), 2);

	putText(frame, intToString(x) + "," + intToString(y), cv::Point(x, y + 30), 1, 1, cv::Scalar(255, 0, 0), 2);

}

void createWindows()
{
	//start an infinite loop where camera feed is copied to cameraFeed matrix
	//all of our operations will be performed within this loop

	namedWindow(originalImage, WINDOW_NORMAL);
	namedWindow(thresholdedImage, WINDOW_NORMAL);
	namedWindow(hsvImage, WINDOW_NORMAL);
	namedWindow(croppedImage, WINDOW_NORMAL);

	// move and resize windows to place them on the screen in a convenient manner
	moveWindow(originalImage, 0, 0);
	moveWindow(thresholdedImage, 840, 0);
	moveWindow(hsvImage, 0, 525);
	moveWindow(trackbarWindowName, 1200, 525);
	//namedWindow(windowName4,WINDOW_NORMAL);
}


double computeFPS(clock_t clock1, clock_t clock2)
{
	double diffticks = clock1 - clock2;
	double diffs = (diffticks) / CLOCKS_PER_SEC;
	double fps = 10 / diffs;
	return fps;
}

double computeTime(clock_t clock1, clock_t clock2)
{
	double diffticks = clock1 - clock2;
	double diffs = (diffticks) / CLOCKS_PER_SEC;
	return diffs;
}

inline const char * const BoolToString(bool b)
{
	return b ? "true" : "false";
}

void cropCoordinates(double x_px, double y_px, double &x_crop, double &y_crop, double &w_crop, double &h_crop)
{


	if (x_px < SQUARE_SIZE / 2) x_crop = 0;
	else if (x_px > FRAME_WIDTH - SQUARE_SIZE / 2) x_crop = FRAME_WIDTH - SQUARE_SIZE;
	else x_crop = x_px - SQUARE_SIZE / 2;

	if (y_px < SQUARE_SIZE / 2) y_crop = 0;
	else if (y_px > FRAME_HEIGHT - SQUARE_SIZE / 2) y_crop = FRAME_HEIGHT - SQUARE_SIZE;
	else y_crop = y_px - SQUARE_SIZE / 2;

	w_crop = SQUARE_SIZE;
	h_crop = SQUARE_SIZE;

}
void pxToCoordinates(double x_px, double y_px, double &x_cd, double &y_cd)
{
	if (x_px == -1 && y_px == -1)
	{
		x_cd = -1;
		y_cd = -1;
	}
	else
	{
		x_cd = x_px * 3330 / 1570;
		y_cd = (FRAME_HEIGHT - y_px) * 1300 / 675 + 600 - 400 * 1300 / 675;
	}
}

void coordinatesToPx(double &x_px, double &y_px, double x_cd, double y_cd)
{
	if (x_cd == -1 && y_cd == -1)
	{
		x_px = -1;
		y_px = -1;
	}
	else
	{
		x_px = x_cd * 1570.0 / 3300.0;
		y_px = (675.0 / 1300.0) * ((FRAME_HEIGHT * 1300.0 / 675.0) - y_cd + 600.0 - (400.0 * 1300.0 / 675));
	}
}

void estimatePosition(double &x_est, double &y_est, double &vx_est, double& vy_est, double x, double y, double vx, double vy, double t_prev, double t_now)
{
	double dT = t_now - t_prev;
	x_est = x + dT*vx;
	y_est = y + dT*vy;
}

void adjustPredRect(Rect &predRect)
{
	float x = predRect.x;
	float y = predRect.y;
	float w = predRect.width;
	float h = predRect.height;

	if (x < 0) x = 0;
	else if (x > FRAME_WIDTH - w) x = FRAME_WIDTH - w;

	if (y < 0) y = 0;
	else if (y > FRAME_HEIGHT - h) y = FRAME_HEIGHT - h;

	predRect.x = x;
	predRect.y = y;

}

extern const int FRAME_WIDTH = 1920;
extern const int FRAME_HEIGHT = 1200;

cv::VideoCapture createVideoCapture(int FRAME_WIDTH, int FRAME_HEIGHT)
{
	cv::VideoCapture capture;
	//open capture object at location zero (default location for webcam)
	capture.open(0);
	//set height and width of capture frame
	capture.set(CV_CAP_PROP_FRAME_WIDTH, FRAME_WIDTH);
	capture.set(CV_CAP_PROP_FRAME_HEIGHT, FRAME_HEIGHT);
	// set number of frames per second
	capture.set(CV_CAP_PROP_FPS, 100);

	return capture;
}

const int MAX_NUM_OBJECTS = 1;
//minimum and maximum object area
const int MIN_OBJECT_AREA = 20 * 20;
const int MAX_OBJECT_AREA = FRAME_HEIGHT*FRAME_WIDTH / 1.5;

void morphOps(Mat &thresh){

	//create structuring element that will be used to "dilate" and "erode" image.
	//the element chosen here is a 3px by 3px rectangle
	// getStructuringElement(shape,size of structuring element) returns a structuring element of the specified size and shape for morphological operations
	Mat erodeElement = getStructuringElement(MORPH_RECT, Size(3, 3));
	//dilate with larger element so make sure object is nicely visible
	Mat dilateElement = getStructuringElement(MORPH_RECT, Size(8, 8));

	//erode(inputArray source, outputArray destination,inputArray kernel) Gegenteil von dilate
	erode(thresh, thresh, erodeElement);
	erode(thresh, thresh, erodeElement);

	//dilate(inputArray source, outputArray destination,inputArray kernel). Rechteck wird über das Bild geführt und ersetzt alle Pixel mit dem Maximalwert --> Aufhellung
	dilate(thresh, thresh, dilateElement);
	dilate(thresh, thresh, dilateElement);



}

// function will compute x and y coordinate of detected object from camera image and treshold
void trackFilteredObject(double &x_px, double &y_px, Mat threshold, Mat &frame, bool &objectDetected, int &dbg){

	Mat temp;
	// copy the threshold matrix to matrix temp
	threshold.copyTo(temp);
	//these two vectors needed for output of findContours
	vector< vector<Point> > contours;
	vector<Vec4i> hierarchy;
	//find contours of filtered image using openCV findContours function
	// findContours(inputArray image, outputArrayofArrays contours, each contour is stored as vector of points,hierachy contains additional information about image topology,...)
	findContours(temp, contours, hierarchy, CV_RETR_CCOMP, CV_CHAIN_APPROX_SIMPLE);
	//use moments method to find our filtered object
	double refArea = 0;

	// if something is found:
	if (hierarchy.size() > 0)
	{
		int numObjects = hierarchy.size();
		//if number of objects greater than MAX_NUM_OBJECTS we have a noisy filter
		if (numObjects <= MAX_NUM_OBJECTS)
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
				if (area>MIN_OBJECT_AREA && area<MAX_OBJECT_AREA)
				{
					// compute x,y coordinates of the centroid
					x_px = moment.m10 / area;
					y_px = moment.m01 / area;
					// set objectFound boolean to true
					objectDetected = true;
					dbg = 1;
				}
				else {
					objectDetected = false;
					dbg = 2;
					x_px = -1;
					y_px = -1;
				}

			}


		}

	}
	else {
		objectDetected = false;
		dbg = 3;
		x_px = -1;
		y_px = -1;
	}
}
int main(int argc, char* argv[])
{

	//double testa = 0;
	//testa = (675.0 / 1300.0) * 1200.0 * (1300.0 / 675.0);
	//Matrix to store each frame of the webcam feed, Mat is an opencv c++ n-dimensional array class
	Mat cameraFeed, frame, croppedFrame;
	//matrix storage for HSV image
	Mat HSV;
	//matrix storage for binary threshold image
	Mat threshold;
	//x and y values for the location of the object
	// >>>> Kalman Filter
	int stateSize = 6; // [x,y,v_x,v_y,w,h]
	int measSize = 4; // [z_x,z_y,z_w,z_h]
	int contrSize = 1;
	unsigned int type = CV_32F;

	// create kalman filter object kf
	cv::KalmanFilter kf(stateSize, measSize, contrSize, type);
	cv::Mat state(stateSize, 1, type);  // [x,y,v_x,v_y,w,h]
	cv::Mat meas(measSize, 1, type);    // [z_x,z_y,z_w,z_h]
	cv::setIdentity(kf.transitionMatrix); //initialize state matrix A with and identity
	kf.measurementMatrix = cv::Mat::zeros(measSize, stateSize, type); //initialize C matrix as a zero matrix
	kf.measurementMatrix.at<float>(0) = 1.0f; //add a float value of 1.0f to the four entries in the matrix
	kf.measurementMatrix.at<float>(7) = 1.0f;
	kf.measurementMatrix.at<float>(16) = 1.0f;
	kf.measurementMatrix.at<float>(23) = 1.0f;
	kf.processNoiseCov.at<float>(0) = 1e-2;
	kf.processNoiseCov.at<float>(7) = 1e-2;
	kf.processNoiseCov.at<float>(14) = 5.0f;
	kf.processNoiseCov.at<float>(21) = 5.0f;
	kf.processNoiseCov.at<float>(28) = 1e-2;
	kf.processNoiseCov.at<float>(35) = 1e-2;
	cv::setIdentity(kf.measurementNoiseCov, cv::Scalar(1e-1));
	kf.errorCovPre.at<float>(0) = 1; // px
	kf.errorCovPre.at<float>(7) = 1; // px
	kf.errorCovPre.at<float>(14) = 1;
	kf.errorCovPre.at<float>(21) = 1;
	kf.errorCovPre.at<float>(28) = 1; // px
	kf.errorCovPre.at<float>(35) = 1; // px

	state.at<float>(0) = meas.at<float>(0);
	state.at<float>(1) = meas.at<float>(1);
	state.at<float>(2) = 0;
	state.at<float>(3) = 0;
	state.at<float>(4) = meas.at<float>(2);
	state.at<float>(5) = meas.at<float>(3);

	cv::Rect predRect;
	predRect.x = 0;
	predRect.y = 0;
	predRect.width = 250;
	predRect.height = 250;
	cv::Point center;
	center.x = 0;
	center.y = 0;

	double x_px = 0, y_px = 0, x_px_est, y_px_est; //pixel location
	double x = 0, y = 0; // coordinate location
	double vx = 0, vy = 0, vx_est = 0, vy_est = 0; //velocity of ball
	double x_est = 0, y_est = 0; // estimated location
	double x_crop = 0, y_crop = 0, w_crop = 200, h_crop = 200;
	double t = 0;
	double dT = 0;
	// debugging variables
	int dbg = 1;
	int dbg_crop = 0;
	int loop = 1;
	//create slider bars for HSV filtering
	createTrackbars();
	//video capture object to acquire webcam feed is created with object name "capture"
	VideoCapture capture;
	//open capture object at location zero (default location for webcam)
	capture.open(0);
	//set height and width of capture frame
	capture.set(CV_CAP_PROP_FRAME_WIDTH, FRAME_WIDTH);
	capture.set(CV_CAP_PROP_FRAME_HEIGHT, FRAME_HEIGHT);
	// set number of frames per second
	capture.set(CV_CAP_PROP_FPS, 100);
	//start an infinite loop where camera feed is copied to cameraFeed matrix
	//all of our operations will be performed within this loop

	namedWindow(originalImage, WINDOW_NORMAL);
	namedWindow(thresholdedImage, WINDOW_NORMAL);
	namedWindow(hsvImage, WINDOW_NORMAL);
	namedWindow(croppedImage, WINDOW_NORMAL);

	// move and resize windows to place them on the screen in a convenient manner
	moveWindow(originalImage, 0, 0);
	moveWindow(thresholdedImage, 840, 0);
	moveWindow(hsvImage, 0, 525);
	moveWindow(trackbarWindowName, 1200, 525);


	//namedWindow(windowName4,WINDOW_NORMAL);


	// define variables for time measurements
	clock_t start, stop, stampstart, stampstop;
	// define counter for loop counts
	int counter = 0;
	double measuredFPS = 0;
	bool objectDetected = false;
	int numAttempt = 100;
	bool initial = true;
	bool searchSection = false;
	int mycase = 0;




	// loop until closed
	stampstart = clock();
	double ticks = 0;

	// create text file to store data and delete previous data
	std::ofstream data;
	data.open("data.txt");
	data << "x y t dbg objectdetected case vx vy x_est y_est\n";
	data.close();



	while (1){

		if (counter == 0)
		{
			start = clock();
		}
		counter += 1;

		// compute time dT
		double precTick = ticks; //save previous "time measurement"
		ticks = (double)cv::getTickCount(); //get new "time measurement"

		double dT = (ticks - precTick) / cv::getTickFrequency(); //compute dT

		//capture.read(Mat& image) grabs,decodes and returns the nexxt video frame and stores image to matrix camerafeed
		capture.read(cameraFeed);

		// ----------------------------------------------------------------------------- //
		// ----------------------------------------------------------------------------- //
		// CASE CHECKER: check if we want to search the whole image or just a section of it

		// Case 1: Initial loop run --> search whole picture
		if (initial == true)
		{
			searchSection = false;
			initial = false;
			mycase = 1;
		}
		else
		{
			// Case 2: Object Detected in previous run --> search only around next estimated position
			if (objectDetected == true)
			{
				searchSection = true;
				mycase = 2;
			}
			// Case 3: No object detected in previous run AND object was detected within last 5 runs
			else if (objectDetected == false && numAttempt <= 15)
			{
				searchSection = true;
				mycase = 3;
			}
			// Case 4: No object detected in previous run AND no object was detected within last 5 runs
			else if (objectDetected == false && numAttempt > 15)
			{
				searchSection = false;
				mycase = 4;
			}
		}
		// ----------------------------------------------------------------------------- //
		// ----------------------------------------------------------------------------- //

		frame = cameraFeed;

		if (searchSection == true)
		{
			// update transition matrix A
			kf.transitionMatrix.at<float>(2) = dT;
			kf.transitionMatrix.at<float>(9) = dT;

			// predict next state
			state = kf.predict();

			//calculate center point
			cv::Point center; //calculate the center of the predRect, which is equal to the state x,y
			center.x = state.at<float>(0);
			center.y = state.at<float>(1);
			// draw circle into the resulting picture, centered around predicted location, and radius 2
			cv::circle(cameraFeed, center, 2, CV_RGB(255, 0, 0), -1);

			// create and intialize prediction rectangle
			predRect.width = state.at<float>(4); //specify width of prediction rectangle by the predicted width
			predRect.height = state.at<float>(5); // specify height of prediction rectangle
			predRect.x = state.at<float>(0) - predRect.width / 2; // calculate the top left corner x
			predRect.y = state.at<float>(1) - predRect.height / 2; // calculate the top left corner y

			// adjust predRect to make sure it is within picture
			adjustPredRect(predRect);
			// draw rectangle into the resulting picture  with the information specified in predRect
			cv::rectangle(cameraFeed, predRect, CV_RGB(255, 0, 0), 2);
			// crop the image
			cameraFeed(predRect).copyTo(croppedFrame);
			frame = croppedFrame;
		}

		// perform image operations on image
		cvtColor(frame, HSV, COLOR_BGR2HSV);
		inRange(HSV, Scalar(H_MIN, S_MIN, V_MIN), Scalar(H_MAX, S_MAX, V_MAX), threshold);
		morphOps(threshold);
		// try to track the object in the cropped threshold image and return pixel coordinates of object, otherwise return -1,-1
		trackFilteredObject(x_px, y_px, threshold, frame, objectDetected, dbg);

		if (objectDetected == true)
		{
			if (searchSection == true)
			{
				// recalculate global pixel coordinates from cropped pixel coordinates
				if (x_px != -1 || y_px != -1)
				{
					center.x = predRect.x + x_px;
					center.y = predRect.y + y_px;
				}
			}
			else
			{
				center.x = x_px;
				center.y = y_px;
			}
			cv::circle(cameraFeed, center, 2, CV_RGB(20, 150, 20), -1);
			numAttempt = 0; //set the notFoundCount to 0

			meas.at<float>(0) = center.x; //update the measurement vector with the x value
			meas.at<float>(1) = center.y; //update the measurement vector with y value
			meas.at<float>(2) = 250; //update the width  measurement
			meas.at<float>(3) = 250; // update the height measurement
			kf.correct(meas); // Kalman Correction
			// calculate global real world coordinates from global pixel coordinates
			//pxToCoordinates(x_px, y_px, x, y);
			// save information


			//putText(cameraFeed, "Object Found at: x=" + intToString(x) + "mm (" + intToString(x_px) + "px) , y=" + intToString(y) + "mm (" + intToString(y_px) + "px)" + " Cropped: " + intToString(dbg_crop), Point(0, 50), 2, 1, Scalar(255, 0, 0), 2);
			//draw object location on screen, input centroid position and current camera frame
			//drawObject(x_px, y_px, cameraFeed);
		}
		else
		{
			numAttempt++;
			//putText(cameraFeed, "No Object Found! ADJUST FILTER, Cropped: " + intToString(dbg_crop), Point(0, 50), 1, 2, Scalar(255, 0, 0), 2);
		}


		// Add information to camera feed
		//putText(cameraFeed, "+", Point(x_px_est, y_px_est), 1, 2, Scalar(0, 0, 255), 2);
		line(cameraFeed, Point(125, 0), Point(125, FRAME_HEIGHT), Scalar(255, 255, 255), 2, 8);
		line(cameraFeed, Point(FRAME_WIDTH - 125, 0), Point(FRAME_WIDTH - 125, FRAME_HEIGHT), Scalar(255, 255, 255), 2, 8);
		line(cameraFeed, Point(0, 125), Point(FRAME_WIDTH, 125), Scalar(255, 255, 255), 2, 8);
		line(cameraFeed, Point(0, FRAME_HEIGHT - 400), Point(FRAME_WIDTH, FRAME_HEIGHT - 400), Scalar(255, 255, 255), 2, 8);
		putText(cameraFeed, "FPS=" + dblToString(measuredFPS), Point(0, 100), 1, 2, Scalar(255, 0, 0), 2);

		//imshow(windowname string,mat image) displays an image in the specified window
		imshow(thresholdedImage, threshold);
		imshow(originalImage, cameraFeed);
		imshow(hsvImage, HSV);

		// save data to text file

		//data.open("data.txt", std::ios_base::app);
		//data << dblToString(center.x) + " " + dblToString(cey) + " " + dblToString(computeTime(stampstop, stampstart)) + " " + intToString(dbg) + " " + BoolToString(objectDetected) + " " + intToString(mycase) + " " + dblToString(vx) + " " + dblToString(vy) + " " + dblToString(x_est) + " " + dblToString(y_est) + " " + dblToString(x_px_est) + " " + dblToString(y_px_est) + "\n";
		//data.close();

		if (counter == 10){
			stop = clock();
			measuredFPS = computeFPS(stop, start);
			counter = 0;
		}
		//delay 30ms so that screen can refresh.
		//image will not appear without this waitKey() command
		waitKey(1);
	}






	return EXIT_SUCCESS;
}
*/