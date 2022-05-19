function y = simple(x)
% As of some Matlab version, simple is no longer available for symbolic
% term manipulation. This is a substitute that simply calls "simplify"

y = simplify(x);