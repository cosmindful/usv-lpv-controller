function [ f ] = func_plot( t,z )

% z'=f(t,z(t))
% z = [x,y,vx,vy]

v = sqrt(z(3)^2+z(4)^2);
f = zeros(4,1);
g = 9.81; %[m/s^2]
global KM; %SI units %vllt stimmen die modelldaten zum ball nicht mit meinem ball überein


f(1)=z(3);
f(2)=z(4);
f(3) = - KM * v * z(3);
f(4) = - KM * v * z(4) - g;



end

