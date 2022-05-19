% [Gv_str] = vertices(lpv_sys,how);
%
% Determines the vertices of a polytopic lpv-description, results
% parameterizations of each combination of theta_i \in {-1, 0, 1}
% for LFT descriptions

function[Gv_str,Gv] = vertices(lpv_sys,how);

if nargin == 1 % polytopic

   [typ,num_vert,ns,ni,no] = psinfo(lpv_sys);

   if typ ~= 'pol';
      lpv_sys = aff2pol(lpv_sys);
      [typ,num_vert,ns,ni,no] = psinfo(lpv_sys);
   end

   for i=1:num_vert
      [a,b,c,d,e]=ltiss(psinfo(lpv_sys,'sys',i));
      Gv_str{i} = ss(a,b,c,d);
      Gv(:,:,i) = ss(a,b,c,d);
   end

else %LFT

   blk = lpv_sys.e;
   nt  = size(blk,1)-1;

   boun = dec2base(0:3^nt-1,3);

   for i=1:size(boun,1)
      for j=1:size(boun,2)
         bounds(i,j) = str2num(boun(i,j))-1;
      end
   end

   if strcmp(how,'up')
      for i=1:size(bounds,1)
         eval(['G = flup(lpv_sys,[NaN ' mat2str(bounds(i,:))  ']);'])
          Gv(:,:,i) = ss(G.a,G.b,G.c,G.d);
          Gv_str{i} = G;
      end
   else
      for i=1:size(bounds,1)
         eval(['G = fldown(lpv_sys,[NaN ' mat2str(bounds(i,:))  ']);'])
         Gv(:,:,i) = ss(G.a,G.b,G.c,G.d);
         Gv_str{i} = G;
      end
   end
   
   %Gp_pol = strct_2_psys(Gp_pol);
   
end