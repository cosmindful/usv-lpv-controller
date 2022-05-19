#ifndef DISPLAY_H
#define DISPLAY_H

#include <string>
extern int H_MIN, H_MAX, S_MIN, S_MAX, V_MIN, V_MAX;
extern const std::string originalImage, hsvImage, thresholdedImage, croppedImage, trackbarWindowName;


// declare functions
void on_trackbar(int, void*);
void drawObject(int x, int y, cv::Mat &frame);
void createTrackbars();
void createWindows();
#endif
