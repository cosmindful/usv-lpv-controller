function alpha = polydec2(pv,theta);
% 
% alpha = polydec2(pv,theta);
%
% POLYDEC2 computes polytopic coordinates (convex coordinates) ALPHA for a
% given interior point THETA of the polytope defined in PV.
%
% PV is created using PVEC and can be of type 'box' or 'pol'. 
% ALPHA is (1xL) row vector, with L = number of vertices of the polytope.
%
% If [V1 V2 ... VL] are the vertices of the polytope defined in PV, then it
% holds:
%   THETA = ALPHA(1)*V1 + ... + ALPHA(L)*VL   and
%   ALPHA(1) + ... + ALPHA(L) = 1.
%
% For PVEC of type 'box' the function POLYDEC is used.
%

flag_time  = 0;     % display calculation time
flag_check = 1;     % check result (only in case of 'pol'

[typ,k,nv] = pvinfo(pv);

if strcmp(typ,'box')
    % Matlab function
    alpha = polydec(pv,theta);

elseif strcmp(typ,'pol')
    % parameter varying in a polytope
    tic;
    vert = pv(:,2:end);             % vertices [V1 V2 ... VL];
    if size(theta,1) ~= 1
        theta = theta';
    end;
    alpha = zeros(1,size(vert,2));
    
    % options delaunayn: default & 'Qz'
    if size(vert,1) < 4
        opti = {'Qt','Qbb','Qc','Qz'};           % for 2D and 3D input
    else
        opti = {'Qt','Qbb','Qc','Qx','Qz'};      % for 4D and higher
    end;
    tes = delaunayn(vert',opti);
    %tes = delaunayn(vert');
    [t,p] = tsearchn(vert',tes,theta);
    alpha(tes(t,:)) = p;
    calc_time = toc;
    if flag_time
        display(['Calculation time of convex coordinates: ',num2str(calc_time)]);
    end;
    
    if flag_check
        err = theta - alpha*vert';
        if abs(err) > norm(theta)*eps*100
            error(['Error in calculating convex coordinates: ',num2str(err)]);
        end;
    end;
        
else
    error('Wrong input argument. PV must be of type ''pol'' or ''box''.');
    
end;

