

 /*
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <iostream>
using namespace cv;
using namespace std;
 
int main() {
VideoCapture stream1(0);   //0 is the id of video device.0 if you have only one camera.
stream1.set(CV_CAP_PROP_FRAME_WIDTH, 1920);
stream1.set(CV_CAP_PROP_FRAME_HEIGHT, 1200);
if (!stream1.isOpened()) { //check if video device has been initialised
cout << "cannot open camera";
}
 
//unconditional loop
while (true) {
Mat cameraFrame, croppedFrame;
stream1.read(cameraFrame);
cameraFrame(Rect(100,100,300,300)).copyTo(croppedFrame);
imshow("cam", cameraFrame);

imshow("crop", croppedFrame);



if (waitKey(30) >= 0)
break;
}
return 0;

}

*/