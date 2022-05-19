function PLFR = model_struct2uss(PLFRstruct, varargin)

        if (nargin > 1)
            PLFRstruct.THETA = varargin{1};
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
          
        P0 = ss( PLFRstruct.A, [PLFRstruct.B_th, PLFRstruct.B_u], ...
                [PLFRstruct.C_th ;...
                 PLFRstruct.C_y  ], ...
                [PLFRstruct.D_thth, PLFRstruct.D_thu;...
                 PLFRstruct.D_yth , PLFRstruct.D_yu ]);
                
        PLFR = lft(PLFRstruct.THETA, P0);
               
        PLFR = simplify(PLFR, 'full');