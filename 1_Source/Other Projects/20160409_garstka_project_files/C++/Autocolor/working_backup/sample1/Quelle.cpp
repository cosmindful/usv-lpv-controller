#include <opencv2\highgui\highgui.hpp>
 
 
 
//displays video from a webcam
//0 is built-in, 1 is external
//press esc key to close
 
int main()
{
    cvNamedWindow("Streaming", CV_WINDOW_AUTOSIZE);
    CvCapture* capture = cvCreateCameraCapture(1); //0 = built-in, 1 = external
    IplImage* frame;
    while (1) {
        frame = cvQueryFrame(capture);
        if (!frame) break;
        cvShowImage("Streaming", frame);
        char c = cvWaitKey(33);
        if (c == 27) break;
    }
    cvReleaseCapture(&capture);
    cvDestroyWindow("Streaming");
    return 0;
}