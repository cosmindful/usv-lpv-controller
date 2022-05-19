

#ifndef IMAGEAQUISITION_H
#define IMAGEAQUISTION_H

#include <string>



extern const int FRAME_WIDTH;
extern const int FRAME_HEIGHT;

cv::VideoCapture createVideoCapture(int FRAME_WIDTH, int FRAME_HEIGHT);

#endif