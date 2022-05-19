#include <opencv\highgui.h>
#include <opencv\cv.h>
#include <ctime>
#include <opencv2/video/video.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/core/core.hpp>
#include "ImageAquisition.h"

//specify capture width and height
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