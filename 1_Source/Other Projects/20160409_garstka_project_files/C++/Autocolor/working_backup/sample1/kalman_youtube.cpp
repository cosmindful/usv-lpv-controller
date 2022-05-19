
/******************************************
* OpenCV Tutorial: Ball Tracking using   *
* Kalman Filter                          *
******************************************/
/*
// Module "core"
#include <opencv2/core/core.hpp>

// Module "highgui"
#include <opencv2/highgui/highgui.hpp>

// Module "imgproc"
#include <opencv2/imgproc/imgproc.hpp>

// Module "video"
#include <opencv2/video/video.hpp>

// Output
#include <iostream>

// Vector
#include <vector>
#include <ctime>

using namespace std;


clock_t start, stop, stampstart, stampstop;
int counter = 0;
double measuredFPS = 0;

int H_MIN = 0;
int H_MAX = 17;
int S_MIN = 232;
int S_MAX = 256;
int V_MIN = 97;
int V_MAX = 256;

std::string dblToString(double number){
	std::stringstream ss;
	ss << number;
	return ss.str();
}
double computeFPS(clock_t clock1, clock_t clock2)
{
	double diffticks = clock1 - clock2;
	double diffs = (diffticks) / CLOCKS_PER_SEC;
	double fps = 10 / diffs;
	return fps;
}
int main()
{
	// Camera frame
	cv::Mat frame;

	// >>>> Kalman Filter
	int stateSize = 6; // [x,y,v_x,v_y,w,h]
	int measSize = 4; // [z_x,z_y,z_w,z_h]
	int contrSize = 0;

	unsigned int type = CV_32F;

	// KalmanFilter KalmanFilter::KalmanFilter(int dynamParams, int measureParams, int controlParams=0, int type=CV_32F) 
	//dynamParams – Dimensionality of the state.
	//measureParams – Dimensionality of the measurement.
	//controlParams – Dimensionality of the control vector. -> here no controller
	// type – Type of the created matrices that should be CV_32F or CV_64F.
	// create kalman filter object kf
	cv::KalmanFilter kf(stateSize, measSize, contrSize, type);

	// create two vectors to represent the states and the measured outputs
	cv::Mat state(stateSize, 1, type);  // [x,y,v_x,v_y,w,h]
	cv::Mat meas(measSize, 1, type);    // [z_x,z_y,z_w,z_h]
	//cv::Mat procNoise(stateSize, 1, type)
	// [E_x,E_y,E_v_x,E_v_y,E_w,E_h]

	// Transition State Matrix A (linear model of the ball)
	// Note: set dT at each processing step!
	// [ 1 0 dT 0  0 0 ]
	// [ 0 1 0  dT 0 0 ]
	// [ 0 0 1  0  0 0 ]
	// [ 0 0 0  1  0 0 ]
	// [ 0 0 0  0  1 0 ]
	// [ 0 0 0  0  0 1 ]
	cv::setIdentity(kf.transitionMatrix); //initialize state matrix A with and identity

	// Measure Matrix H is the matrix that "measures" the outputs from the states. so C in z=C*x+D*u
	// [ 1 0 0 0 0 0 ]
	// [ 0 1 0 0 0 0 ]
	// [ 0 0 0 0 1 0 ]
	// [ 0 0 0 0 0 1 ]
	kf.measurementMatrix = cv::Mat::zeros(measSize, stateSize, type); //initialize C matrix as a zero matrix
	kf.measurementMatrix.at<float>(0) = 1.0f; //add a float value of 1.0f to the four entries in the matrix
	kf.measurementMatrix.at<float>(7) = 1.0f;
	kf.measurementMatrix.at<float>(16) = 1.0f;
	kf.measurementMatrix.at<float>(23) = 1.0f;

	// Process Noise Covariance Matrix Q
	// [ Ex   0   0     0     0    0  ]
	// [ 0    Ey  0     0     0    0  ]
	// [ 0    0   Ev_x  0     0    0  ]
	// [ 0    0   0     Ev_y  0    0  ]
	// [ 0    0   0     0     Ew   0  ]
	// [ 0    0   0     0     0    Eh ]
	//cv::setIdentity(kf.processNoiseCov, cv::Scalar(1e-2));
	kf.processNoiseCov.at<float>(0) = 1e-2;
	kf.processNoiseCov.at<float>(7) = 1e-2;
	kf.processNoiseCov.at<float>(14) = 5.0f;
	kf.processNoiseCov.at<float>(21) = 5.0f;
	kf.processNoiseCov.at<float>(28) = 1e-2;
	kf.processNoiseCov.at<float>(35) = 1e-2;

	// Measures Noise Covariance Matrix R
	cv::setIdentity(kf.measurementNoiseCov, cv::Scalar(1e-1));
	// <<<< Kalman Filter

	// Camera Index
	int idx = 0;

	// Camera Capture
	cv::VideoCapture cap;

	// >>>>> Camera Settings
	if (!cap.open(idx))
	{
		cout << "Webcam not connected.\n" << "Please verify\n";
		return EXIT_FAILURE;
	}

	cap.set(CV_CAP_PROP_FRAME_WIDTH, 1024);
	cap.set(CV_CAP_PROP_FRAME_HEIGHT, 768);
	// <<<<< Camera Settings

	cout << "\nHit 'q' to exit...\n";

	char ch = 0;

	double ticks = 0;
	bool found = false; //start with found set to false

	int notFoundCount = 0;

	//////////////////////////////////////////////////////////////////////////// >>>>> Main loop
	while (ch != 'q' && ch != 'Q')
	{

		if (counter == 0)
		{
			start = clock();
		}
		counter += 1;

		double precTick = ticks; //save previous "time measurement"
		ticks = (double)cv::getTickCount(); //get new "time measurement"

		double dT = (ticks - precTick) / cv::getTickFrequency(); //compute dT

		// Frame acquisition
		cap >> frame;
		// copy frame to matrix res
		cv::Mat res;
		frame.copyTo(res);

		// if an object was found in last run, do the following:
		if (found)
		{
			// >>>> Matrix A - update dT in the transistion matrix A
			kf.transitionMatrix.at<float>(2) = dT;
			kf.transitionMatrix.at<float>(9) = dT;
			// <<<< Matrix A

			cout << "dT:" << endl << dT << endl; //output the measured dT

			state = kf.predict(); //computes a predicted state. x(k+1)=Ax(k)?
			cout << "State post:" << endl << state << endl; //output the predicted state

			 // Template class for 2D rectangles, described by the following parameters:
			//Coordinates of the top - left corner.This is a default interpretation of Rect_::x and Rect_::y in OpenCV.Rectangle width and height.
			cv::Rect predRect;
			predRect.width = state.at<float>(4); //specify width of prediction rectangle by the predicted width
			predRect.height = state.at<float>(5); // specify height of prediction rectangle
			predRect.x = state.at<float>(0) - predRect.width / 2; // calculate the top left corner x
			predRect.y = state.at<float>(1) - predRect.height / 2; // calculate the top left corner y

			cv::Point center; //calculate the center of the predRect, which is equal to the state x,y
			center.x = state.at<float>(0);
			center.y = state.at<float>(1);
			// draw circle into the resulting picture, centered around predicted location, and radius 2
			cv::circle(res, center, 2, CV_RGB(255, 0, 0), -1);
			// draw rectangle into the resulting picture  with the information specified in predRect
			cv::rectangle(res, predRect, CV_RGB(255, 0, 0), 2);
		}
		
		// in any case do the following:

		// >>>>> Noise smoothing
		cv::Mat blur;
		cv::GaussianBlur(frame, blur, cv::Size(5, 5), 3.0, 3.0);
		// <<<<< Noise smoothing

		// >>>>> HSV conversion
		cv::Mat frmHsv;
		cv::cvtColor(blur, frmHsv, CV_BGR2HSV);
		// <<<<< HSV conversion

		// >>>>> Color Thresholding
		// Note: change parameters for different colors
		cv::Mat rangeRes = cv::Mat::zeros(frame.size(), CV_8UC1);
		cv::inRange(frmHsv,cv::Scalar(H_MIN, S_MIN, V_MIN), cv::Scalar(H_MAX, S_MAX, V_MAX),rangeRes);

	//	cv::inRange(frmHsv, cv::Scalar(MIN_H_BLUE / 2, 100, 80),
		//	cv::Scalar(MAX_H_BLUE / 2, 255, 255), rangeRes);
		// <<<<< Color Thresholding

		// >>>>> Improving the result
		cv::erode(rangeRes, rangeRes, cv::Mat(), cv::Point(-1, -1), 2);
		cv::dilate(rangeRes, rangeRes, cv::Mat(), cv::Point(-1, -1), 2);
		// <<<<< Improving the result

		// Thresholding viewing
		cv::imshow("Threshold", rangeRes);

		// >>>>> Contours detection
		vector<vector<cv::Point> > contours;
		cv::findContours(rangeRes, contours, CV_RETR_EXTERNAL,
			CV_CHAIN_APPROX_NONE);
		// <<<<< Contours detection

		// >>>>> Filtering
		vector<vector<cv::Point> > balls;
		vector<cv::Rect> ballsBox;
		for (size_t i = 0; i < contours.size(); i++)
		{
			cv::Rect bBox;
			bBox = cv::boundingRect(contours[i]);

			float ratio = (float)bBox.width / (float)bBox.height;
			if (ratio > 1.0f)
				ratio = 1.0f / ratio;

			// Searching for a bBox almost square and over a certain area
			if (ratio > 0.75 && bBox.area() >= 400)
			{
				balls.push_back(contours[i]);
				ballsBox.push_back(bBox);
			}
		}
		// <<<<< Filtering

		cout << "Balls found:" << ballsBox.size() << endl;

		// >>>>> Detection result
		for (size_t i = 0; i < balls.size(); i++)
		{
			// draw Contours around the ball and the rectangle around the ball
			cv::drawContours(res, balls, i, CV_RGB(20, 150, 20), 1);
			cv::rectangle(res, ballsBox[i], CV_RGB(0, 255, 0), 2);
			// calculate the centroid via the center of the bounding box
			cv::Point center;
			center.x = ballsBox[i].x + ballsBox[i].width / 2;
			center.y = ballsBox[i].y + ballsBox[i].height / 2;
			// draw a small circle around the center point
			cv::circle(res, center, 2, CV_RGB(20, 150, 20), -1);

			// put information on x and y on resulting frame
			stringstream sstr;
			sstr << "(" << center.x << "," << center.y << ")";
			cv::putText(res, sstr.str(),
				cv::Point(center.x + 3, center.y - 3),
				cv::FONT_HERSHEY_SIMPLEX, 0.5, CV_RGB(20, 150, 20), 2);
		}
		// <<<<< Detection result

		// >>>>> Kalman Update 
		if (balls.size() == 0) // if no ball was detected, increment the notFoundCount. after a hundred tries, set found to false 
		{
			notFoundCount++;
			cout << "notFoundCount:" << notFoundCount << endl;
			if (notFoundCount >= 100)
			{
				found = false;
			}
			//else
			//kf.statePost = state;
		}
		else // if a ball was detected
		{
			notFoundCount = 0; //set the notFoundCount to 0

			meas.at<float>(0) = ballsBox[0].x + ballsBox[0].width / 2; //update the measurement vector with the x value
			meas.at<float>(1) = ballsBox[0].y + ballsBox[0].height / 2; //update the measurement vector with y value
			meas.at<float>(2) = (float)ballsBox[0].width; //update the width  measurement
			meas.at<float>(3) = (float)ballsBox[0].height; // update the height measurement

			if (!found) // First detection!
			{
				// >>>> Initialization
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
				// <<<< Initialization

				found = true;
			}
			else
				kf.correct(meas); // Kalman Correction - save the corrected states to the vector meas

			cout << "Measure matrix:" << endl << meas << endl;
		}
		// <<<<< Kalman Update

		// Final result
		putText(res, "FPS=" + dblToString(measuredFPS),cv::Point(0, 100), 1, 2, cv::Scalar(255, 0, 0), 2);

		cv::imshow("Tracking", res); //display the final result
		if (counter == 10){
			stop = clock();
			measuredFPS = computeFPS(stop, start);
			counter = 0;
		}
		// User key
		ch = cv::waitKey(1);
	}
	// <<<<< Main loop

	return EXIT_SUCCESS;
}
*/