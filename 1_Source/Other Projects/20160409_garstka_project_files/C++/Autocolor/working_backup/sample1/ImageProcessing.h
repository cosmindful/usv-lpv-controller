
#ifndef IMAGEPROCESSING_H
#define IMAGEPROCESSING_H


#include <opencv\cv.h>
#include <opencv\highgui.h>
#include <opencv2/video/video.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/core/core.hpp>

extern const int MAX_NUM_OBJECTS;
extern const int MIN_OBJECT_AREA;


void morphOps(cv::Mat &thresh);
// function will compute x and y coordinate of detected object from camera image and treshold
void trackFilteredObject(double &x_px, double &y_px, cv::Mat threshold, cv::Mat &frame, bool &objectDetected, int &dbg);

#endif