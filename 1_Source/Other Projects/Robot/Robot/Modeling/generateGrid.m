%% Grid parameter space

% The data on the bounds of the joint angles and angular velocities is
% arrange in a cell array containing [1x2] matrices
% 
% q_qd_bnd  = { q1_bnd, qd1_bnd ;...
%               q2_bnd, qd2_bnd ;...
%               q3_bnd, qd3_bnd };
% 
% where qi_bnd(1) = qi_min, 
%       qi_bnd(2) = qi_max      for all i = 1:3

q_qd_bnd{1, 1} = [ -180    180 ]*pi/180;
q_qd_bnd{2, 1} = [ -30      30 ]*pi/180;
q_qd_bnd{3, 1} = [  45     135 ]*pi/180;
q_qd_bnd{3, 1} = q_qd_bnd{3, 1} + q_qd_bnd{2, 1} - [90 90]*pi/180;
q_qd_bnd{1, 2} = [ -100        80   ]*pi/180;
q_qd_bnd{2, 2} = [ -100        80   ]*pi/180;
q_qd_bnd{3, 2} = [ -120        180  ]*pi/180;

% Define the densities with which the respective qi's and qdi's are to be
% gridded
qgriddensity = { pi/32, pi/32 ;...
                 pi/32, pi/32 ;...
                 pi/32, pi/32 };
       
% Create vectors of grid points for each qi and qdi
for ii = 1:3 % Iterate over q/qd 1 to 3
    for jj = 1:2 % Iterate between the qi's and qdi's
        q_qd_grid{ii, jj} = q_qd_bnd{ii, jj}(1):qgriddensity{ii, jj}:q_qd_bnd{ii, jj}(2);
    end
end

%% Generate parameter grid
% The gridded data will be of the form
% qgrid = [  q2_min ...  q2_max,  q2_min   ...  q2_max  , ...,  q2_min   ...  q2_max  , ...
%            q3_min ...  q3_min,  q3_min+1 ...  q3_min+1, ...,  q3_max   ...  q3_max  , ...
%           qd2_min ... qd2_min, qd2_min   ... qd2_min  , ..., qd2_min   ... qd2_min  , ...
%           qd3_min ... qd3_min, qd3_min   ... qd3_min  , ..., qd3_min   ... qd3_min  , ...
qgrid = combvec(q_qd_grid{2:3, :});

 q1  = 0*qgrid(1, :);
 q2  =   qgrid(1, :);
 q3  =   qgrid(2, :);
qd1  = 0*qgrid(3, :);
qd2  =   qgrid(3, :);
qd3  =   qgrid(4, :);