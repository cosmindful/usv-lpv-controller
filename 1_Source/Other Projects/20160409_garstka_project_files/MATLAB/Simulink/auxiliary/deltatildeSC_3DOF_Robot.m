function [deltaVector] = deltatildeSC_3DOF_Robot(rho)

q2  = rho(:, 1);
q3  = rho(:, 2);
qd1 = rho(:, 3);
qd2 = rho(:, 4);
qd3 = rho(:, 5);
   
delta01  = sin(q2);
delta02  = sin(q3);
delta03  = cos(q2);
delta04  = cos(q3);
delta05  = sinc(q2/pi);
delta06  = sinc(q3/pi);
delta07  = qd1;
delta08  = qd2;
delta09  = qd3;

deltaVector = [delta01 delta02 delta03 delta04 delta05 delta06 delta07 delta08 delta09]';