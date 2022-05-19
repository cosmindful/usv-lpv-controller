function [CLLFR] = LFTLPV_OFsyn_SQLF_existence(argPLFR, argnu, argne, GeneralizedMultiplierType, CLLFRInit, argSDPoptions)

% -------------------------------------------------------------------------
% function : LFTLPV_OFsyn_SQLF_existence
% -------------------------------------------------------------------------
% Author   : Christian Hoffmann
% Version  : July, 16th 2013
% Copyright: 2013
% -------------------------------------------------------------------------
% Syntax   : [CLLFR] = ...
%             LFTLPV_OFsyn_SQLF_existence(PLFR                         , ...
%                                         nu                           , ...
%                                         ne                           , ...
%                                         GeneralizedMultiplierType    , ...
%                                         argSDPoptions)
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
                              PiSQ      ] = formulateLMI_multiplierConstraintsDG(DeltaBlock); % dB was fixed here at 1e-5
                          
            case 'BlockDG'
            [MultiplierConstraints, ...
                              PiRR, ...
                              PiRS, ...
                              PiRQ, ...
                              PiSR, ...
                              PiSS, ...
                              PiSQ      ] = formulateLMI_multiplierConstraintsBlockDG(DeltaBlock);
                          
            case 'FBSP'
            try
                QSRMask = CLLFRInit.QSRMask;
            catch
                disp(sprintf('No multiplier mask specified. Using full-block multipliers.\n'));
                QSRMask = [];
            end
            [MultiplierConstraints, ...
                              PiRR, ...
                              PiRS, ...
                              PiRQ, ...
                              PiSR, ...
                              PiSS, ...
                              PiSQ      ] = formulateLMI_multiplierConstraintsFBSP(DeltaBlock, QSRMask, dB);
                          
           case '2FBSP'
            try
                QSRMask = CLLFRInit.QSRMask;
            catch
                disp(sprintf('No multiplier mask specified. Using full-block multipliers.\n'));
                QSRMask = [];
            end
            [MultiplierConstraints, ...
                              PiRR, ...
                              PiRS, ...
                              PiRQ, ...
                              PiSR, ...
                              PiSS, ...
                              PiSQ      ] = formulateLMI_multiplierConstraints2FBSP(DeltaBlock, QSRMask, dB);  
                                      
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
     LMIR  = symmetrifyLMI( LMIR);
     LMIS  = symmetrifyLMI( LMIS);
    LMIRS  = symmetrifyLMI(LMIRS);

%% Solve system of LMIs
    %% Initialize Optimization and Constraint Sets
    Optimization = gama + ...
                   argSDPoptions.lyapMatPenalty*trace(R); %+ 1e-6*alpha + 1e-5*trace(R);

    Constraints  = MultiplierConstraints;
    Constraints  = [Constraints,   LMIR  <=  -dB*I(size(LMIR))];
    Constraints  = [Constraints,   LMIS  <=  -dB*I(size(LMIS))];
    Constraints  = [Constraints,  LMIRS  >=   dB*I(size(LMIRS))];
    Constraints  = [Constraints,      R  >=   dB*I(size(R))];
    Constraints  = [Constraints,      S  >=   dB*I(size(S))];
    Constraints  = [Constraints,   gama  >=   dB*I(size(gama))];

    %% Initial Conditions
    SDPoptions.usex0 = 1;
    try
        assign(R   , CLLFRInit.Ropt);
        assign(S   , CLLFRInit.Sopt);
        assign(PiR , CLLFRInit.PiRopt);
        assign(PiS , CLLFRInit.PiSopt);
        assign(gama, CLLFRInit.gamProj);
    catch
        disp(sprintf('No initial solution provided. Letting the solver initialize.'));
    end
    
    
    tic    
    solution  = solvesdp(Constraints, Optimization, SDPoptions)
    toc
    
    CLLFR.solution = solution;
    

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
       if strcmp(GeneralizedMultiplierType, 'DG')
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
           
           PiRpermuteScherer = double([ PiRQ  PiRS  ;...
                                        PiRS' PiRR ]);

           PiSpermuteScherer = double([ PiSQ  PiSS  ;...
                                        PiSS' PiSR ]);

           % Necessary?! -> T
           [PiScherer, U, T, N_, Np] = construct_ExtendedMultiplier(PiRpermuteScherer, PiSpermuteScherer, Sizes.nwPth, Sizes.nzPth);

           PM    = PiRpermuteScherer - PiSpermuteScherer^-1;

           Sizes.nwKth = numel(find(eig(PM) < 0));
           Sizes.nzKth = numel(find(eig(PM) > 0));

%            nzKth = rank(Np);
%            nwKth = rank(N_);

           Permute = [ O(Sizes.nzPth, Sizes.nwPth), I(Sizes.nzPth)             , O(Sizes.nzPth, Sizes.nwKth), O(Sizes.nzPth, Sizes.nzKth) ;...
                       O(Sizes.nzKth, Sizes.nwPth), O(Sizes.nzKth, Sizes.nzPth), O(Sizes.nzKth, Sizes.nwKth), I(Sizes.nzKth)              ;...
                       I(Sizes.nwPth)             , O(Sizes.nwPth, Sizes.nzPth), O(Sizes.nwPth, Sizes.nwKth), O(Sizes.nwPth, Sizes.nzKth) ;...
                       O(Sizes.nwKth, Sizes.nwPth), O(Sizes.nwKth, Sizes.nzPth), I(Sizes.nwKth)             , O(Sizes.nwKth, Sizes.nzKth) ];   

           PioptScherer    = Permute * PiScherer * Permute';
           
           CLLFR.Pi = PioptScherer;

           disp(sprintf('Condition number of extended multiplier:  %9.4e', cond(Piopt)));

           %% Construct controller's scheduling policy
           CLLFR.DeltaBlock.THETAK = DeltaBlock.THETAP;

       elseif (strcmp(GeneralizedMultiplierType, 'FBSP') | strcmp(GeneralizedMultiplierType, '2FBSP'))
           Sizes.nzKth = Sizes.nzPth;
           Sizes.nwKth = Sizes.nwPth;
% 
%            PiRpermute = double([ PiRR  PiRS'  ;...              % M
%                                  PiRS  PiRQ ]);
% 
%            PiSpermute = double([ PiSR  PiSS'  ;...              % N
%                                  PiSS  PiSQ ]);
% 
% 
%            Permute = [ I(Sizes.nzPth)             , O(Sizes.nzPth, Sizes.nzKth), O(Sizes.nzPth, Sizes.nwPth), O(Sizes.nzPth, Sizes.nwKth) ;...
%                        O(Sizes.nwPth, Sizes.nzPth), O(Sizes.nwPth, Sizes.nzKth), I(Sizes.nwPth)             , O(Sizes.nwPth, Sizes.nwKth) ;...
%                        O(Sizes.nzKth, Sizes.nzPth), I(Sizes.nzKth)             , O(Sizes.nzKth, Sizes.nwPth), O(Sizes.nzKth, Sizes.nwKth) ;...
%                        O(Sizes.nwKth, Sizes.nzPth), O(Sizes.nwKth, Sizes.nzKth), O(Sizes.nwKth, Sizes.nwPth), I(Sizes.nwKth)              ];
% 
%            Pi = [ PiRpermute                , PiRpermute - PiSpermute^-1 ;...
%                   PiRpermute - PiSpermute^-1, PiRpermute - PiSpermute^-1 ];
% 
%            Piopt    = Permute' * Pi * Permute;
% 
%            CLLFR.Pi = Piopt;
% 
%            disp(sprintf('Condition number of extended multiplier:  %9.4e', cond(Piopt)));
               
        %% Scherer, 2001
           % Q is hit by Delta
           PiRpermuteScherer = double([ PiRQ  PiRS  ;...
                                        PiRS' PiRR ]);

           PiSpermuteScherer = double([ PiSQ  PiSS  ;...
                                        PiSS' PiSR ]);

           [PiScherer, U, T, N_, Np] = construct_ExtendedMultiplier(PiRpermuteScherer, PiSpermuteScherer, Sizes.nwPth, Sizes.nzPth);

           PM    = PiRpermuteScherer - PiSpermuteScherer^-1;

           Sizes.nwKth = numel(find(eig(PM) < 0));
           Sizes.nzKth = numel(find(eig(PM) > 0));

%            nzKth = rank(Np);
%            nwKth = rank(N_);

           Permute = [ O(Sizes.nzPth, Sizes.nwPth), I(Sizes.nzPth)             , O(Sizes.nzPth, Sizes.nwKth), O(Sizes.nzPth, Sizes.nzKth) ;...
                       O(Sizes.nzKth, Sizes.nwPth), O(Sizes.nzKth, Sizes.nzPth), O(Sizes.nzKth, Sizes.nwKth), I(Sizes.nzKth)              ;...
                       I(Sizes.nwPth)             , O(Sizes.nwPth, Sizes.nzPth), O(Sizes.nwPth, Sizes.nwKth), O(Sizes.nwPth, Sizes.nzKth) ;...
                       O(Sizes.nwKth, Sizes.nwPth), O(Sizes.nwKth, Sizes.nzPth), I(Sizes.nwKth)             , O(Sizes.nwKth, Sizes.nzKth) ];   

           PioptScherer    = Permute * PiScherer * Permute';
           Piopt           = PioptScherer;
           [THETAK, MLFRDeltaK, DELTAK, U, V, W]   = construct_controllerSchedulingFunction(PioptScherer, DeltaBlock.THETAP);
           CLLFR.Pi = PioptScherer;


           
           disp(sprintf('Condition number of PiR multiplier:  %9.4e', cond(PiRpermuteScherer)));
           disp(sprintf('Condition number of PiS multiplier:  %9.4e', cond(PiSpermuteScherer)));
           disp(sprintf('Condition number of extended multiplier:  %9.4e', cond(CLLFR.Pi)));

           %% Construct controller's scheduling policy
%                S1DeltaP   = DeltaBlock.THETAP;
%                S2DeltaP   = I(size(S1DeltaP));
% 
%                SDeltaP    = [S1DeltaP; S2DeltaP];
% 
%                V_VpDeltaP = SDeltaP'*U;
%                V_DeltaP   = V_VpDeltaP(:, 1:nwKth    );
%                VpDeltaP   = V_VpDeltaP(:, nwKth+1:end);
% 
%                S1DeltaK   = N_*V_DeltaP' / (SDeltaP' * PiRpermuteScherer * SDeltaP - V_DeltaP*N_*V_DeltaP')^-1 * VpDeltaP;
%                S1DeltaK   = simplify(S1DeltaK, 'full');
%                S2DeltaK   = I(size(S1DeltaK));

               CLLFR.DeltaBlock.THETAK     = THETAK;
               CLLFR.DeltaBlock.MLFRDeltaK = MLFRDeltaK;
               CLLFR.DeltaBlock.DELTAK     = DELTAK;
               CLLFR.DeltaBlock.U          = U;
               CLLFR.DeltaBlock.V          = V;
               CLLFR.DeltaBlock.W          = W;


       end
       
           CLLFR.Sizes.nwKth = size(CLLFR.DeltaBlock.THETAK, 1);
           CLLFR.Sizes.nzKth = size(CLLFR.DeltaBlock.THETAK, 2);
    
        nzB11  = Sizes.nzPth + Sizes.nzKth; size(CLLFR.Pi, 2)/2;
        PiRopt = CLLFR.Pi(                 (1):(nzB11),             (1):(nzB11));
        PiSopt = CLLFR.Pi(           (nzB11+1):(end  ),             (1):(nzB11));
        PiQopt = CLLFR.Pi(           (nzB11+1):(end  ),       (nzB11+1):(end  ));

        CLLFR.PiRCheck  = double([ PiRQ  , PiRS  ;...
                                   PiRS' , PiRR  ]);
                  
        CLLFR.PiSCheck  = double([ PiSQ  , PiSS  ;...
                                   PiSS' , PiSR  ]);

   
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
   
    CLLFR.CompTime    =  solution.solvertime;
    CLLFR.DecVars     =  max(getvariables(Constraints));
    
    CLLFR.LMISize     =  0;
    LMIids = getlmiid(Constraints);
    for ii = 1:numel(LMIids)
        CLLFR.LMISize = CLLFR.LMISize + size(double(Constraints(LMIids(ii))), 1);
    end
    
    CLLFR.Gamma       =  double(gama);
end % function

