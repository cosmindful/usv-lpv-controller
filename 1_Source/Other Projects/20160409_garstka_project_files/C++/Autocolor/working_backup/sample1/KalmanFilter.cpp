#include <opencv\highgui.h>
#include <opencv\cv.h>
#include <opencv2/video/video.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/core/core.hpp>
#include "KalmanFilter.h"

cv::KalmanFilter createKalmanFilter(int stateSize, int measSize, int contrSize, unsigned int type)
{
	

	// create kalman filter object kf
	cv::KalmanFilter kf(stateSize, measSize, contrSize, type);
	
	cv::setIdentity(kf.transitionMatrix); //initialize state matrix A with and identity
	kf.measurementMatrix = cv::Mat::zeros(measSize, stateSize, type); //initialize C matrix as a zero matrix
	kf.measurementMatrix.at<float>(0) = 1.0f; //add a float value of 1.0f to the four entries in the matrix
	kf.measurementMatrix.at<float>(7) = 1.0f;
	kf.measurementMatrix.at<float>(16) = 1.0f;
	kf.measurementMatrix.at<float>(23) = 1.0f;
	kf.processNoiseCov.at<float>(0) = 1e-2;
	kf.processNoiseCov.at<float>(7) = 1e-2;
	kf.processNoiseCov.at<float>(14) = 5.0f;
	kf.processNoiseCov.at<float>(21) = 5.0f;
	kf.processNoiseCov.at<float>(28) = 1e-2;
	kf.processNoiseCov.at<float>(35) = 1e-2;
	cv::setIdentity(kf.measurementNoiseCov, cv::Scalar(1e-1));
	kf.errorCovPre.at<float>(0) = 1; // px
	kf.errorCovPre.at<float>(7) = 1; // px
	kf.errorCovPre.at<float>(14) = 1;
	kf.errorCovPre.at<float>(21) = 1;
	kf.errorCovPre.at<float>(28) = 1; // px
	kf.errorCovPre.at<float>(35) = 1; // px

	return kf;
}

cv::Mat kalmanPredict(cv::KalmanFilter &kf)
{
	cv::Mat prediction(6, 1, CV_32F);
	prediction = kf.predict();
	kf.statePre.copyTo(kf.statePost);
	kf.errorCovPre.copyTo(kf.errorCovPost);
	return prediction;
}


