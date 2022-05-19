function dPLFR = uc2d(argPLFR, Ts, method);

    [M_PLFR  , Theta_PLFR  , Blkstruct_PLFR  , Normunc_PLFR] = lftdata(argPLFR);

    nxP   = size(argPLFR.a    , 1);
    nzPth = size(Theta_PLFR   , 2);
    nwPth = size(Theta_PLFR   , 1);
    nwPu  = size(argPLFR.b    , 2);
    nzPy  = size(argPLFR.c    , 1);

    PLFR.A       = M_PLFR.a((           1):(nxP          ),(           1):(nxP          ));
    PLFR.B_th    = M_PLFR.b((           1):(nxP          ),(           1):(nwPth        ));
    PLFR.B_u     = M_PLFR.b((           1):(nxP          ),(nwPth     +1):(nwPth+nwPu   ));
    PLFR.D_thth  = M_PLFR.d((           1):(nzPth        ),(           1):(nwPth        ));
    PLFR.D_thu   = M_PLFR.d((           1):(nzPth        ),(nwPth     +1):(nwPth+nwPu   ));
    PLFR.D_yth   = M_PLFR.d((nzPth     +1):(nzPth+nzPy   ),(           1):(nwPth        ));
    PLFR.D_yu    = M_PLFR.d((nzPth     +1):(nzPth+nzPy   ),(nwPth     +1):(nwPth+nwPu   ));
    PLFR.C_th    = M_PLFR.c((           1):(nzPth        ),(           1):(nxP          ));
    PLFR.C_y     = M_PLFR.c((nzPth     +1):(nzPth+nzPy   ),(           1):(nxP          ));

switch method
    
    case 'tustin'
    % Toth, 2012
    Psi = (eye(nxP) - (Ts/2)*PLFR.A)^-1;
    
    dPLFR.A       = (eye(nxP) + (Ts/2)*PLFR.A)*Psi;
    dPLFR.B_th    = sqrt(Ts)*Psi*PLFR.B_th;
    dPLFR.B_u     = sqrt(Ts)*Psi*PLFR.B_u;
    dPLFR.D_thth  = (Ts/2)*PLFR.C_th*Psi*PLFR.B_th + PLFR.D_thth;
    dPLFR.D_thu   = (Ts/2)*PLFR.C_th*Psi*PLFR.B_u  + PLFR.D_thu;
    dPLFR.D_yth   = (Ts/2)*PLFR.C_y *Psi*PLFR.B_th + PLFR.D_yth;
    dPLFR.D_yu    = (Ts/2)*PLFR.C_y *Psi*PLFR.B_u  + PLFR.D_yu;
    dPLFR.C_th    = sqrt(Ts)*PLFR.C_th*Psi;
    dPLFR.C_y     = sqrt(Ts)*PLFR.C_y *Psi;
    
    M_dPLFR       = ss(dPLFR.A, ...
                       [dPLFR.B_th, dPLFR.B_u], ...
                       [dPLFR.C_th; dPLFR.C_y], ...
                       [dPLFR.D_thth, dPLFR.D_thu;...
                        dPLFR.D_yth , dPLFR.D_yu ]);
                    
    dPLFR    = lft(Theta_PLFR, M_dPLFR);

    dPLFR.Ts = Ts;
    
    case 'rectangular'
    % Toth, 2012
    
    dPLFR.A       = (eye(nxP) + (Ts)*PLFR.A);
    dPLFR.B_th    = (Ts)*PLFR.B_th;
    dPLFR.B_u     = (Ts)*PLFR.B_u;
    dPLFR.D_thth  = PLFR.D_thth;
    dPLFR.D_thu   = PLFR.D_thu;
    dPLFR.D_yth   = PLFR.D_yth;
    dPLFR.D_yu    = PLFR.D_yu;
    dPLFR.C_th    = PLFR.C_th;
    dPLFR.C_y     = PLFR.C_y;
    
    M_dPLFR       = ss(dPLFR.A, ...
                       [dPLFR.B_th, dPLFR.B_u], ...
                       [dPLFR.C_th; dPLFR.C_y], ...
                       [dPLFR.D_thth, dPLFR.D_thu;...
                        dPLFR.D_yth , dPLFR.D_yu ]);
                    
    dPLFR    = lft(Theta_PLFR, M_dPLFR);

    dPLFR.Ts = Ts;
    
    case 'pade'
    % Toth, 2012
    Psi = (eye(nxP) - (Ts/2)*PLFR.A)^-1;
    
    dPLFR.A       = (eye(nxP) + (Ts/2)*PLFR.A)*Psi;
    dPLFR.B_th    = [ (Ts/2)*Psi*PLFR.B_th, (Ts/2)*Psi*PLFR.B_th];
    dPLFR.B_u     = (Ts)*Psi*PLFR.B_u;
    dPLFR.D_thth  = [ (Ts/2)*PLFR.C_th*Psi*PLFR.B_th + PLFR.D_thth, (Ts/2)*PLFR.C_th*Psi*PLFR.B_th ;...
                      zeros(size(PLFR.D_thth))                    , PLFR.D_thth                    ];
    dPLFR.D_thu   = [ (Ts)*PLFR.C_th*Psi*PLFR.B_u  + PLFR.D_thu ; ...
                      PLFR.D_thu                                  ];
    dPLFR.D_yth   = [ zeros(size(PLFR.D_yth))                     , PLFR.D_yth ];
    dPLFR.D_yu    = PLFR.D_yu;
    dPLFR.C_th    = [ PLFR.C_th*(eye(nxP) + (Ts/2)*PLFR.A)*Psi ;...
                      PLFR.C_th                                ];
    dPLFR.C_y     = PLFR.C_y;
    
    M_dPLFR       = ss(dPLFR.A, ...
                       [dPLFR.B_th, dPLFR.B_u], ...
                       [dPLFR.C_th; dPLFR.C_y], ...
                       [dPLFR.D_thth, dPLFR.D_thu;...
                        dPLFR.D_yth , dPLFR.D_yu ]);
                    
    dPLFR    = lft(mdiag(Theta_PLFR, Theta_PLFR), M_dPLFR);
    dPLFR    = simplify(dPLFR, 'full');
    
    dPLFR.Ts = Ts;
    
    case 'tustinSimple'
    % This is most probably quite wrong
    
    [M_PLFR  , Theta_PLFR  , Blkstruct_PLFR  , Normunc_PLFR] = lftdata(argPLFR);

    M_dPLFR = c2d(M_PLFR, Ts, method);

    dPLFR = lft(Theta_PLFR, M_dPLFR);
    dPLFR.Ts = Ts;
    
    otherwise
        
        error('Choose proper method!'); return;
    
end