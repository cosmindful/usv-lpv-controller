clear all, clc
load Trajectory_data_Cux_Visby.rtz2017-11-16_14-55.mat
load Classic_data_2017-11-06_16-06.mat
load LTI_data_2017-11-06_16-22.mat
load LTI_USS_data_2017-11-06_18-07.mat
load QLPV_data_2017-11-27_19-42.mat
load DataSimulations.mat
% load DataStepResponse.mat

% orange = [ 0.9100, 0.4100, 0.1700];
% yellow =[237 208 121]./255;
purple = [198 119 184]./255;
lime =[195 214 139]./255;
turqoise= [0 153 153]./255;

% load QLPV_data_2017-11-06_16-18.mat
%% Plot Step Response
set(0,'DefaultFigureColor','w','DefaultAxesFontSize',30,'DefaultLineLineWidth',4)
% figure('units','normalized','outerposition',[0 0 1 1]);
% set(0, 'DefaultFigureRenderer', 'painters');
% peach = [18 150 155] ./ 255;
section =1:156191/6; 
section2 = 1:7383/6;
section3 = 1:190;
figure('units','normalized','outerposition',[0 0 1 1]);
subplot(2,1,1); hold on; grid on
plot(pid_out.Time(section), 10*ones(size(pid_out.Time(section))),'r--');
% stairs(time,ref_u,'r--','LineWidth',2); 
plot(pid_out.Time(section),pid_out.Data(section,1),'b-'); 
plot(lti_out.Time(section2),lti_out.Data(section2,1),'Color',lime);
plot(lpv_out.Time(section),lpv_out.Data(section,1),'Color',turqoise);
plot(lti_uss_out.Time(section3),lti_uss_out.Data(section3,1),'Color',purple);
grid on
title('Velocity tracking');
legend('reference','PID Controller','LTI Controller',...
    'LPV Controller','LTIu Controller');
xlabel('t [s]');ylabel('u [kn]');

subplot(2,1,2); hold on; grid on
plot(pid_out.Time(section), 90*ones(size(pid_out.Time(section))),'r--');
% stairs(time,ref_psi./toRad,'r--','LineWidth',2); 
plot(pid_out.Time(section),pid_out.Data(section,2),'b-'); 
plot(lti_out.Time(section2),lti_out.Data(section2,2),'Color',lime); 
plot(lpv_out.Time(section),lpv_out.Data(section,2),'Color',turqoise);
plot(lti_uss_out.Time(section3),lti_uss_out.Data(section3,2),'Color',purple);

title('Orientation Tracking');
legend('reference','PID Controller','LTI Controller',...
    'LPV Controller','LTIu Controller');
xlabel('t [s]');ylabel('Psi [deg]');
%% Plot reference tracking
% set(0,'DefaultFigureColor','w','DefaultAxesFontSize',30,'DefaultLineLineWidth',3)
% figure('units','normalized','outerposition',[0 0 1 1]);
% set(0, 'DefaultFigureRenderer', 'painters');
% peach = [18 150 155] ./ 255;

figure('units','normalized','outerposition',[0 0 1 1]);
subplot(2,1,1); hold on; grid on
stairs(time,ref_u,'r--','LineWidth',2); 
plot(pid_out.Time,pid_out.Data(:,1),'b-'); 
plot(lti_out.Time,lti_out.Data(:,1),'Color',lime);
plot(lpv_out.Time,lpv_out.Data(:,1),'Color',turqoise);
plot(lti_uss_out.Time,lti_uss_out.Data(:,1),'Color',purple);
grid on
title('Velocity tracking');
legend('reference','PID Controller','LTI Controller',...
    'LPV Controller','LTIu Controller');
xlabel('t [s]');ylabel('u [kn]');

subplot(2,1,2); hold on; grid on
stairs(time,ref_psi./toRad,'r--','LineWidth',2); 
plot(pid_out.Time,pid_out.Data(:,2),'b-'); 
plot(lti_out.Time,lti_out.Data(:,2),'Color',lime); 
plot(lpv_out.Time,lpv_out.Data(:,2),'Color',turqoise);
plot(lti_uss_out.Time,lti_uss_out.Data(:,2),'Color',purple);

title('Orientation Tracking');
legend('reference','PID Controller','LTI Controller',...
    'LPV Controller','LTIu Controller');
xlabel('t [s]');ylabel('Psi [deg]');

%% Plot trajectory
set(0,'DefaultFigureColor','w','DefaultAxesFontSize',30,'DefaultLineLineWidth',4)
u_pid = pid_out.Data(:,1).* 0.51444;%m/s
v_pid = pid_sway.Data; %m/s
psi_real_pid = pid_out.Data(:,2); %deg
az_real_pid = psi_real_pid;

for i=1:size(psi_real_pid,1)
    if psi_real_pid(i)<90
        az_real_pid(i) = 90 - psi_real_pid(i);
    else
        az_real_pid(i) = 360+90 - psi_real_pid(i);
    end
end
timeD = pid_out.Time;
ref_ya_dot_pid = cos(deg2rad(az_real_pid)).*u_pid - 1.*sin(deg2rad(az_real_pid)).*v_pid;
ref_xa_dot_pid = sin(deg2rad(az_real_pid)).*u_pid + 1.*cos(deg2rad(az_real_pid)).*v_pid;
ref_ya_pid = 1e-3.*cumtrapz(timeD,ref_ya_dot_pid);
ref_xa_pid = 1e-3.*cumtrapz(timeD,ref_xa_dot_pid);
%-------------------------------------------------------------------
u_lti = lti_out.Data(:,1).* 0.51444;%m/s
v_lti = lti_sway.Data; %m/s
psi_real_lti = lti_out.Data(:,2); %deg
az_real_lti = psi_real_lti;

for i=1:size(psi_real_lti,1)
    if psi_real_lti(i)<90
        az_real_lti(i) = 90 - psi_real_lti(i);
    else
        az_real_lti(i) = 360+90 - psi_real_lti(i);
    end
end
timeD = lti_out.Time;
ref_ya_dot_lti = cos(deg2rad(az_real_lti)).*u_lti - 1.*sin(deg2rad(az_real_lti)).*v_lti;
ref_xa_dot_lti = sin(deg2rad(az_real_lti)).*u_lti + 1.*cos(deg2rad(az_real_lti)).*v_lti;
ref_ya_lti = 1e-3.*cumtrapz(timeD,ref_ya_dot_lti);
ref_xa_lti = 1e-3.*cumtrapz(timeD,ref_xa_dot_lti);
%--------------------------------------------------------------------
u_uss = lti_uss_out.Data(:,1).* 0.51444;%m/s
v_uss = lti_uss_sway.Data;
psi_real_uss = lti_uss_out.Data(:,2); %deg
az_real_uss = psi_real_uss;

for i=1:size(psi_real_uss,1)
    if psi_real_uss(i)<90
        az_real_uss(i) = 90 - psi_real_uss(i);
    else
        az_real_uss(i) = 360+90 - psi_real_uss(i);
    end
end
timeD = lti_uss_out.Time;
ref_ya_dot_uss = cos(deg2rad(az_real_uss)).*u_uss - 1.*sin(deg2rad(az_real_uss)).*v_uss;
ref_xa_dot_uss = sin(deg2rad(az_real_uss)).*u_uss + 1.*cos(deg2rad(az_real_uss)).*v_uss;
ref_ya_uss = 1e-3.*cumtrapz(timeD,ref_ya_dot_uss);
ref_xa_uss = 1e-3.*cumtrapz(timeD,ref_xa_dot_uss);
%---------------------------------------------------------------------
u_lpv = lpv_out.Data(:,1).* 0.51444;%m/s
v_lpv = lpv_sway.Data;
psi_real_lpv = lpv_out.Data(:,2); %deg
az_real_lpv = psi_real_lpv;

for i=1:size(psi_real_lpv,1)
    if psi_real_lpv(i)<90
        az_real_lpv(i) = 90 - psi_real_lpv(i);
    else
        az_real_lpv(i) = 360+90 - psi_real_lpv(i);
    end
end
timeD = lpv_out.Time;
ref_ya_dot_lpv = cos(deg2rad(az_real_lpv)).*u_lpv - 1.*sin(deg2rad(az_real_lpv)).*v_lpv;
ref_xa_dot_lpv = sin(deg2rad(az_real_lpv)).*u_lpv + 1.*cos(deg2rad(az_real_lpv)).*v_lpv;
ref_ya_lpv = 1e-3.*cumtrapz(timeD,ref_ya_dot_lpv);
ref_xa_lpv = 1e-3.*cumtrapz(timeD,ref_xa_dot_lpv);
%---------------------------------------------------------------------

% figure
figure('units','normalized','outerposition',[0 0 1 1]);hold on; grid on
h(1) = plot(1e-3.*ref_x,1e-3.*ref_y,'r--');
plot(1e-3.*ref_x([1 10 19 28 37]),1e-3.*ref_y([1 10 19 28 37]),'ro','markers',100);
h(2) = plot(ref_xa_pid,ref_ya_pid,'b');
h(3) = plot(ref_xa_lti,ref_ya_lti,'Color',lime);
h(4) = plot(ref_xa_lpv,ref_ya_lpv,'Color',purple);
h(5) = plot(ref_xa_uss,ref_ya_uss,'Color',turqoise);
grid on
title('Trajectory tracking');
legend(h([1 2 3 4 5]),'Reference','PID Controller','LTI Controller',...
    'LPV Controller','LTIu Controller');
xlabel('x [km]');ylabel('y [km]');
daspect([1 1 1])