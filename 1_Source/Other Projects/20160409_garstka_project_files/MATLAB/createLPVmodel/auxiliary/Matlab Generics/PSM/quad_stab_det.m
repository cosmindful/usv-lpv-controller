
% function[is_stab,is_det] = quad_stab_det(poly);
%
% quadratic stabilizability and detectability
%   .
%   x = A x + B u
%   y = C x
%   u = K x
%
% ex. V(x) = x' X x  for state feedback loop ?


function[is_stab,is_det] = quad_stab_det(poly,proj);

if nargin==1
   proj = 0;
end

[typ,num_vert,ns,ni,no] = psinfo(poly);
if typ ~= 'pol';
   poly = aff2pol(poly);
   [typ,num_vert,ns,ni,no] = psinfo(poly);
   disp('input is affine system == trafo to polytopic')
end

[strct] = vertices(poly);

% test if all input-matrices are the same
B = strct{1}.b;
C = strct{1}.c;
mat_A = strct{1}.a;
mat_At = strct{1}.a';
mat_B = B;
mat_Ct = C';
B_equal = 1;
C_equal = 1;
for vert = 2:length(strct)
   if sum(abs(C - strct{vert}.c)) ~= 0
      if proj == 1
         disp(['quad_stab_det.m: scheduled output matrices C_i'])
      end
      C_equal = 0;
   end
   if sum(abs(B - strct{vert}.b)) ~= 0
      if proj == 1
         disp(['quad_stab_det.m: scheduled input matrices B_i'])
      end
      B_equal = 0;
   end
   mat_A(:,:,vert)  = strct{vert}.a;
   mat_At(:,:,vert) = strct{vert}.a';
   mat_B(:,:,vert)  = strct{vert}.b;
   mat_Ct(:,:,vert)  = strct{vert}.c';
end

if C_equal == 0
   disp(['quad_stab_det.m: scheduled output matrices C_i'])
end
if B_equal == 0
   disp(['quad_stab_det.m: scheduled input matrices B_i'])
end


%~~~~~~~~~ STABILIZABILITY ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

if proj == 1
   if B_equal == 1;
      [tmin] = quad_stab_proj(mat_A,mat_B(:,:,1));
   else
      error('Projection-Lemma not suitable for parameter dependent input matrix B')
   end
else
   [tmin] = quad_stab_no_proj(mat_A,mat_B);
end

% if tmin > 1e-5 | isempty(tmin),
%    disp(' This system is not quadratically stabilizable');
%    is_stab = 0;
% elseif tmin > 0,
%    disp(' Marginal quadratic stabilizability: further checking needed');
%    is_stab = 0;
% else
%    disp(' This system is quadratically stabilizable');
%    is_stab = 1;
% end

if tmin > 0 | isempty(tmin),
   if ~isempty(tmin) & tmin < 1e5
  disp(' Marginal quadratic stabilizability: further checking needed');
   else
disp(' This system is not quadratically stabilizable');
   end
   is_stab = 0;
else
 disp(' This system is quadratically stabilizable');
   is_stab = 1;
end

%~~~~~~~~~ DETECTABILITY ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%
% quad detect. of (A,C)  <==> quad. stab. (A',C')

if proj == 1
   if C_equal == 1;
      [tmin] = quad_stab_proj(mat_At,mat_Ct(:,:,1));
   else
      error('Projection-Lemma not suitable for parameter dependent output matrix C')
   end
else
   [tmin] = quad_stab_no_proj(mat_At,mat_Ct);
end

% if tmin > 1e-5 | isempty(tmin),
%    disp(' This system is not quadratically detectable');
%    is_det = 0;
% elseif tmin > 0,
%    disp(' Marginal quadratic detectability: further checking needed');
%    is_det = 0;
% else
%    disp(' This system is quadratically detectable');
%    is_det = 1;
% end

if tmin > 0 | isempty(tmin),
   if ~isempty(tmin) & tmin < 1e5
      disp(' Marginal quadratic detectability: further checking needed');
   else
   disp(' This system is not quadratically detectable');
   end
   is_det = 0;
else
   disp(' This system is quadratically detectable');
   is_det = 1;
end


%%%%%%%%%%% ------- Subfunctions ---------  %%%%%%%%%%%%%

function[tmin] = quad_stab_proj(A_or_At,B_or_Ct);

% define LMIs (Kobe p.178)
%
% N' ( A_i' X + X A_i) N

setlmis([]);
Y = lmivar(1,[size(A_or_At,1) 1]);        % Y
N = null(B_or_Ct');
if isempty(N)
   error('empty nullspaces')
end

lmiterm([-1 1 1 Y],1,1)
for vert = 1:size(A_or_At,3)
   nlmi = newlmi;
   lmiterm([nlmi 1 1 Y],N',A_or_At(:,:,vert)'*N,'s');
end

lmisys  = getlmis;
options = [0 100 1e3 50 1];
target  = -1e-6;

[tmin,yfeas] = feasp(lmisys,options);%,target);

%-------------------------------------------------------------

function[tmin] = quad_stab_no_proj(A_or_At,B_or_Ct);

setlmis([]);
Y = lmivar(1,[size(A_or_At,1) 1]);
W = lmivar(2,[size(B_or_Ct,2) size(A_or_At,1)]); % n_u-by-n rectangular matrix, not symmetric

lmiterm([-1 1 1 Y],1,1);
for vert = 1:size(A_or_At,3)
   nlmi = newlmi;
   lmiterm([ nlmi 1 1 Y ],A_or_At(:,:,vert),1,'s');    % A*P + P'*A'
   lmiterm([ nlmi 1 1 W ],B_or_Ct(:,:,vert),1,'s');    % B*Y + Y'*B'
end

lmisys  = getlmis;
options = [0 100 1e3 50 1];
target  = -1e-6;

[tmin,yfeas] = feasp(lmisys,options);%,target);

%    Y_s = dec2mat(lmisys,yfeas,1);
%    W   = dec2mat(lmisys,yfeas,2);
%    K   = W*inv(Y_s);