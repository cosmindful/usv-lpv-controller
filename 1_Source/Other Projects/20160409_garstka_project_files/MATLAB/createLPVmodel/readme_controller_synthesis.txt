%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MATLAB FILES

Project Thesis: "Development of a control strategy to move a robot arm into the flight trajectory of a ping pong ball on a 2D curve"

Author: Michael Garstka
Date: 07.04.2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

The MATLAB files in this folder can be used to create 3 different LPV models and the corresponding LPV controllers. The LPV controller is stored in the variable dKLFR_sim, which is used in the SIMULINK file
LPV_controller_Simulation_6DOF.slx.


robot_3dof_model: The main file to create the controller and the model. Calls all the other functions.

generalized_plant: Edit the filters in this file to change the design specifications of the controller.

min_gamma_over_K: File written by Christian Hoffmann to implement the LPV-LFT controller synthesis based on parameter-independent Lyapunov functions.

min_gamma_over_K: File written by Christian Hoffmann to implement the LPV-LFT controller existence condition.

auxiliary: Help functions and Toolboxes needed for the synthesis project (by Christian Hoffmann)

