
#include <opencv\highgui.h>
#include <opencv\cv.h>
#include <ctime>
#include <opencv2/video/video.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/core/core.hpp>
#include "ImageAquisition.h"
#include "ImageProcessing.h"

using namespace cv;

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