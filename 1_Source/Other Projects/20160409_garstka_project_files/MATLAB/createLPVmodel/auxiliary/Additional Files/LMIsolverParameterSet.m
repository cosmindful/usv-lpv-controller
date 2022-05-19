function SDPoptions = LMISolverParameterSet(argSet)


switch argSet
    
    case 1
%% Used for the elimination lemma based step
    SDPoptions = sdpsettings('savesolveroutput', 1, ...
                             'savesolverinput' , 1, ...
                             'verbose'         , 1, ...
                             'solver'          ,'sdpt3');
                         
	SDPoptions.specRadPenalty       = 1e-4;
    SDPoptions.lyapMatPenalty       = 1e-8;
    SDPoptions.dB                   = 1e-3;
                          
	SDPoptions.sdpt3.rmdepconstr    = 1;
% 	SDPoptions.sdpt3.allownonconvex = 0;
    SDPoptions.sdpt3.maxit          = 100;
    SDPoptions.sdpt3.gaptol         = 1e-5;
    SDPoptions.sdpt3.inftol         = 1e-9;
    SDPoptions.sdpt3.steptol        = 1e-4;
% %     SDPoptions.sdpt3.gaptol         = 1e-3;
% %     SDPoptions.sdpt3.inftol         = 1e-9;
% %     SDPoptions.sdpt3.steptol        = 1e-2;
    SDPoptions.radius = 1e5;
%     SDPoptions.sdpt3.scale_data     = 1;
%     SDPoptions.sedumi.eps       = 1e-2;
%     SDPoptions.sedumi.bigeps    = 1e-1;


    case 2
%% Used for the controller construction step for 2DOF robot and PSM
    SDPoptions = sdpsettings('savesolveroutput', 1, ...
                             'savesolverinput' , 1, ...
                             'verbose'         , 1, ...
                             'solver'          ,'sdpt3');
                         
	SDPoptions.specRadPenalty       = 1e-3;
    SDPoptions.dB                   = 1e-12;

	SDPoptions.sdpt3.rmdepconstr    = 1;
	SDPoptions.sdpt3.allownonconvex = 0;
    SDPoptions.sdpt3.maxit          = 100;
    SDPoptions.sdpt3.gaptol         = 1e-5;
    SDPoptions.sdpt3.inftol         = 1e-9;
    SDPoptions.sdpt3.steptol        = 1e-2;
    SDPoptions.sedumi.maxradius     = 1e7;
%     SDPoptions.sdpt3.gaptol         = 1e-9;
%     SDPoptions.sdpt3.inftol         = 1e-9;
%     SDPoptions.sdpt3.steptol        = 1e-7;
%     SDPoptions.sdpt3.predcorr = 1;
    SDPoptions.radius = 1e9;
%     SDPoptions.sdpt3.scale_data     = 1;
    SDPoptions.sedumi.eps       = 1e-2;
    SDPoptions.sedumi.bigeps    = 1e-1;
    
    SDPoptions.lmilab.reltol    = 1e-2;      % rel. accuracy
    SDPoptions.lmilab.maxiter   = 1e2;       % max. iter.
    SDPoptions.lmilab.radius    = 1e6;       % feasp. rad.
    SDPoptions.lmilab.steptol   = 0;         % step tol.
    SDPoptions.lmilab.verbose   = 0;         % verbose
end
