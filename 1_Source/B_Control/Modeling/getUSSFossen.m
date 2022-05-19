function [ thetaVector ] = getUSSFossen( u,v,n,delta )
%GETUSSOSSEN Computes affine uss model for oil tanker
%   this script is used to compute the affine ss model of the oil tanker
%   vessel using the Fossen reinterpretation of Norrbin's nonlinear
%   equations of motion
%   The main difference between it and the getqLPVFossen is that the
%   current script is suitable for vectors of data, as the bounds of the
%   uncertainties are known.
%
%   Can merge it with getqLPVFossen in future
% Normalization variables
L   =  304.8;          % length of ship (m)
g   =  9.8;            % acceleration of gravity (m./s.^2)


% Parameters, hydrodynamic derivatives and main dimensions
delta_max  = 10;       % max rudder angle      (deg)
Ddelta_max = 2.33;     % max rudder derivative (deg./s)
n_max      = 80;       % max shaft velocity    (rpm)

t   =  0.22;
Tm  =  50;
T   =  18.46;

cun =  0.605;  
cnn =  38.2;

Tuu = -0.00695;
Tun = -0.00063;
Tnn =  0.0000354;

m11 =  1.050;          % 1 - Xudot
m22 =  2.020;          % 1 - Yvdot
m33 =  0.1232;         % kz.^2 - Nrdot

d11 =  2.020;          % 1 + Xvr
d22 = -0.752;          % Yur - 1
d33 = -0.231;          % Nur - xG 

Xuuz   = -0.0061;   YT     =  0.04;   NT      = -0.02;
Xuu    = -0.0377;   Yvv    = -2.400;  Nvr     = -0.300;
Xvv    =  0.3;      Yuv    = -1.205;  Nuv     = -0.451;   
Xudotz = -0.05;     Yvdotz = -0.387;  Nrdotz  = -0.0045;
Xuuz   = -0.0061;   Yurz   =  0.182;  Nurz    = -0.047;
Xvrz   =  0.387;    Yvvz   = -1.5;    Nvrz    = -0.120;
Xccdd  = -0.093;    Yuvz   =  0;      Nuvz    = -0.241;
Xccbd  =  0.152;    Yccd   =  0.208;  Nccd    = -0.098;
Xvvzz  =  0.0125;   Yccbbd = -2.16;   Nccbbd  =  0.688;
                    Yccbbdz= -0.191;  Nccbbdz =  0.344;

% Additional terms in shallow water
z = T./(50 - T);

% c    = sqrt(abs(cun.*u.*n + cnn.*n.^2));
try
    c    = sqrt(cun.*u.*n + cnn.*n.^2);
catch
    warning('complex solution for pair [u,n]= %s', num2str([u n]) );
    c    = sqrt(abs(cun.*u.*n + cnn.*n.^2));
end

if u==0
    beta = 0;
else
    beta = v./u;
end
m11 = (m11 - Xudotz.*z);
m22 = (m22 - Yvdotz.*z);
m33 = (m33 - Nrdotz.*z);
% A11 = 1./L .*( Xuu.*u.^2 + Xuuz.*u.^2.*z + Tuu.*u.^2.*(1-t) )
% A12 = 1./L .*( Xvv.*v.^2 + Xvvzz.*v.^2.*z.^2 )
% A13 = 1./L .*( L.*d11.*v.*r + L.*Xvrz.*v.*r.*z )
% B11 = ( Tun.*u.*n + L.*Tnn.*abs(n).*n ).*(1-t)
% B12 = Xccdd.*abs(c).*c.*delta.^2+ Xccbd.*abs(c).*c.*beta.*delta
A11 = 1./L .*( Xuu.*u + Xuuz.*u.*z + Tuu.*u.*(1-t) ) ./m11;
A12 = 1./L .*( Xvv.*v + Xvvzz.*v.*z.^2 ) ./m11;
A13 = (d11.*v + Xvrz.*v.*z ) ./m11;
B11 = ( (1-t).*Tun.*u + (1-t).*L.*Tnn.*abs(n) ) ./m11;
B12 = 1./L .*(Xccdd.*abs(c).*c.*delta + Xccbd.*abs(c).*c.*beta) ./m11;

% A21 =  1./L .*YT.*(Tuu.*u.^2.*(1-t));
% A22 =  1./L .*( Yuv.*u.*v + Yuvz.*u.*v.*z + Yvv.*abs(v).*v +  Yvvz.*abs(v).*v.*z );
% A23 =  1./L .*( L.*d22.*u.*r + L.*Yurz.*u.*r.*z);
% B21 = YT .* ( Tun.*u.*n + L.*Tnn.*abs(n).*n ).*(1-t);
% B22 = 1./L.*( Yccd.*abs(c).*c.*delta + Yccbbd.*abs(c).*c.*abs(beta).*beta.*abs(delta) + Yccbbdz.*abs(c).*c.*abs(beta).*beta.*abs(delta).*z );
A21 =  1./L .*YT.*(Tuu.*u) ./m22;
A22 =  1./L .*( Yuv.*u + Yuvz.*u.*z + Yvv.*abs(v) +  Yvvz.*abs(v).*z ) ./m22;
A23 =  ( d22.*u + Yurz.*u.*z) ./m22;
B21 =  (YT .*Tun.*u + YT .*L.*Tnn.*abs(n)) ./m22;
B22 = 1./L .*( Yccd.*abs(c).*c + Yccbbd.*abs(c).*c.*abs(beta).*beta.*sign(delta) + Yccbbdz.*abs(c).*c.*abs(beta).*beta.*sign(delta).*z ) ./m22;

% A31 = L.*NT.*Tuu.*u.^2.*(1-t);
% A32 = Nuv.*u.*v +  Nuvz.*u.*v.*z;
% A33 = L.*Nvr.*abs(v).*r + L.*d33.*u.*r + L.*Nurz.*u.*r.*z + L.*Nvrz.*abs(v).*r.*z ;
% B31 = L.*NT.*(Tun.*u.*n + L.*Tnn.*abs(n).*n);
% B32 = Nccd.*abs(c).*c.*delta + Nccbbd.*abs(c).*c.*abs(beta).*beta.*abs(delta) + Nccbbdz.*abs(c).*c.*abs(beta).*beta.*abs(delta).*z;
A31 = (NT.*Tuu.*u) ./(L.^2.*m33);
A32 = (Nuv.*u +  Nuvz.*u.*z) ./(L.^2.*m33);
A33 = (L.*Nvr.*abs(v) + L.*d33.*u + L.*Nurz.*u.*z + L.*Nvrz.*abs(v).*z) ./(L.^2.*m33);
B31 = (L.*NT.*( Tun.*u + L.*Tnn.*abs(n) ) ) ./(L.^2.*m33);
B32 = (Nccd.*abs(c).*c + Nccbbd.*abs(c).*c.*abs(beta).*beta.*sign(delta) + Nccbbdz.*abs(c).*c.*abs(beta).*beta.*sign(delta).*z ) ./(L.^2.*m33);

thetaVector = [A11; A12; A13;...
               A21; A22; A23;...
               A31; A32; A33;...
               B11; B12;...
               B21; B22;... 
               B31; B32];
end