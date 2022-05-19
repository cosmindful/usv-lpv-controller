% Michael Garstka
% Test Kalman-Filter
clear all
load sample_data_throw.mat;
% define sampling time
Ts = 0.022;
% define matrizes
A = [1 0 Ts 0; 0 1 0 Ts; 0 0 1 0; 0 0 0 1];
B = [0;0;0;-1];
C = [1 0 0 0; 0 1 0 0];
D = 0;

% define covariance matrizes
Q = [   Ts^3/15,    0,      Ts^2/10,    0;
        0,       Ts^3/15,   0,          Ts^2/10;
        Ts^2/10,   0,       Ts/5,       0;
        0,       Ts^2/10,   0,          Ts/5]   ; %4x4
R = diag([10^-2,10^-2]); %2x2
P = diag([1000,1000,1000,1000]);

% define constants
g = 9.81;
u = g;

% initialize data arrays
x_pre = zeros(4,length(t)+1); % prediction step
x_est = zeros(4,length(t)+1); % estimation step
% "measured values"
z_meas = [x';y'];
% define initial states
x_est(:,1) = [x(1,1);y(1,1);0;0];
x_pre(:,1) = [x(1,1);y(1,1);0;0];


% Kalman filter loop
for k=1:length(t)-1
    
    % calculate prediction state vector
    x_pre(:,k+1) = A*x_est(:,k) + B*u;
    % predict covariance matrix P
    P = A * P * A' + Q;
    % calculate Kalman Gain
    K = (P*C')/(C*P*C'+R);
    % calculate estimated state vector
    x_est(:,k+1) = x_pre(:,k+1) + K*(z_meas(:,k+1)-C*x_pre(:,k+1));
    % calculate estimated covariance
    P = (eye(4)-K*C)*P;
end

% evaluate results
figure(3);
title('Kalman Filter Applied to measured positon values')
subplot(2,1,1)
plot(t,x,'r',t,x_est(1,1:end-1),'b--',t,x_pre(1,1:end-1),'g--');
grid on; xlabel('t[s]'),ylabel('x[px]');
legend('measure','estimate','prediction','Location','Best');
subplot(2,1,2)
plot(t,y,'r',t,x_est(2,1:end-1),'b--',t,x_pre(2,1:end-1),'g--');grid on; xlabel('t[s]'),ylabel('y[px]');
legend('measure','estimate','prediction','Location','Best');
