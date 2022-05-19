%% Make predictions based on obtained measurements and output reference signal for control loop
% -------------------------------------------------------------------------
% script   : predict_trajectory
% -------------------------------------------------------------------------
% Author   : Michael Garstka 
% Version  : March, 24th 2016
% Copyright: TUHH, 2016
% -------------------------------------------------------------------------
%
%clear all
%close all

%% add auxiliary files
addpath(genpath('.'))
%% Initialize variables.
filename = 'auxiliary/data37.txt';
delimiter = ' ';
formatSpec = '%f%f%f%f%*s%*s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true,  'ReturnOnError', false);fclose(fileID);


%% Allocate imported array to column variable names -> measured data x,y,t
xmeas = dataArray{:, 3};
ymeas = dataArray{:, 4};
tmeas = dataArray{:, 2};
case1 = dataArray{:, 1};

% Specify by how much should the data be shifted to put the coordinate system into the
% robot arm base
xshift = 600; %mm
yshift = +435 * 1300/595 - 35; %height of table in image=435px, robot base is 35mm into the table
xmeas = xmeas - xshift;
ymeas = ymeas - yshift;

% shift time to start at 0
tmeas = tmeas - tmeas(1);

% convert from mm to m
xmeas = xmeas./1000;
ymeas = ymeas./1000;

%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%% Display raw data
figure(1);
grid on
plot(xmeas,ymeas,'b.-');hold on;
axis([-0.2 3.5 -0.2 3.2])
set(gca,'DataAspectRatio',[1 1 1])
title('x(t) vs. y(t)'); xlabel('x[mm]'), ylabel('y [mm]');grid on;


%% Estimate Trajectory twice
% the first estimation is made after 0.3s, the second after 0.7s.
% It's useful to experiment which prediction times work best.
tf_data = [0.35,0.7];

% choose numer of points after which estimation starts
BASE_POINTS = 10;
% choose method to determine initial velocities
METHOD = 'poly'; % or 'poly' or 'diff'

% choose drag force parameters KM that works best with the obtained
% measurements. 
global KM;
KM = 0.3058;

% initialize array
joint_data = [];

% Loop
for lll=1:2
    tf = tf_data(lll);
    % find base-start point
    BASE_START = find(tmeas>tf,1);


    % determine initial position x_0 and y_0
    x_0 = xmeas(BASE_START); 
    y_0 = ymeas(BASE_START);
    % determine initial velocity vx_0 and vy_0 based on the specified
    % method
    if isequal(METHOD,'diff')
        vx_0  = (xmeas(BASE_START+1)-xmeas(BASE_START-1))/(tmeas(BASE_START+1)-tmeas(BASE_START-1));
        vy_0 = (ymeas(BASE_START+1)-ymeas(BASE_START-1))/(tmeas(BASE_START+1)-tmeas(BASE_START-1));
    elseif isequal(METHOD,'poly')
            t_lsq = tmeas((BASE_START-BASE_POINTS):BASE_START);
            t_lsq = t_lsq - t_lsq(1);
            x_lsq = xmeas((BASE_START-BASE_POINTS):BASE_START);
            y_lsq = ymeas((BASE_START-BASE_POINTS):BASE_START);
            px = polyfit(t_lsq,x_lsq,2);
            py = polyfit(t_lsq,y_lsq,2);
            pdx = polyder(px);
            pdy = polyder(py);
            vx_0 = polyval(pdx,t_lsq(end));
            vy_0 = polyval(pdy,t_lsq(end));
    end

    % do the integration with forward euler
    z_0 = [x_0;y_0;vx_0;vy_0];
    t_0 = 0;
    b = tmeas(end)+3;
    h = 0.0001; %integration step size
    [ z_out, n_f ] = euler(@func_plot,z_0,t_0,h,b);

    % define the estimated ball trajectory
    xest = z_out(1,:);
    yest = z_out(2,:);
    vxest = z_out(3,:);
    vyest = z_out(4,:);

    % define y-value  of measurement  at x=0
    index = find(xmeas <0,1);
    ymeas_f = ymeas(index-1) + (ymeas(index)-ymeas(index-1))/(xmeas(index)-xmeas(index-1)) * (0-xmeas(index-1));
    f_ind = find(xest<0,1);
    yest_f = yest(f_ind-1) + (yest(f_ind)-yest(f_ind-1))/(xest(f_ind)-xest(f_ind-1)) * (0-xest(f_ind-1));
    vxest_f = vxest(f_ind-1) + (vxest(f_ind)-vxest(f_ind-1))/(xest(f_ind)-xest(f_ind-1)) * (0-xest(f_ind-1));
    vyest_f = vyest(f_ind-1) + (vyest(f_ind)-vyest(f_ind-1))/(xest(f_ind)-xest(f_ind-1)) * (0-xest(f_ind-1));

    phi = atan(vyest_f/vxest_f);
    error = abs(yest_f-ymeas_f) * 1000;


    %% Determine required angles for robot joints (in the coordinate system of the robot)
    LENGTH_12 = 330; %[mm] 
    LENGTH_23 = 305;
    LENGTH_34 = 330;
    DISTANCE_TO_PLANE = 5;
    DIAMETER_BAT = 150;
    zest_f = yest_f * 1000;
    yest_f = 200; %350

    q2min = -1.57; %-90
    q2max = 1.57; %+90
    q3min = -1.92; %-110
    q3max = 1.92; %+110

    % define function to solve for angles
    fun = @(x) norm([yest_f - LENGTH_23*sin(-x(1)) - LENGTH_34 * sin(-x(2));...
                    zest_f -  LENGTH_12 - LENGTH_23*cos(-x(1)) - LENGTH_34 * cos(-x(2))]);

    % define initial position of the robot arm
    x0 = [0;-pi/2];
    
    if lll==2
        x0 = q;
    end
    
    % define constraints on the angles of the robot joints
    A = [1,0;0,1;-1,0;0,-1];
    B = [q2max;q3max;-q2min;-q3min]; 
    % use optimization to find angles q2,q3 that makes the robot reach
    % (xestf,yestf)
    q = fmincon(fun,x0,A,B);

    % required angle alpha of the bat
    theta = (pi/2 + phi)/2;

    q2 = q(1) * 180/pi;
    q3_tilde = q(2) * 180/pi;
    q3 = q3_tilde - q2; 
    q4 = theta * 180/pi;
    % joint data has the wanted joint angles after the first prediction and
    % the second prediction
    joint_data = [joint_data;[tf,q2,q3,q4]];
end
%% create signals for simulink 
q1 = -90; %always -90 for that motion planning strategy
q2 = joint_data(:,2);
q3 = joint_data(:,3);
q4 = joint_data(:,4);

% first prediction and seconf prediction time tf1, tf2
tf1 = tf_data(1);
tf2 = tf_data(2);
tend = tmeas(end) - 0.15;
% sampling time of SIMULINK
ts = 0.001;

% create time signal for reference signals with sampling time ts
tr_signal = tmeas;
tr1 = interp1(tr_signal,tr_signal,0:ts:tr_signal(end));
tr_signal = tr1';

% create reference signals (one or two sigmoids)

% create q1r_signal
q1r_signal = createSigmoid(tr_signal,tf1,tend,q1);

% create q2r_signal
q2r_signal1 = createSigmoid(tr_signal,tf1,tend,q2(1));
ind_at_tf2 = find(tr_signal >= tf2,1);
q2diff = q2(2) - q2(1);
q2r_signal2 = createSigmoid(tr_signal,tr_signal(ind_at_tf2+1),tend,q2diff);
q2r_signal = q2r_signal1+q2r_signal2;

% create q3r_signalq2
q3r_signal1 = createSigmoid(tr_signal,tf1,tend,q3(1));
ind_at_tf2 = find(tr_signal >= tf2,1);
q3diff = q3(2) - q3(1);
q3r_signal2 = createSigmoid(tr_signal,tr_signal(ind_at_tf2+1),tend,q3diff);
q3r_signal = q3r_signal1+q3r_signal2;

% create q4r_signal
q4r_signal1 = createSigmoid(tr_signal,tf1,tend,q4(1));
ind_at_tf2 = find(tr_signal >= tf2,1);
q4diff = q4(2) - q4(1);
q4r_signal2 = createSigmoid(tr_signal,tr_signal(ind_at_tf2+1),tend,q4diff);
q4r_signal = q4r_signal1+q4r_signal2;


% create q5r_signal and q6r_signal
q5r_signal = zeros(length(tr_signal),1);
q6r_signal = zeros(length(tr_signal),1);



%%
figure(4);
plot(tr_signal,q1r_signal,tr_signal,q2r_signal,tr_signal,q3r_signal,tr_signal,q4r_signal);
xlabel('t');ylabel('q');legend('q1r','q2r','q3r','q4r','Location','Best');title('Computed reference signals for SIMULINK');grid on;

%% delete all variables except for the reference signal data
%clearvars -except tr_signal q1r_signal q2r_signal q3r_signal q4r_signal q5r_signal q6r_signal

%% save important data to file
thisdate = datestr(now,'yyyy-mm-dd_HH-MM');
save(['Ref_trajectory_data',thisdate,'.mat'],'tr_signal','q1r_signal', 'q2r_signal', 'q3r_signal', 'q4r_signal', 'q5r_signal', 'q6r_signal');

    