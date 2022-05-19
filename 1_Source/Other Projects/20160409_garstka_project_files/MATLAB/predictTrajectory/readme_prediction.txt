%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MATLAB FILES

Project Thesis: "Development of a control strategy to move a robot arm into the flight trajectory of a ping pong ball on a 2D curve"

Author: Michael Garstka
Date: 07.04.2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

The MATLAB files in this folder can be used to predict the trajectory of the ball using the equations of motion of the ball and the simple euler forward method. This is based on a txt-file with measurement data of the ball’s position. These measurements were obtained using the position tracking algorithm and experiments in the lab.  


predict_trajectory.m: Main file that takes position data as an input, predicts the movement of the ball, solves the inverse kinematics and creates reference signals for the controller (in sigmoid form).

auxiliary: Help functions 