function [KLFR, CLLFR] = min_gamma_over_K(argPLFR, argKLFR, argCLLFR, argnu, argne, argSDPoptions)
% -------------------------------------------------------------------------
% function : min_gamma_over_K
% -------------------------------------------------------------------------
% Author   : Christian Hoffmann
% Version  : July, 16th 2013
% Copyright: 2013
% -------------------------------------------------------------------------
% Syntax   : [KLFR, CLLFR] = min_gamma_over_K_multiModel ...
%                                     (argPLFR                      , ...
%                                      argCLLFR                     , ...
%                                      nu                           , ...
%                                      ny                           , ...
%                                      argSDPoptions                )
% -------------------------------------------------------------------------
%
% Solve LMI conditions with extended multiplier for controller parameters
% in order to synthesize a gain scheduled LPV-LFT controller based on 
% parameter-independent Lyapunov functions.
% 
% -------------------------------------------------------------------------

%% YALMIP Initialization
yalmip('clear');

%% Input Argument Validation
[modelType] = validate_inputArguments(argPLFR);

%% Extract model matrices
[  Matrices, ...
      Sizes, ...
 DeltaBlock] = formulateLMI_plantMatrices(argPLFR, ...
                                          argnu  , ...
                                          argne        );
                                                  
%% Define controller variables
%% Variables
Sizes.nxK    = Sizes.nxP  ;
Sizes.nwKth  = Sizes.nwPth;
Sizes.nzKth  = Sizes.nzPth;
Sizes.nzPKth = Sizes.nzPth + Sizes.nzKth;
Sizes.nwPKth = Sizes.nwPth + Sizes.nwKth;

Matrices.AK      = sdpvar(Sizes.nxK   , Sizes.nxK   , 'full');
Matrices.BK_y    = sdpvar(Sizes.nxK   , Sizes.ne    , 'full');
Matrices.CK_u    = sdpvar(Sizes.nu    , Sizes.nxK   , 'full');
Matrices.DK_uy   = sdpvar(Sizes.nu    , Sizes.ne    , 'full');
Matrices.BK_th   = sdpvar(Sizes.nxK   , Sizes.nwKth , 'full');
Matrices.DK_uth  = sdpvar(Sizes.nu    , Sizes.nwKth , 'full');
Matrices.DK_thy  = sdpvar(Sizes.nzKth , Sizes.ne    , 'full');
Matrices.CK_th   = sdpvar(Sizes.nzKth , Sizes.nxK   , 'full');
Matrices.DK_thth = sdpvar(Sizes.nzKth , Sizes.nwKth , 'full');

Matrices.AK      = maskMat(Matrices.AK     ,  argKLFR.A      );
Matrices.BK_y    = maskMat(Matrices.BK_y   ,  argKLFR.B_u    );
Matrices.CK_u    = maskMat(Matrices.CK_u   ,  argKLFR.C_y    );
Matrices.DK_uy   = maskMat(Matrices.DK_uy  ,  argKLFR.D_yu   );
Matrices.BK_th   = maskMat(Matrices.BK_th  ,  argKLFR.B_th   );
Matrices.DK_uth  = maskMat(Matrices.DK_uth ,  argKLFR.D_yth  );
Matrices.DK_thy  = maskMat(Matrices.DK_thy ,  argKLFR.D_thu  );
Matrices.CK_th   = maskMat(Matrices.CK_th  ,  argKLFR.C_th   );
Matrices.DK_thth = maskMat(Matrices.DK_thth,  argKLFR.D_thth );


%% Build augmented matrices
[     BXaug, ...
         BX] = formulateLMI_outerFactorsClosedLoopMatrices(Matrices, ...
                                                                          Sizes);

%% Obtain solutions from existence condition
         Pi  = argCLLFR.Pi;
         XX  = argCLLFR.Y;
    gamProj  = argCLLFR.gamProj;

       XXXX   = [ O(Sizes.nxP+Sizes.nxK)     , XX                     ;...
                  XX                         , O(Sizes.nxP+Sizes.nxK) ];
                          
        PiR       = Pi(                         (1):(Sizes.nzPKth),                          (1):(Sizes.nzPKth));
        PiS       = Pi(                         (1):(Sizes.nzPKth), (Sizes.nzPKth+1):(end                     ));
        PiS       = PiS';
        PiQ       = Pi((Sizes.nzPKth+1):(end                     ), (Sizes.nzPKth+1):(end                     ));

%% New performance decision variables
    % Bound on the controller's spectral radius
    alpha  =    sdpvar(1, 1);

    % Define IQC performance specification
     gama  =    sdpvar(1, 1);

       Qp  =   -gama*eye(Sizes.nwPp);
       Rp  =  1/gama*eye(Sizes.nzPp);
      Rpt  =   -gama*eye(Sizes.nzPp);

%% LMI construction
    LMIschur  = BXaug.MPiR'*  PiS' *BXaug.MPiQ + ...
                BXaug.MPiQ'*  PiS  *BXaug.MPiR + ...
                BXaug.MPiQ'*  PiQ  *BXaug.MPiQ + ...
                BXaug.MXX' * XXXX  *BXaug.MXX  + ...
                BXaug.MQp' *   Qp  *BXaug.MQp;


    LMIschurL = [BXaug.MPiR; BXaug.MRp];

    LMIDinv   = mdiag(-PiR^-1, Rpt);

    LMI       = [  LMIschur, LMIschurL' ;...
                  LMIschurL,   LMIDinv  ];

    LMI       = symmetrify(LMI);

    LMIspec   = [ alpha*I(Sizes.nxK),    Matrices.AK        ;...
                  Matrices.AK'      ,    alpha*I(Sizes.nxK) ];
              
%% Prepare solver and optimization criteria

% Solver options
                        
    if (~isempty(argSDPoptions))
        SDPoptions = argSDPoptions;
        dB = argSDPoptions.dB;
    else
        SDPoptions = sdpsettings('savesolveroutput', 1, ...
                                 'savesolverinput' , 1, ...
                                 'verbose'         , 1, ...
                                 'solver'          ,'sdpt3');              
    end
                             
%% LMI construction
    LMI  = symmetrify(LMI);

    Optimization = gama + argSDPoptions.specRadPenalty*alpha;
    Constraints  = [             LMI            <=  -dB];
    Constraints  = [Constraints, gama           >=   dB];
    Constraints  = [Constraints, LMIspec        >=   dB];

    % Solve system of LMIs
    tic
    solution  = solvesdp(Constraints, Optimization, SDPoptions)
    toc

%% Evaluate solution
    gopt = double(gama);
    aopt = double(alpha);
    
    % Evaluate solution
    if ~isempty(gopt),
        
        KLFR.A       = double(Matrices.AK);
        KLFR.B_u     = double(Matrices.BK_y);
        KLFR.C_y     = double(Matrices.CK_u);
        KLFR.D_yu    = double(Matrices.DK_uy);
        KLFR.B_th    = double(Matrices.BK_th);
        KLFR.D_thth  = double(Matrices.DK_thth);
        KLFR.D_yth   = double(Matrices.DK_uth);
        KLFR.D_thu   = double(Matrices.DK_thy);
        KLFR.C_th    = double(Matrices.CK_th);
        KLFR.THETA   = argCLLFR.DeltaBlock.THETAK;
        
       disp(sprintf('Optimal quadratic RMS performance:  %9.4e'   , gopt));
       disp(sprintf('Optimal bound on AKs spectral radius:  %9.4e', aopt));

    else
       gopt = gamma_init;
       disp(sprintf('Optimal quadratic RMS performance: Infeasible!'));
       return
    end  

    CLLFR        = argCLLFR;
    CLLFR.Pi     = Pi;
    CLLFR.gamK   = gopt;
    CLLFR.aopt   = aopt;
end % function