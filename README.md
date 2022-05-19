# USV LPV Controller

## Introduction

This work presents a methodological way for developing an autonomous sailing scheme for a large-size vessel (oil tanker, 300 m, 19 000 dwt). Starting from the equations of motion governing the vessel’s dynamics, an affine state-space form is obtained and used for developing different controllers. The control task is following a custom-created, optimised and time-dependent path and comparing the performance of various controllers that were synthesised using modern or classical control techniques. The aim is making vessel autonomously navigate through a series of waypoints, in a certain time interval.

If you would like to include this work into your own, please cite the following source:
```text
@article{deleadesign,
  title={Design and Implementation of a Robust Controller for Autonomous Surface Vehicles},
  author={Delea, Cosmin and Oeffner, Johannes}
}
```

## Installation

The controller synthesis is done in Matlab, while Simulation of the modelled ship is done in Simulink. You need versions of Matlab/Simulink from at least 2015 and the following toolboxes:
* Control System Toolbox
* DSP System Toolbox               
* System Identification Toolbox
* Robust Control Toolbox

For the Guidance module, there are some custom tools used, such as [plot_google_maps](https://www.mathworks.com/matlabcentral/fileexchange/27627-zoharby-plot_google_map) or [circlem](https://www.mathworks.com/matlabcentral/fileexchange/48122-circlem), all of which are contained in `Imported Functions`.

## Usage

Presuming you want to run and check if the code is really working, than everything you need is in the **C_Simulation** folder. This is because the synthesis results have been saved into the `Data` folder, so that you don't need to re-run the synthesis again. Here are the require steps:
1. Open the desired simulation in *Simulink* (it automatically loads the required data from `Data` folder
1. Output is saved as timeseries in `.mat` files
1. Open `visualiseSimulinkData.m` and plot the data obtained (comment out older simulation data loading)
1. Enjoy!

For enhancing the controllers, use the design files in `B_Control>Modeling>*`

For aggrandising the trajectory generator, use the design files in `A_Guidance>TrajectoryGenerator.m`


