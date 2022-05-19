function [SS_Lambda, SS_Lambda_dummy, Lambda_dummy] = buildModel_SystemMatrices_Lambda(MLFR_Lambda, uLambda_nuN_full, nq, nqd, nxG, ny, nu)


nz_Lambda = size(uLambda_nuN_full, 2);
nw_Lambda = size(uLambda_nuN_full, 1);

[MLFR11_Lambda, MLFR12_Lambda, MLFR21_Lambda, MLFR22_Lambda] = mat2x2(MLFR_Lambda, nz_Lambda, nw_Lambda);
                  
                  
D_thth_Lambda = MLFR11_Lambda;
B_th_Lambda   = MLFR21_Lambda(    (1):(nxG)  ,       :     );
D_yth_Lambda  = MLFR21_Lambda( (nxG+1):(end) ,       :     );
C_th_Lambda   = MLFR12_Lambda(       :      ,    (1):(nxG) );
D_thu_Lambda  = MLFR12_Lambda(       :      , (nxG+1):(end));
A_Lambda      = MLFR22_Lambda(    (1):(nxG)  ,    (1):(nxG) );
B_u_Lambda    = MLFR22_Lambda(    (1):(nxG)  , (nxG+1):(end));
C_y_Lambda    = MLFR22_Lambda( (nxG+1):(end) ,    (1):(nxG) );
D_yu_Lambda   = MLFR22_Lambda( (nxG+1):(end) , (nxG+1):(end));


nwth           = nw_Lambda;
nzth           = nz_Lambda;
  B_th_Lambda_dummy = ones(nxG , nz_Lambda-nw_Lambda);I(nxG , 2*nw_Lambda);
D_thth_Lambda_dummy = ones(nzth, nz_Lambda-nw_Lambda);I(nzth, 2*nw_Lambda)*0;
 D_yth_Lambda_dummy = ones(ny  , nz_Lambda-nw_Lambda);I(ny  , 2*nw_Lambda)*0;
SS_Lambda_dummy       = ss(A_Lambda, [B_th_Lambda, B_th_Lambda_dummy, B_u_Lambda], [C_th_Lambda; C_y_Lambda], [D_thth_Lambda, D_thth_Lambda_dummy, D_thu_Lambda; D_yth_Lambda, D_yth_Lambda_dummy, D_yu_Lambda]);
SS_Lambda             = ss(A_Lambda, [B_th_Lambda, B_u_Lambda], [C_th_Lambda; C_y_Lambda], [D_thth_Lambda, D_thu_Lambda; D_yth_Lambda, D_yu_Lambda]);
SS_Lambda             = ss_nameInputs (SS_Lambda, [     1:nwth   ], 'wth');
SS_Lambda             = ss_nameInputs (SS_Lambda, [nwth+1:nwth+nu], 'u'  );
SS_Lambda             = ss_nameOutputs(SS_Lambda, [     1:nzth   ], 'zth');
SS_Lambda             = ss_nameOutputs(SS_Lambda, [nzth+1:nzth+ny], 'y'  );
SS_Lambda             = ss_nameStates (SS_Lambda, [     1:nq     ], 'q'  );
SS_Lambda             = ss_nameStates (SS_Lambda, [  nq+1:nq+nqd ], 'dq' );
Lambda_dummy   = [ ones(nw_Lambda          , nz_Lambda) ;...
                      O(nz_Lambda-nw_Lambda, nz_Lambda)];