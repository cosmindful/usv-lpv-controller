% -------------------------------------------------------------------------
% script   : LPV_LFT_Synthesis
% -------------------------------------------------------------------------
% Author   : Christian Hoffmann
% Version  : July, 16th 2013
% Copyright: CH, 2013
% -------------------------------------------------------------------------
%
% 1. Model the plant
% 2. Perform approximation via PSM
% 3. Generate generalized plant
% 4. Synthesis controller based on approximate plant
% 5. Perform analysis/synthesis iteration based on original plant
%
% -------------------------------------------------------------------------
%% Initialization
clc;clear all;close all;warning off
s  = tf('s');

% Add subdirectories to path
addpath(genpath('.'))

% Add LMI solver tools (like YALMIP, SDPT3, etc.) to path
addpath(genpath('D:\Tools\Toolboxes\LMI Solvers'))

% Add helper functions to path
addpath(genpath('D:\Projects\Research\Matlab Generics'))

thisdate = datestr(now,'yyyy-mm-dd_HH-MM');

%% Simple Engine Model
SIEngineModel;

%% 2DOF Robot Model
robot_2DOFLFTModel;

%% Existence Condition
    [CLLFR]         = min_gamma_over_RSPi( PLFR_Ntheta, nu, ny, 'DG', LMIsolverParameterSet(1));
%% Controller Construction
    [KLFR, CLLFR]   = min_gamma_over_K( PLFR_Ntheta, KLFRmask, CLLFR, nu, ny, LMIsolverParameterSet(2));
    
     KLFR_sim = model_struct2uss(KLFR);
    dKLFR_sim = uc2d(KLFR_sim, 0.001, 'tustin');
    dKLFR_sim = model_uss2struct(dKLFR_sim, ny, nu);