#ifndef KALMANFILTER_H
#define KALMANFILTER_H

cv::KalmanFilter createKalmanFilter(int stateSize, int measSize, int contrSize, unsigned int type);
cv::Mat kalmanPredict(cv::KalmanFilter &kf);

#endif