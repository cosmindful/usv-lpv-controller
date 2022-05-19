function M_evalgrid = model_struct_lftOnGrid(Delta_grid, MLFR)

ngrid = numel(Delta_grid);
fprintf('Evaluating %d gridpoints.\n', ngrid);

argMatrices = MLFR.Matrices;

    AP      = argMatrices.AP;
    BP_p    = argMatrices.BP_p;
    BP_th   = argMatrices.BP_th;
    BP_u    = argMatrices.BP_u;
    CP_p    = argMatrices.CP_p;
    CP_th   = argMatrices.CP_th;
    CP_y    = argMatrices.CP_y;
    DP_pp   = argMatrices.DP_pp; 
    DP_pth  = argMatrices.DP_pth;
    DP_pu   = argMatrices.DP_pu;
    DP_thp  = argMatrices.DP_thp;
    DP_thth = argMatrices.DP_thth;
    DP_thu  = argMatrices.DP_thu;
    DP_yp   = argMatrices.DP_yp;
    DP_yth  = argMatrices.DP_yth;
    DP_yu   = argMatrices.DP_yu;
    
    GR.M11 = [ DP_thth ];
    GR.M12 = [ CP_th             DP_thp ];
    GR.M21 = [ BP_th           ;...
               DP_pth          ];

    SS.a = AP;
    SS.b = [BP_th          BP_p           BP_u];
    SS.c = [CP_th;...
            CP_p ;...
            CP_y ];
    SS.d = [DP_thth        DP_thp         DP_thu ;...
            DP_pth         DP_pp          DP_pu  ;...
            DP_yth         DP_yp          DP_yu  ];

SS = ss(SS.a, SS.b, SS.c, SS.d);

kk = 0;
for ii = 1:ngrid
    if (kk < floor(ii/100))
        kk = kk + 1;
        fprintf('.');
    end
    M_evalgrid{ii} = lft(Delta_grid{ii}, SS);
end