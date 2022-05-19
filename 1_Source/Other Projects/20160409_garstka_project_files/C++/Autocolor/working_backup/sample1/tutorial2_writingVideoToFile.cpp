/*

#include <opencv\highgui.h>
#include <opencv\cv.h>
#include <iostream>

using namespace cv;
using namespace std;

string intToString(int number){


	std::stringstream ss;
	ss << number;
	return ss.str();
}

int main(int argc, char* argv[])
{
	bool recording = false;
	bool startNewRecording = true;
	bool firstRun = true;
	int videoNumber = 0;
	VideoCapture cap(0); // open the video camera no. 0


	cv::VideoWriter writer; // ICH: create video writer opject
	if (!cap.isOpened())  // if not success, exit program
	{
		cout << "ERROR INITIALIZING VIDEO CAPTURE" << endl;
		return -1;
	}

	char* windowName = "Webcam Feed";
	namedWindow(windowName,CV_WINDOW_AUTOSIZE); //create a window to display our webcam feed

	
	//fourcc integer(ICH)
	int fcc = CV_FOURCC('M','P','4','2');
	// frames per sec integer(ICH)
	int fps = 20;
	// frame size(ICH)
	cv::Size frameSize(cap.get(CV_CAP_PROP_FRAME_WIDTH),cap.get(CV_CAP_PROP_FRAME_HEIGHT)); //ICH


	
	Mat frame;


	while (1) {

		if (startNewRecording == true){
				
			startNewRecording = false;
			recording = true;
			videoNumber += 1;
			string filename = "E:/myVideo" + intToString(videoNumber) +".avi";
			writer = VideoWriter(filename,fcc,fps,frameSize); //ICH

			if(!writer.isOpened()){
				cout<<"WRROR OPENING FILE FOR WRITE!"<<endl;
				getchar();
				return -1;
			}
		}

		bool bSuccess = cap.read(frame); // read a new frame from camera feed

		if (!bSuccess) //test if frame successfully read
		{
			cout << "ERROR READING FRAME FROM CAMERA FEED" << endl;
			break;
		}


		if(recording == true){
				writer.write(frame); // ICH: um das writer object zu starte
				putText(frame,"REC",Point(0,60),2,2,Scalar(0,0,255));

		}
		imshow(windowName, frame); //show the frame in "MyVideo" window

		//listen for 10ms for a key to be pressed
		switch(waitKey(10)){

		case 27:
			//'esc' has been pressed (ASCII value for 'esc' is 27)
			//exit program.
			return 0;
		
		//r button is pressed
		case 114:
			//toggle recording 
			recording = !recording;
			if (recording==true) cout<<"Begin Recording"<<endl;
			else cout<<"Recording Paused"<<endl;



			if (firstRun){
				string filename = "E:/myVideo0.avi";
				writer = VideoWriter(filename,fcc,fps,frameSize); //ICH

				if(!writer.isOpened()){
					cout<<"WRROR OPENING FILE FOR WRITE!"<<endl;
					getchar();
					return -1;
				}
			
			}
			break;
			
		//n button is pressed
		case 110:
			//start new recording
			startNewRecording = true;

			cout<<"New recording started"<<endl;



			if (firstRun==true)firstRun==false;
			break;

		}


	}

	return 0;

}
*/
////////////////////////////////////////////////////////////////////////////////////////////