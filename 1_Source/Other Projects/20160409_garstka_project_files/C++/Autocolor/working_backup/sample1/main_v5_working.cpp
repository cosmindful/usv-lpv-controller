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
#include "Converter.h"
#include "Display.h"
#include "ImageProcessing.h"
#include "KalmanFilter.h"
#include "Functions.h"
#include "Ball.h"
using namespace cv;


int main(int argc, char* argv[])
{
	
	//Matrix to store each frame of the webcam feed, Mat is an opencv c++ n-dimensional array class
	Mat cameraFeed, frame, croppedFrame;
	//matrix storage for HSV image
	Mat HSV;
	//matrix storage for binary threshold image
	Mat threshold;

	// create kalman Filter object and state and measurement vectors
	unsigned int type = CV_32F;
	int stateSize = 6; // [x,y,v_x,v_y,w,h]
	int measSize = 4; // [z_x,z_y,z_w,z_h]
	int contrSize = 1;
	cv::Mat meas(measSize, 1, type);    // [z_x,z_y,z_w,z_h]
	cv::Rect predRect(0,0,250,250);
	cv::Point center(0,0);
	cv::Mat state(stateSize, 1, type);  // [x,y,v_x,v_y,w,h]
	state.at<float>(0) = meas.at<float>(0);
	state.at<float>(1) = meas.at<float>(1);
	state.at<float>(2) = 0;
	state.at<float>(3) = 0;
	state.at<float>(4) = meas.at<float>(2);
	state.at<float>(5) = meas.at<float>(3);
	cv::KalmanFilter kf = createKalmanFilter(stateSize, measSize, contrSize, type);

	Point_<double> ballpx(0, 0); //create px-location of ball
	Point_<double> ballcd(0, 0); //create coordinate-location of ball
	// debugging variables
	int dbg = 1;

	//create slider bars for HSV filtering
	createTrackbars();
	//video capture object to acquire webcam feed is created with object name "capture"
	cv::VideoCapture capture = createVideoCapture(FRAME_WIDTH,FRAME_HEIGHT);
	
	//create windows to display picture and results
	createWindows();

	// define counter for loop counts
	int counter = 0;
	double measuredFPS = 0;
	bool objectDetected = false;
	int numAttempt = 100;
	bool initial = true;
	bool searchSection = false;
	int mycase = 0;

	// define variables for time measurements
	clock_t start, stop, stampstart, stampstop;
	
	double timestart = (double)cv::getTickCount();
	double ticks = 0;
	double dT = 0;

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
			state = kalmanPredict(kf); //slightly modified
			//state = kf.predict();
			 //calculate center point
			ballcd.x = state.at<float>(0); //calculate the center of the predRect, which is equal to the state x,y
			ballcd.y = state.at<float>(1);
			coordinatesToPx(ballpx.x, ballpx.y, ballcd.x, ballcd.y);
			// draw circle into the resulting picture, centered around predicted location, and radius 2
			cv::circle(cameraFeed, ballpx, 2, CV_RGB(255, 0, 0), -1);

			// create and intialize prediction rectangle
			predRect.width = state.at<float>(4); //specify width of prediction rectangle by the predicted width
			predRect.height = state.at<float>(5); // specify height of prediction rectangle
			predRect.x = ballpx.x - predRect.width / 2; // calculate the top left corner x
			predRect.y = ballpx.y - predRect.height / 2; // calculate the top left corner y
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
		trackFilteredObject(ballpx.x, ballpx.y, threshold, frame, objectDetected, dbg);

		if (objectDetected == true)
		{
			if (searchSection == true)
			{
				// recalculate global pixel coordinates from cropped pixel coordinates
				if (ballpx.x != -1 || ballpx.y != -1)
				{
					ballpx.x = predRect.x + ballpx.x;
					ballpx.y = predRect.y + ballpx.y;
				}
			}
			// after calculating the ball's px location, calculate coordinates
			pxToCoordinates(ballpx.x, ballpx.y, ballcd.x, ballcd.y); //?
			//cv::circle(cameraFeed, ballpx, 5, CV_RGB(20, 150, 20), -1);

			numAttempt = 0; //set the notFoundCount to 0



			meas.at<float>(0) = ballcd.x; //update the measurement vector with the x value
			meas.at<float>(1) = ballcd.y; //update the measurement vector with y value
			meas.at<float>(2) = 250; //update the width  measurement
			meas.at<float>(3) = 250; // update the height measurement
			kf.correct(meas); // Kalman Correction
			
			putText(cameraFeed, "Object Found at: x=" + dblToString(ballcd.x) + "mm (" + dblToString(ballpx.x) + "px) , y=" + dblToString(ballcd.y) + "mm (" + dblToString(ballpx.y) + "px)", Point(0, 50), 2, 1, Scalar(255, 0, 0), 2);
			//draw object location on screen, input centroid position and current camera frame
			//drawObject(x_px, y_px, cameraFeed);
		}
		else
		{
			numAttempt++;
			putText(cameraFeed, "No Object Found!", Point(0, 50), 1, 2, Scalar(255, 0, 0), 2);
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
		double timestop = (double)cv::getTickCount();
		double t = (timestop - timestart) / cv::getTickFrequency();
		
		data.open("data.txt", std::ios_base::app);
		data << dblToString(ballcd.x) + " " + dblToString(ballcd.y) + " " + dblToString(t) + " " + intToString(mycase) + "\n";// " " + BoolToString(objectDetected) + " " + intToString(mycase) + "\n";
		data.close();

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