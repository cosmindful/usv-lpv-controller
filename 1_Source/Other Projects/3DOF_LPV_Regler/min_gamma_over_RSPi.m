function [CLLFR] = min_gamma_over_RSPi(argPLFR, argnu, argne, GeneralizedMultiplierType, argSDPoptions)

% -------------------------------------------------------------------------
% function : min_gamma_over_RSPi
% -------------------------------------------------------------------------
% Author   : Christian Hoffmann
% Version  : July, 16th 2013
% Copyright: 2013
% -------------------------------------------------------------------------
% Syntax   : [CLLFR] = ...
%             min_gamma_over_RSPi(PLFR                         , ...
%                                 nu                           , ...
%                                 ne                           , ...
%                                 GeneralizedMultiplierType    , ...
%                                 argSDPoptions)
% -------------------------------------------------------------------------
%
% Solve projected LMI conditions as solvability conditions for synthesizing
% a gain scheduled LPV-LFT controller based on parameter-independent
% Lyapunov functions.
% [Scherer, "LPV control and full block multipliers, 2001]
% 
% Input the plant as an uncertain state-space model.
% 
% Currently only D/G-scalings are implemented.
% 
%      P:                           
%                |    (nxP)    (nwPth) (nwPp)   (nu)  
%                |     x        wPth    wPth      u   
%          ------+---------------------------------------
%     (nxP) x    |     AP     [BP_th    BP_p     BP_u  ]
%    (nzPp) zPth |   [CP_th]  [DP_thth  DP_thp   DP_thu]
%   (nzPth) zPp  |   [CP_p ]  [DP_pth   DP_pp    DP_pu ]
%      (ne) e    |   [CP_e ]  [DP_eth   DP_ep    DP_eu ]
% 
% -------------------------------------------------------------------------

%% YALMIP Initialization
yalmip('clear');

%% Artifical "definitness" bound away from zero
% dB = 1e-18; 

%% Input Argument Validation
[modelType] = validate_inputArguments(argPLFR);

%% Extract model matrices
if strcmp(modelType, 'uss')
    [  Matrices, ...
          Sizes, ...
     DeltaBlock] = formulateLMI_plantMatrices(argPLFR, ...
                                              argnu  , ...
                                              argne         );
elseif strcmp(modelType, 'struct')
         Matrices = argPLFR.Matrices;
            Sizes = argPLFR.Sizes;
       DeltaBlock = argPLFR.DeltaBlock;
end
    
%% Build augmented matrices
[     BRaug, ...
      BSaug, ...
         BR, ...
         BS] = formulateLMI_outerFactorsExistenceConditionNullspace(Matrices);


%% LMI Variable Definitions

    % Define projected Lyapunov matrices
    R     = sdpvar(Sizes.nxP  , Sizes.nxP  , 'symmetric');
    S     = sdpvar(Sizes.nxP  , Sizes.nxP  , 'symmetric');

    RR = [ O(Sizes.nxP), R            ;...
                      R, O(Sizes.nxP) ];

    SS = [ O(Sizes.nxP), S            ;...
                      S, O(Sizes.nxP) ];

    % Define IQC performance specification
    gama  = sdpvar(1, 1);

    QpR  = -gama*eye(Sizes.nwPp);
    QpS  = -gama*eye(Sizes.nzPp);
    RpR  = -gama*eye(Sizes.nzPp);
    RpS  = -gama*eye(Sizes.nwPp);



%% Define multipliers
    switch GeneralizedMultiplierType
            case 'DG'
            [MultiplierConstraints, ...
                              PiRR, ...
                              PiRS, ...
                              PiRQ, ...
                              PiSR, ...
                              PiSS, ...
                              PiSQ      ] = formulateLMI_multiplierConstraintsDG(DeltaBlock);
                          
            case 'FBSP'
            [MultiplierConstraints, ...
                              PiRR, ...
                              PiRS, ...
                              PiRQ, ...
                              PiSR, ...
                              PiSS, ...
                              PiSQ      ] = formulateLMI_multiplierConstraintsFBSP(DeltaBlock);  
                                      
    end
    
    PiR  = [ PiRR  , PiRS' ;...
             PiRS  , PiRQ  ];
  
    PiS  = [-PiSQ  ,  PiSS ;...
             PiSS' , -PiSR ];

%% Define LMIs
        MR.ThXP  = mdiag( PiR , RR, QpR  );
        MS.ThXP  = mdiag( PiS , SS, QpS  );
        MR.P     = RpR;
        MS.P     = RpS;

    % Projected LMIs
        LMIR = [ BRaug.MThXP' * MR.ThXP * BRaug.MThXP, BRaug.MP' ;...
                 BRaug.MP                            , MR.P      ];
     
        LMIS = [ BSaug.MThXP' * MS.ThXP * BSaug.MThXP, BSaug.MP' ;...
                 BSaug.MP                            , MS.P      ];
       
        % Coupling condition for Lyapunov matrix
        LMIRS  = [ R             , I(Sizes.nxP) ;...
                   I(Sizes.nxP)  , S            ];
    
    
    %% Symmetrify LMIs
     LMIR  = symmetrify( LMIR);
     LMIS  = symmetrify( LMIS);
    LMIRS  = symmetrify(LMIRS);

    %% Prepare solver and optimization criteria
    %% Solver options
    SDPoptions = sdpsettings('savesolveroutput', 1, ...
                             'savesolverinput' , 1, ...
                             'verbose'         , 1, ...
                             'solver'          ,'sdpt3');
                         
    if (~isempty(argSDPoptions))
        SDPoptions = argSDPoptions;
        dB = argSDPoptions.dB;
    else
        SDPoptions.sdpt3.rmdepconstr    = 1;
        SDPoptions.sdpt3.allownonconvex = 0;
        SDPoptions.sdpt3.maxit          = 100;
        SDPoptions.sdpt3.gaptol         = 1e-9;
        SDPoptions.sdpt3.inftol         = 1e-9;
        SDPoptions.sdpt3.steptol        = 1e-7;
        SDPoptions.radius               = 1e6;
        SDPoptions.sdpt3.scale_data     = 1;

        SDPoptions.sedumi.eps       = 1e-9;
        SDPoptions.sedumi.bigeps    = 1e-3;
        SDPoptions.sedumi.alg       = 2;
        SDPoptions.sedumi.sdp       = 2;
        SDPoptions.sedumi.maxradius = 1e6;
    end


%% Solve system of LMIs
    %% Initialize Optimization and Constraint Sets
    Optimization = gama + ...
                   argSDPoptions.lyapMatPenalty*trace(R); %+ 1e-6*alpha + 1e-5*trace(R);

    Constraints  = MultiplierConstraints;
    Constraints  = [Constraints,   LMIR  <=  -dB];
    Constraints  = [Constraints,   LMIS  <=  -dB];
    Constraints  = [Constraints,  LMIRS  >=   dB];
    Constraints  = [Constraints,      R  >=   dB];
    Constraints  = [Constraints,      S  >=   dB];
    Constraints  = [Constraints,   gama  >=   dB];


    tic    
    solution  = solvesdp(Constraints, Optimization, SDPoptions)
    toc
    

    
    % Evaluate solution
        gopt = double(gama);
        disp(sprintf('Optimal quadratic RMS performance:  %9.4e\n ------------------------------------------',gopt));
    
%% Evaluate solution
    if ~isempty(gopt),
       CLLFR.gamProj = gopt;
    else
       gopt = gamma_init;
       disp(sprintf('Optimal quadratic RMS performance: Infeasible!'));
       return
    end
    
       Ropt          = double(R);
       Sopt          = double(S);
       PiRopt        = double(PiR);
       PiSopt        = double(PiS);
       CLLFR.PiRopt  = PiRopt;
       CLLFR.PiSopt  = PiSopt;
       CLLFR.Ropt    = Ropt;
       CLLFR.Sopt    = Sopt;
       
       Yopt          = construct_ClosedLoopLyapunovMatrix(Ropt, Sopt);
       CLLFR.Y       = Yopt;

       %% Construct closed-loop multiplier (ala Scherer)
       switch GeneralizedMultiplierType

        case 'DG'
        %% Köse, Scherer, 2006
           Sizes.nzKth = Sizes.nzPth;
           Sizes.nwKth = Sizes.nwPth;

           PiRpermute = double([ PiRR  PiRS'  ;...              % M
                                 PiRS  PiRQ ]);

           PiSpermute = double([ PiSR  PiSS'  ;...              % N
                                 PiSS  PiSQ ]);


           Permute = [ I(Sizes.nzPth)             , O(Sizes.nzPth, Sizes.nzKth), O(Sizes.nzPth, Sizes.nwPth), O(Sizes.nzPth, Sizes.nwKth) ;...
                       O(Sizes.nwPth, Sizes.nzPth), O(Sizes.nwPth, Sizes.nzKth), I(Sizes.nwPth)             , O(Sizes.nwPth, Sizes.nwKth) ;...
                       O(Sizes.nzKth, Sizes.nzPth), I(Sizes.nzKth)             , O(Sizes.nzKth, Sizes.nwPth), O(Sizes.nzKth, Sizes.nwKth) ;...
                       O(Sizes.nwKth, Sizes.nzPth), O(Sizes.nwKth, Sizes.nzKth), O(Sizes.nwKth, Sizes.nwPth), I(Sizes.nwKth)              ];

           Pi = [ PiRpermute                , PiRpermute - PiSpermute^-1 ;...
                  PiRpermute - PiSpermute^-1, PiRpermute - PiSpermute^-1 ];

           Piopt    = Permute' * Pi * Permute;

           CLLFR.Pi = Piopt;

           disp(sprintf('Condition number of extended multiplier:  %9.4e', cond(Piopt)));

           %% Construct controller's scheduling policy - in the case of DG 
           %  scalings it can be simply chosen as a copy of the plant's
           %  scheduling block.
           CLLFR.DeltaBlock.THETAK = DeltaBlock.THETAP;

           otherwise
           Sizes.nzKth = Sizes.nzPth;
           Sizes.nwKth = Sizes.nwPth;

           PiRpermute = double([ PiRR  PiRS'  ;...              % M
                                 PiRS  PiRQ ]);

           PiSpermute = double([ PiSR  PiSS'  ;...              % N
                                 PiSS  PiSQ ]);


           Permute = [ I(Sizes.nzPth)             , O(Sizes.nzPth, Sizes.nzKth), O(Sizes.nzPth, Sizes.nwPth), O(Sizes.nzPth, Sizes.nwKth) ;...
                       O(Sizes.nwPth, Sizes.nzPth), O(Sizes.nwPth, Sizes.nzKth), I(Sizes.nwPth)             , O(Sizes.nwPth, Sizes.nwKth) ;...
                       O(Sizes.nzKth, Sizes.nzPth), I(Sizes.nzKth)             , O(Sizes.nzKth, Sizes.nwPth), O(Sizes.nzKth, Sizes.nwKth) ;...
                       O(Sizes.nwKth, Sizes.nzPth), O(Sizes.nwKth, Sizes.nzKth), O(Sizes.nwKth, Sizes.nwPth), I(Sizes.nwKth)              ];

           Pi = [ PiRpermute                , PiRpermute - PiSpermute^-1 ;...
                  PiRpermute - PiSpermute^-1, PiRpermute - PiSpermute^-1 ];

           Piopt    = Permute' * Pi * Permute;

           CLLFR.Pi = Piopt;

           disp(sprintf('Condition number of extended multiplier:  %9.4e', cond(Piopt)));
               
        %% Scherer, 2001
           % This is an experimental implementation and not to be trusted
           % easily... :)
           PiRpermuteScherer = double([ PiRQ  PiRS  ;...
                                        PiRS' PiRR ]);

           PiSpermuteScherer = double([ PiSQ  PiSS  ;...
                                        PiSS' PiSR ]);

           [PiScherer, U, T, N_, Np] = construct_ExtendedMultiplier(PiRpermuteScherer, PiSpermuteScherer);

           PM    = PiRpermuteScherer - PiSpermuteScherer^-1;

           Sizes.nwKth = numel(find(eig(PM) < 0));
           Sizes.nzKth = numel(find(eig(PM) > 0));

           nzKth = rank(Np);
           nwKth = rank(N_);

           Permute = [ O(Sizes.nzPth, Sizes.nwPth), I(Sizes.nzPth)             , O(Sizes.nzPth, Sizes.nwKth), O(Sizes.nzPth, Sizes.nzKth) ;...
                       O(Sizes.nzKth, Sizes.nwPth), O(Sizes.nzKth, Sizes.nzPth), O(Sizes.nzKth, Sizes.nwKth), I(Sizes.nzKth)              ;...
                       I(Sizes.nwPth)             , O(Sizes.nwPth, Sizes.nzPth), O(Sizes.nwPth, Sizes.nwKth), O(Sizes.nwPth, Sizes.nzKth) ;...
                       O(Sizes.nwKth, Sizes.nwPth), O(Sizes.nwKth, Sizes.nzPth), I(Sizes.nwKth)             , O(Sizes.nwKth, Sizes.nzKth) ];   

           PioptScherer    = Permute * PiScherer * Permute';
           
           THETAK   = construct_controllerSchedulingFunction(PioptScherer, DeltaBlock.THETAP);
           CLLFR.Pi = PioptScherer;

           disp(sprintf('Condition number of extended multiplier:  %9.4e', cond(CLLFR.Pi)));

           %% Construct controller's scheduling policy
           CLLFR.DeltaBlock.THETAK = THETAK;


       end
    
        nzB11  = size(CLLFR.Pi, 2)/2;
        PiRopt = CLLFR.Pi(                 (1):(nzB11),             (1):(nzB11));
        PiSopt = CLLFR.Pi(           (nzB11+1):(end  ),             (1):(nzB11));
        PiQopt = CLLFR.Pi(           (nzB11+1):(end  ),       (nzB11+1):(end  ));

   
%     KLFRclosedForm = construct_ControllerClosedFormSolution(argPLFR, Ropt, Sopt, gopt, nu, ne);
   KLFRclosedForm = [];

   %% Construct closed-loop Lyapunov matrix

   if (sum(eig(double(LMIR)) > 0) + sum(eig(double(LMIS)) > 0) > 0)
      disp(sprintf('Eigenvalues not trustworthy, maximum eigenvalue:  %9.4e', max([eig(double(LMIR)); eig(double(LMIS))])));
   end
   disp(sprintf('Optimal quadratic RMS performance  :  %9.4e                                             ',gopt)                 );
   disp(sprintf('          Maximum eigenvalue of Y  :  %9.4e                                             ',max(eig(Yopt)))       );
   disp(sprintf('            Condition number of PiR:  %9.4e                                             ',cond(PiRopt))         );
   disp(sprintf('          Maximum eigenvalue of PiR:  %9.4e                                             ',max(eig(PiRopt)))     );
   disp(sprintf('          Minimum eigenvalue of PiR:  %9.4e                                             ',min(eig(PiRopt)))     );
   disp(sprintf('          Maximum eigenvalue of Pi :  %9.4e\n ------------------------------------------',max(eig(abs(Piopt)))) );
end % function

