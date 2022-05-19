%% Khatri-Rao Product
function [C] = khatrirao(A, B);

if (~iscell(A) | ~iscell(B))
    error('Enter matrices as cell arrays.');
end
    
if (size(A) ~= size(B))
    error('Sizes not conformable.');
end

C = cellfun(@kron, A, B, 'UniformOutput', false);
    
