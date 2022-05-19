syms DP_thth CP_th DP_thp BP_th AP BP_p DP_pth CP_p DP_pp DP_thu BP_u DP_pu DP_yth CP_y DP_yp;
syms DK_thth CK_th DK_thy BK_th AK BK_y DK_uth CK_u DK_uy;

I = 1;
O = 0;

Sigma0 = [ DP_thth,    O, CP_th, O, DP_thp ;...
           O      ,    O, O    , O, O      ;...
           O      ,    O, I    , O, O      ;...
           O      ,    O, O    , I, O      ;...
           BP_th  ,    O, AP   , O, BP_p   ;...
           O      ,    O, O    , O, O      ;...
           O      ,    O, O    , O, I      ;...
           DP_pth ,    O, CP_p , O, DP_pp  ];
        
Q      = [  O, O, DP_thu ;...
            I, O, O      ;...
            O, O, O      ;...
            O, O, O      ;...
            O, O, BP_u   ;...
            O, I, O      ;...
            O, O, O      ;...
            O, O, DP_pu  ];
        
  
Kth    = [ DK_thth , CK_th  , DK_thy  ;...
           BK_th   , AK     , BK_y    ;...
           DK_uth  , CK_u   , DK_uy   ];
       
V      = [ O     , I, O   , O, O     ;...
           O     , O, O   , I, O     ;...
           DP_yth, O, CP_y, O, DP_yp ];
       
Sigma  = Sigma0 + Q*Kth*V;


%% dual

Sigma0d = [ -DP_thth',    O, -BP_th', O, -DP_pth' ;...
             O       ,    O,  O     , O,  O       ;...
            -CP_th'  ,    O,  -AP'  , O, -CP_p'   ;...
             O       ,    O,  O     , O,  O       ;...
             O       ,    O,  I     , O,  O       ;...
             O       ,    O,  O     , I,  O       ;...
            -DP_thp' ,    O, -BP_p' , O, -DP_pp'  ;...
             O       ,    O,  O     , O,  I       ];
        
Qd      = [  O, O, DP_thu ;...
             I, O, O      ;...
             O, O, BP_u   ;...
             O, I, O      ;...
             O, O, DP_pu  ]';

Vd      = [ O     , I, O   , O, O, O, O    , O ;...
            O     , O, O   , I, O, O, O    , O ;...
            DP_yth, O, CP_y, O, O, O, DP_yp, O ]';
  
Kthd    = -[ DK_thth , CK_th  , DK_thy  ;...
             BK_th   , AK     , BK_y    ;...
             DK_uth  , CK_u   , DK_uy   ]';
       

       
Sigmad  = Sigma0d + Vd*Kthd*Qd;