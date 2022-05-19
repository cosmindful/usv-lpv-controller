function PLFR = model_struct2uss(PLFRstruct, varargin)

        [nwth1, nzth1] = size(PLFRstruct.THETA);

        if (nargin > 1)
            PLFRstruct.THETA = varargin{1};
            [nwth2, nzth2] = size(PLFRstruct.THETA);
        end

%         P0 = [PLFRstruct.A  , PLFRstruct.B_u   ;...
%               PLFRstruct.C_y, PLFRstruct.D_yu  ];
%          
%         Q  = [PLFRstruct.B_th  ;...
%               PLFRstruct.D_yth ];
%          
%         V  = [PLFRstruct.C_th, PLFRstruct.D_thu ];
%  
%         
%         nwPth = size(PLFRstruct.THETA, 1);
%         
%         if nwPth ~= 0
%             DeltaBlock = PLFRstruct.THETA;
%             S2Delta = eye(nwPth);
% 
%             Psi = DeltaBlock * (S2Delta - PLFRstruct.D_thth*DeltaBlock)^-1;
%     
%             PLFRumat = P0 + Q*Psi*V;
%         else
%             PLFRumat = P0;
%         end
%         
%         nxP  = size(PLFRstruct.A, 1);
%         
%         PLFR = uss(PLFRumat(    (1):(nxP), (1):(nxP)), PLFRumat(    (1):(nxP), (nxP+1):(end)), ...
%                    PLFRumat((nxP+1):(end), (1):(nxP)), PLFRumat((nxP+1):(end), (nxP+1):(end)));
%                
%         [M,Delta,Blkstruct,Normunc] = lftdata(PLFRstruct.THETA);
%                
%         P0 = [PLFRstruct.D_thth, PLFRstruct.C_th, PLFRstruct.D_thu
%               PLFRstruct.B_th  , PLFRstruct.A   , PLFRstruct.B_u   ;...
%               PLFRstruct.D_yth , PLFRstruct.C_y , PLFRstruct.D_yu  ];
          
        nx = size(PLFRstruct.A  , 1);
        ny = size(PLFRstruct.C_y, 1);
        nu = size(PLFRstruct.B_u, 2);

        [nzth2, nwth2] = size(PLFRstruct.THETA);
        
        B_th_dummy     = I(nx         , nwth2-nwth1);
        C_th_dummy     = I(nzth2-nzth1, nx         );
        D_thth12_dummy = I(      nzth1, nwth2-nwth1);
        D_thth21_dummy = I(nzth2-nzth1, nwth1      );
        D_thth22_dummy = I(nzth2-nzth1, nwth2-nwth1);
        D_yth_dummy    = I(ny         , nwth2-nwth1);
        D_thu_dummy    = I(nzth2-nzth1, nu         );
        
        PLFRstruct.B_th   = [PLFRstruct.B_th, B_th_dummy];
        PLFRstruct.C_th   = [PLFRstruct.C_th; C_th_dummy];
        PLFRstruct.D_thth = [PLFRstruct.D_thth        , D_thth12_dummy;...
                                        D_thth21_dummy, D_thth22_dummy];
        PLFRstruct.D_yth   = [PLFRstruct.D_yth, D_yth_dummy];
        PLFRstruct.D_thu   = [PLFRstruct.D_thu; D_thu_dummy];

        P0 = ss( PLFRstruct.A, [PLFRstruct.B_th, PLFRstruct.B_u], ...
                [PLFRstruct.C_th ;...
                 PLFRstruct.C_y  ], ...
                [PLFRstruct.D_thth, PLFRstruct.D_thu;...
                 PLFRstruct.D_yth , PLFRstruct.D_yu ]);
                
        PLFR = lft(PLFRstruct.THETA, P0);
               
        PLFR = simplify(PLFR, 'full');