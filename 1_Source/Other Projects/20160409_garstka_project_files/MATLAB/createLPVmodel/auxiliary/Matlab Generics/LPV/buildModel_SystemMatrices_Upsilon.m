function [SS_Upsilon, SS_Upsilon_dummy, Upsilon_dummy] = buildModel_SystemMatrices_Upsilon(MLFR_Upsilon, uUpsilon, nq, nqd, nxG, ny, nu)

nz_Upsilon = size(uUpsilon, 2);
nw_Upsilon = size(uUpsilon, 1);

[MLFR11_Upsilon, MLFR12_Upsilon, MLFR21_Upsilon, MLFR22_Upsilon] = mat2x2(MLFR_Upsilon, nz_Upsilon, nw_Upsilon);

D_thth_Upsilon = MLFR11_Upsilon;
B_th_Upsilon   = MLFR21_Upsilon(    (1):(nxG)  ,       :      );
D_yth_Upsilon  = MLFR21_Upsilon( (nxG+1):(end) ,       :      );
C_th_Upsilon   = MLFR12_Upsilon(       :       ,    (1):(nxG) );
D_thu_Upsilon  = MLFR12_Upsilon(       :       , (nxG+1):(end));
A_Upsilon      = MLFR22_Upsilon(    (1):(nxG)  ,    (1):(nxG) );
B_u_Upsilon    = MLFR22_Upsilon(    (1):(nxG)  , (nxG+1):(end));
C_y_Upsilon    = MLFR22_Upsilon( (nxG+1):(end) ,    (1):(nxG) );
D_yu_Upsilon   = MLFR22_Upsilon( (nxG+1):(end) , (nxG+1):(end));

nwth           = nw_Upsilon;
nzth           = nz_Upsilon;

  B_th_Upsilon_dummy = ones(nxG , nz_Upsilon-nw_Upsilon);
D_thth_Upsilon_dummy = ones(nzth, nz_Upsilon-nw_Upsilon);
 D_yth_Upsilon_dummy = ones(ny  , nz_Upsilon-nw_Upsilon);
 
SS_Upsilon_dummy       = ss(A_Upsilon, [B_th_Upsilon, B_th_Upsilon_dummy, B_u_Upsilon], [C_th_Upsilon; C_y_Upsilon], [D_thth_Upsilon, D_thth_Upsilon_dummy, D_thu_Upsilon; D_yth_Upsilon, D_yth_Upsilon_dummy, D_yu_Upsilon]);
SS_Upsilon             = ss(A_Upsilon, [B_th_Upsilon, B_u_Upsilon], [C_th_Upsilon; C_y_Upsilon], [D_thth_Upsilon, D_thu_Upsilon; D_yth_Upsilon, D_yu_Upsilon]);

% SS_Upsilon     = ss(A_Upsilon, [B_th_Upsilon, B_u_Upsilon], [C_th_Upsilon; C_y_Upsilon], [D_thth_Upsilon, D_thu_Upsilon; D_yth_Upsilon, D_yu_Upsilon]);
SS_Upsilon     = ss_nameInputs (SS_Upsilon, [     1:nwth   ], 'wth');
SS_Upsilon     = ss_nameInputs (SS_Upsilon, [nwth+1:nwth+nu], 'u'  );
SS_Upsilon     = ss_nameOutputs(SS_Upsilon, [     1:nzth   ], 'zth');
SS_Upsilon     = ss_nameOutputs(SS_Upsilon, [nzth+1:nzth+ny], 'y'  );
SS_Upsilon     = ss_nameStates (SS_Upsilon, [     1:nq     ], 'q'  );
SS_Upsilon     = ss_nameStates (SS_Upsilon, [  nq+1:nq+nqd ], 'dq' );
Upsilon_dummy   = [ ones(nw_Upsilon          , nz_Upsilon) ;...
                      O(nz_Upsilon-nw_Upsilon, nz_Upsilon)];