% function[vert] = permute_bounds(bounds);
%
% permutes rows of the matrix bounds to all possible combinations
%
% bounds    :  matrix consisting the boundaries of  a pparameter [min max]
% vert      :  
%
% Copyright
% A. Kwiatkowski
% Department of Control Engineering
% University of Technology Hamburg-Harburg
% 01.04.05


function[vert] = permute_bounds(bounds);

if size(bounds,1)*size(bounds,2)==1
   vert = bounds;
else

   if size(bounds,2) ~= 2
      error('give lower and upper bounds in a 2 column matrix')
   end
   num = size(bounds,1);

   if num==1
      vert = bounds;
   elseif num==2
      vert = [bounds(1,1)*ones(1,2) bounds(1,2)*ones(1,2);bounds(2,:) bounds(2,:)];
   else

      B = repmat(bounds,1,2^(num-1));
      vert = zeros(size(B));
      for i=1:num
         in = 2^i;
         out = 2^num/2^i;
         vert(i,:) = reshape(reshape(B(i,:),in,out)',2^num,1)';
      end

   end
end



