%% Controller Synthesis for a Two-Degrees of Freedom Robotic Manipulator
% -------------------------------------------------------------------------
% script   : Exercise_Robot_LPV_Synthesis
% -------------------------------------------------------------------------
% Author   : Christian Hoffmann
% Version  : August, 2nd 2013
% Copyright: CH, 2013
% -------------------------------------------------------------------------
%
% 1. Model the plant as noth reduced scheduling order polytopic LPV model
%    and as a full order LFT model
% 2. Generate generalized plant
% 3. Synthesize controller
%
% -------------------------------------------------------------------------
%% Initialization
clc;clear all;close all;warning off;s  = tf('s');

% Add subdirectories to path
addpath(genpath('.'))

thisdate = datestr(now, 'yyyy-mm-dd_HH-MM');

%% Modeling of the Robot both as a Polytopic/Reduced Scheduling Order and 
%  LFT LPV model
Robot_2DOFModel;

%% Polytopic LPV Synthesis
Robot_PolytopicSynthesis;