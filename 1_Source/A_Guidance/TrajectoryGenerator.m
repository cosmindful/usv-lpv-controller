clear all, clc
routefile = '2_Puerto Ordaz-Kingsnorth_TS_WP0_4223830877.rtz';
% routefile = 'Cux_Visby.rtz';
global waypoints nOfWaypoints meshFactor deltaETA u ETA
% extract the waypoints, the given time to reach each one of them and the
% recommended vessel velocity
[waypoints, deltaETA, u, ETA] = parseRouteFile(routefile);
% use the following section to select fewer Waypoints
section = 1:size(waypoints,1);
% 1:166 167 167:184 185 185:225
% section = 1:124; % channel
% section = 125:159; % for pics
% section = 158:224; % boring
% section = 184:185; % simple and boring
% section = 166:167; % simple and boring
% section = 185:240; open waters until UK
% section = 225:240; % entring channel in UK
waypoints = waypoints(section);
deltaETA = deltaETA(section);
u = u(section(2:end));
ETA = ETA(section);
nOfWaypoints = size(waypoints,1);
% chose number of intermediate Waypoints to be evaluated between any 2
% Waypoints. Minimum number is 2, as Waypoints themselves are also counted
meshFactor = 10;
% create a grid of points in time, correspoding to the each intermediate
% Waypoint. The time is divided linearly for every Meshpoint beloging to
% a segment closed by 2 Waypoints. Each Waypoint has and ETA indice and the
% Meshpoints are linearly distributed, thus the time needed to reach them
% should be also linearly distributed using the ETA of the last and the
% next Waypoint.
t = zeros(meshFactor,size(section,2)-1);
aa = 1;
for i= 1:size(section,2)-1
    t(:,aa) = linspace(ETA(i),ETA(i+1),meshFactor);
    aa = aa + 1;
end
clear  i j
% remove duplicate Meshpoints (end of each segment coincides with the start
% of the next segment
closingPoint = t(end,end);
t = t(1:end-1,:);
t = reshape(t,[size(t,1)*size(t,2),1]);
t(end+1,1) = closingPoint;
clear closingPoint
% Redraw map for using radius (needs mapping toolbox)
offset = .02;
lonlim = [min([waypoints.lon])-offset max([waypoints.lon])+offset];
latlim = [min([waypoints.lat])-offset max([waypoints.lat])+offset];

w = worldmap(latlim, lonlim);
setm(w,'Frame','off','LabelUnits', 'degrees','LabelFormat','none');
% setm(w,'FFill',400);
xticks = lonlim(1):.1:lonlim(2);
yticks = latlim(1):.1:latlim(2);
% set(w, 'XMinorGrid','on','XTick', xticks, 'YTick', yticks)
land = shaperead('landareas.shp', 'UseGeoCoords', true);
geoshow(land, 'FaceColor', [0.15 0.5 0.15]);
% 124 + 35 + 65 + 16
%
circleRadiuses = .1.*[2 3 3 1 1 4 6 7 4 3 6 5 5 5 6 6 6 8 10 10 8 8 7 6 8 18 18 5 4 18 18 18 18 18 18];
circleRadiuses = [.2.*ones(1,124) circleRadiuses 1.8.*ones(1,65)...
.4.*ones(1,16)];
circleRadiuses = circleRadiuses(section);
% circleRadiuses = 1.8;
[h,circlelat,circlelon] = circlem([waypoints.lat],[waypoints.lon],circleRadiuses,'facecolor','green');

geoshow([waypoints.lat],[waypoints.lon]);
% plot_google_map
% for narrow sectors .1 nm, and broad sectors: 1 nm

%% Get optimal points for each set of 3 WP, from 2, until n-1
latO3 = [waypoints.lat]';
lonO3 = [waypoints.lon]';
dist_interim = zeros(size(circlelat,1),1);
method = 'pchip';
listBestIndices = 0;

circlelat_e = [circlelat zeros(size(circlelat,1),1)];
circlelon_e = [circlelon zeros(size(circlelon,1),1)];
for i =1:size(circlelat,2)
    circlelat_e(end,i) = waypoints(i).lat;
    circlelon_e(end,i) = waypoints(i).lon;
end
% start comparing the distances between each associated 3 WP, varying the
% 2nd WP aroung the circle of tolerance
for i=1:nOfWaypoints-2
    % try every point on the radius around the middle WP, and interpl each
    % one of them with the previous and next WP
    for aa=1:size(circlelat_e,1)
        lat_interim = interp1(1:3,[latO3(i),circlelat_e(aa,i+1),latO3(i+2)],1:3,method);
        lon_interim = interp1(1:3,[lonO3(i),circlelon_e(aa,i+1),lonO3(i+2)],1:3,method);
        % compute the distance resulting from the interpolation and save
        % each short distance in an organised matrix, as the indices will
        % be very important in the next step
        for k =1:size(lat_interim,2)-1
            dist_interim(aa) = dist_interim(aa) + ...
                lldistkm([lat_interim(k) lon_interim(k)],...
                [lat_interim(k+1) lon_interim(k+1)]);
        end
    end
    % get the ID of the point around the circle of tolerance, for which the
    % distance between the currently-computed 3 WP is minimum
    [~,listBestIndices] = min(dist_interim);
    % redefine the middle WP as the newly found point around its circle of
    % tolerance
    latO3(i+1) = circlelat_e(listBestIndices,i+1);
    lonO3(i+1) = circlelon_e(listBestIndices,i+1);
end

% show the new trajectory
geoshow(latO3,lonO3,'Color','cyan');

%% Get optimal points for each set of 5 WP (from 2nd,until last-4 WP)
latO5 = [waypoints.lat]';
lonO5 = [waypoints.lon]';
order = size(circlelat_e,1)/1;
dist_interim = zeros(order,order,order);
method = 'pchip';
tic
% start comparing the distances between each associated 3 WP, varying the
% 2nd WP aroung the circle of tolerance
for i=1:3:nOfWaypoints-4
    % try every point on the radius around the middle WP, and interpl each
    % one of them with the previous and next WP
    for aa=1:order
        for bb=1:order
            for cc=1:order
                        middleWPLat = [circlelat_e(aa,i+1) circlelat_e(bb,i+2)...
                            circlelat_e(cc,i+3)];
                        middleWPLon = [circlelon_e(aa,i+1) circlelon_e(bb,i+2)...
                            circlelon_e(cc,i+3)];
                        lat_interim = interp1(1:5,[latO5(i),middleWPLat,latO5(i+4)],1:5,method);
                        lon_interim = interp1(1:5,[lonO5(i),middleWPLon,lonO5(i+4)],1:5,method);
                        % compute the distance resulting from the interpolation and save
                        % each short distance in an organised matrix, as the indices will
                        % be very important in the next step
                        for k =1:size(lat_interim,2)-1
                            dist_interim(aa,bb,cc) = ...
                                dist_interim(aa,bb,cc) + ...
                                lldistkm([lat_interim(k) lon_interim(k)],...
                                [lat_interim(k+1) lon_interim(k+1)]);
                end
            end
        end
    end
    % get the ID of the point around the circle of tolerance, for which the
    % distance between the currently-computed 3 WP is minimum
    [~,listBestIndices] = min(dist_interim(:));
    [I1,I2,I3] = ind2sub(size(dist_interim),listBestIndices);
    % redefine the middle WP as the newly found point around its circle of
    % tolerance
    latO5(i+1) = circlelat_e(I1,i+1);
    lonO5(i+1) = circlelon_e(I1,i+1);
    latO5(i+2) = circlelat_e(I2,i+2);
    lonO5(i+2) = circlelon_e(I2,i+2);
    latO5(i+3) = circlelat_e(I3,i+3);
    lonO5(i+3) = circlelon_e(I3,i+3);
end
toc
% show the new trajectory
geoshow(latO5,lonO5,'Color','red')

%% Compute higher order splines and obtain navigation data
% 1:166 167 167:184 185 185:240
first_leg= 1:166;
mesh_first_leg = 1:first_leg(end-1)*9+1;
second_leg = 166:167;
mesh_second_leg = first_leg(end-1)*9+1:second_leg(end-1)*9+1;
third_leg = 167:184;
mesh_third_leg = second_leg(end-1)*9+1:third_leg(end-1)*9+1;
fourth_leg = 184:185;
mesh_fourth_leg = third_leg(end-1)*9+1:fourth_leg(end-1)*9+1;
fifth_leg = 185:240;
mesh_fifth_leg = fourth_leg(end-1)*9+1:fifth_leg(end-1)*9+1;
linearly = 'linear';

% compute a list of lat,lon coordinates by interpolating the WP list with
% the total journey time (missing time to first WP)
method = 'linear';
lat_n = interp1(ETA, [waypoints.lat],t,method);
lon_n = interp1(ETA, [waypoints.lon],t,method);
% use the new list of lat,lon coordinates to calculate the required
% velocity to reach the WPs in time, as well as the bearing angle between
% each set of lat,lon
[u_new, azimuthN, distN] = computeJourney(lat_n,lon_n,t);
distInKmN = sum(distN);
fprintf( [method,' distance ',num2str(distInKmN),'km\n'] );

% compute the velocities and the bearing angles again, but now using a
% different interpolation method. Popular choices: spline, pchip.
method = 'spline';
lat_s_a = interp1(ETA(first_leg), [waypoints(first_leg).lat],t(mesh_first_leg),method);
lon_s_a = interp1(ETA(first_leg), [waypoints(first_leg).lon],t(mesh_first_leg),method);
lat_s_b = interp1(ETA(second_leg), [waypoints(second_leg).lat],t(mesh_second_leg),linearly);
lon_s_b = interp1(ETA(second_leg), [waypoints(second_leg).lon],t(mesh_second_leg),linearly);
lat_s_c = interp1(ETA(third_leg), [waypoints(third_leg).lat],t(mesh_third_leg),method);
lon_s_c = interp1(ETA(third_leg), [waypoints(third_leg).lon],t(mesh_third_leg),method);
% use linear for sections that are straight, as otherwise the interpolation
% will generate a very unrealistic curve between these 2 points
lat_s_d = interp1(ETA(fourth_leg), [waypoints(fourth_leg).lat],t(mesh_fourth_leg),linearly);
lon_s_d = interp1(ETA(fourth_leg), [waypoints(fourth_leg).lon],t(mesh_fourth_leg),linearly);
lat_s_e = interp1(ETA(fifth_leg), [waypoints(fifth_leg).lat],t(mesh_fifth_leg),method);
lon_s_e = interp1(ETA(fifth_leg), [waypoints(fifth_leg).lon],t(mesh_fifth_leg),method);
lat_s = [lat_s_a(1:end-1); lat_s_b(1:end-1); lat_s_c(1:end-1); lat_s_d(1:end-1); lat_s_e];
lon_s = [lon_s_a(1:end-1); lon_s_b(1:end-1); lon_s_c(1:end-1); lon_s_d(1:end-1); lon_s_e];
clear lat_s_a lat_s_b lat_s_c lat_s_d lat_s_e
clear lon_s_a lon_s_b lon_s_c lon_s_d lon_s_e
% lat_s = interp1(ETA, [waypoints.lat],t,method);
% lon_s = interp1(ETA, [waypoints.lon],t,method);
[u_optS, azimuthS, distS] = computeJourney(lat_s,lon_s,t);
distInKmS = sum(distS);
fprintf( [method,' distance ',num2str(distInKmS),'km\n'] );

method = 'pchip';
lat_p_a = interp1(ETA(first_leg), [waypoints(first_leg).lat],t(mesh_first_leg),method);
lon_p_a = interp1(ETA(first_leg), [waypoints(first_leg).lon],t(mesh_first_leg),method);
lat_p_b = interp1(ETA(second_leg), [waypoints(second_leg).lat],t(mesh_second_leg),linearly);
lon_p_b = interp1(ETA(second_leg), [waypoints(second_leg).lon],t(mesh_second_leg),linearly);
lat_p_c = interp1(ETA(third_leg), [waypoints(third_leg).lat],t(mesh_third_leg),method);
lon_p_c = interp1(ETA(third_leg), [waypoints(third_leg).lon],t(mesh_third_leg),method);
lat_p_d = interp1(ETA(fourth_leg), [waypoints(fourth_leg).lat],t(mesh_fourth_leg),linearly);
lon_p_d = interp1(ETA(fourth_leg), [waypoints(fourth_leg).lon],t(mesh_fourth_leg),linearly);
lat_p_e = interp1(ETA(fifth_leg), [waypoints(fifth_leg).lat],t(mesh_fifth_leg),method);
lon_p_e = interp1(ETA(fifth_leg), [waypoints(fifth_leg).lon],t(mesh_fifth_leg),method);
lat_p = [lat_p_a(1:end-1); lat_p_b(1:end-1); lat_p_c(1:end-1); lat_p_d(1:end-1); lat_p_e];
lon_p = [lon_p_a(1:end-1); lon_p_b(1:end-1); lon_p_c(1:end-1); lon_p_d(1:end-1); lon_p_e];
clear lat_p_a lat_p_b lat_p_c lat_p_d lat_p_e
clear lon_p_a lon_p_b lon_p_c lon_p_d lon_p_e
% lat_p = interp1(ETA, [waypoints.lat],t,method);
% lon_p = interp1(ETA, [waypoints.lon],t,method);
[u_optP, azimuthP, distP] = computeJourney(lat_p,lon_p,t);
distInKmP = sum(distP);
fprintf( [method,' distance ',num2str(distInKmP),'km\n'] );

method = 'pchip';
lat_o3_a = interp1(ETA(first_leg), latO3(first_leg),t(mesh_first_leg),method);
lon_o3_a = interp1(ETA(first_leg), lonO3(first_leg),t(mesh_first_leg),method);
lat_o3_b = interp1(ETA(second_leg), latO3(second_leg),t(mesh_second_leg),linearly);
lon_o3_b = interp1(ETA(second_leg), lonO3(second_leg),t(mesh_second_leg),linearly);
lat_o3_c = interp1(ETA(third_leg), latO3(third_leg),t(mesh_third_leg),method);
lon_o3_c = interp1(ETA(third_leg), lonO3(third_leg),t(mesh_third_leg),method);
lat_o3_d = interp1(ETA(fourth_leg), latO3(fourth_leg),t(mesh_fourth_leg),linearly);
lon_o3_d = interp1(ETA(fourth_leg), lonO3(fourth_leg),t(mesh_fourth_leg),linearly);
lat_o3_e = interp1(ETA(fifth_leg), latO3(fifth_leg),t(mesh_fifth_leg),method);
lon_o3_e = interp1(ETA(fifth_leg), lonO3(fifth_leg),t(mesh_fifth_leg),method);
lat_o3 = [lat_o3_a(1:end-1); lat_o3_b(1:end-1); lat_o3_c(1:end-1); lat_o3_d(1:end-1); lat_o3_e];
lon_o3 = [lon_o3_a(1:end-1); lon_o3_b(1:end-1); lon_o3_c(1:end-1); lon_o3_d(1:end-1); lon_o3_e];
clear lat_o3_a lat_o3_b lat_o3_c lat_o3_d lat_o3_e
clear lon_o3_a lon_o3_b lon_o3_c lon_o3_d lon_o3_e
% lat_o3 = interp1(ETA, latO3,t,method);
% lon_o3 = interp1(ETA, lonO3,t,method);
[u_optO3, azimuthO3, distO3] = computeJourney(lat_o3,lon_o3,t);
distInKmO3 = sum(distO3);
fprintf( [method,' O3 distance ',num2str(distInKmO3),'km\n'] );

method = 'pchip';
lat_o5_a = interp1(ETA(first_leg), latO5(first_leg),t(mesh_first_leg),method);
lon_o5_a = interp1(ETA(first_leg), lonO5(first_leg),t(mesh_first_leg),method);
lat_o5_b = interp1(ETA(second_leg), latO5(second_leg),t(mesh_second_leg),linearly);
lon_o5_b = interp1(ETA(second_leg), lonO5(second_leg),t(mesh_second_leg),linearly);
lat_o5_c = interp1(ETA(third_leg), latO5(third_leg),t(mesh_third_leg),method);
lon_o5_c = interp1(ETA(third_leg), lonO5(third_leg),t(mesh_third_leg),method);
lat_o5_d = interp1(ETA(fourth_leg), latO5(fourth_leg),t(mesh_fourth_leg),linearly);
lon_o5_d = interp1(ETA(fourth_leg), lonO5(fourth_leg),t(mesh_fourth_leg),linearly);
lat_o5_e = interp1(ETA(fifth_leg), latO5(fifth_leg),t(mesh_fifth_leg),method);
lon_o5_e = interp1(ETA(fifth_leg), lonO5(fifth_leg),t(mesh_fifth_leg),method);
lat_o5 = [lat_o5_a(1:end-1); lat_o5_b(1:end-1); lat_o5_c(1:end-1); lat_o5_d(1:end-1); lat_o5_e];
lon_o5 = [lon_o5_a(1:end-1); lon_o5_b(1:end-1); lon_o5_c(1:end-1); lon_o5_d(1:end-1); lon_o5_e];
clear lat_o5_a lat_o5_b lat_o5_c lat_o5_d lat_o5_e
clear lon_o5_a lon_o5_b lon_o5_c lon_o5_d lon_o5_e
% lat_o5 = interp1(ETA, latO5,t,method);
% lon_o5 = interp1(ETA, lonO5,t,method);
[u_optO5, azimuthO5, distO5] = computeJourney(lat_o5,lon_o5,t);
distInKmO5 = sum(distO5);
fprintf( [method,' O5 distance ',num2str(distInKmO5),'km\n'] );

%% Prepare trajectory data to be exported
% as 1st WP is considered already reached, consider it to be t0=0
time = t - t(1);
%
% y ^
%   |
%   |____ x
% map the bearing angle from [0,360]deg to [-180,180] w/ 0 starting where
% the bearing angle is 90deg
ref_psi = zeros(size(azimuthO5)); %deg
for i = 1:size(azimuthO5,1)
    if azimuthO5(i)<270
        ref_psi(i) = deg2rad(90-azimuthO5(i));% rad
    else
        ref_psi(i) = deg2rad(360+90-azimuthO5(i)); %rad
    end
end

% span the velocity vector, each entry being valid for meshFactor-1 points
% ref_u = zeros((nOfWaypoints-1)*(meshFactor-1)+1,1);
ref_v = zeros((nOfWaypoints-1)*(meshFactor-1)+1,1);
ref_r = zeros((nOfWaypoints-1)*(meshFactor-1)+1,1);

%
ref_u = zeros(meshFactor - 1,size(section,2)-1);
for aa = 1:size(section,2)-1
    ref_u(:,aa) = diag(u_optO5(aa) * eye(meshFactor - 1));%kn
end
ref_u = reshape(ref_u,size(ref_u,1)*size(ref_u,2),1);%kn
ref_u(end+1) = u_optO5(end);

ref_v = zeros(size(ref_u));
ref_r = [diff(ref_psi); 0];

ref_y_dot = cos(deg2rad(azimuthO5)).*(ref_u.*0.51444); %m/s
ref_x_dot = sin(deg2rad(azimuthO5)).*(ref_u.*0.51444); %m/s

ref_y = cumtrapz(time,ref_y_dot); %m
ref_x = cumtrapz(time,ref_x_dot); %m
%% Save relevant data
thisdate = datestr(now,'yyyy-mm-dd_HH-MM');
save(fullfile(pwd,'A_Guidance\Data',['Optmisation_data_',routefile,thisdate,'.mat']));
save(fullfile(pwd,'A_Guidance\Data',['Trajectory_data_',routefile,thisdate,'.mat']),'time','ref_x','ref_y','ref_psi',...
    'ref_u','ref_v','ref_r');

%% Redraw map for nice exports
% axis tight
% lw = 2; %linewidth
orange = [ 0.9100, 0.4100, 0.1700];
pink = [0.854901969432831 0.701960802078247 1];
kaki =[0.466666668653488 0.674509823322296 0.18823529779911];
purple = [198 119 184]./255;
lime =[195 214 139]./255;
turqoise= [0 153 153]./255;
yellow =[237 208 121]./255;

set(0,'DefaultFigureColor','w','DefaultAxesFontSize',50,'DefaultLineLineWidth',3)
figure('units','normalized','outerposition',[0 0 1 1]);
xlabel('Longitude');ylabel('Latitude');
xlim([min([waypoints.lon]) max([waypoints.lon])]);
% ylim([min([waypoints.lat]) max([waypoints.lat])]);
hold on
plot(circlelon,circlelat,'Color','y');
% plot([waypoints.lon], [waypoints.lat],'Color',orange,'Marker','o');

% h(3) = plot([waypoints.lon], [waypoints.lat],'k-');

h(1) = plot(lon_s,lat_s,'Color',purple,'LineStyle','-.','Marker','o');
h(2) = plot(lon_p,lat_p,'b+-');

h(3) = plot(lon_o3,lat_o3,'Color','g','LineStyle','-','Marker','+');
h(4) = plot(lon_o5,lat_o5,'r+-');
% legend(h([3 1 2]),['Linear Interpolation:   ',num2str(distInKmN),'km'],...
%                     ['Spline Interpolation:   ',num2str(distInKmS),'km'],...
%                     ['Pchip interpolation:    ',num2str(distInKmP),'km']);
legend(h([1 2 3 4]),['Spline Interpolation:   ',num2str(distInKmS),'km'],...
                    ['Pchip interpolation:    ',num2str(distInKmP),'km'],...
                    ['3 points optimisation: ',num2str(distInKmO3),'km'],...
                    ['5 points optimisation: ',num2str(distInKmO5),'km']);
plot_google_map('maptype', 'terrain')

ax = gca;
outerpos = ax.OuterPosition;
ti = ax.TightInset; 
left = outerpos(1) + ti(1);
bottom = outerpos(2) + ti(2);
ax_width = outerpos(3) - ti(1) - ti(3);
ax_height = outerpos(4) - ti(2) - ti(4);
ax.Position = [left bottom ax_width ax_height];
clear ax outerpos ti left bottom ax_width ax_height

plot_google_map('Resize',4,'APIKey','AIzaSyC-MxD3-Pl_YjbTgQEu6sUK_W2k4h6D6CI');

%% Other nice plots
% figure
% plot([waypoints.lon]',[waypoints.lat]','ro','Linewidth',6);
% grid on
% hold on
% plot(lon_n,lat_n,'k','Linewidth',4);
% title('Simple path');
% legend('waypoint','path');xlabel('Longitude');ylabel('Latitude');
% set(gca,'fontsize',40)
% 
% figure
% plot([waypoints.lon]',[waypoints.lat]','ro','Linewidth',6);
% grid on
% hold on
% plot(lon_s,lat_s,'m--','Linewidth',4);
% hold on
% plot(lon_p,lat_p,'b','Linewidth',4);
% title('Simple smooth spline');
% legend('waypoint','spline','pchip');xlabel('Longitude');ylabel('Latitude');
% set(gca,'fontsize',40)
% 
% legend('waypoint','path');xlabel('Longitude');ylabel('Latitude');
% set(gca,'fontsize',40)

%
timeT =  2:size(section,2);
% plot(ETA(1:end-1),u,'ro',timeT,u_optS,'m-',timeT,u_optP,'b-',timeT,u_optO,'g--');
plot(timeT,u_optS,'m-',timeT,u_optP,'b-',timeT,u_optO5,'g--');
%% Results plot
figure
plot([waypoints.lon]',[waypoints.lat]','ro',lon_s,lat_s,'b',...
    lon_p,lat_p,'g',lon_o3,lat_o3,'c',lon_o5,lat_o5,'r');title('Trajectory Plot');
legend('waypoint','spline','pchip','3p optim','5p optim');
xlabel('Longitude');ylabel('Latitude');

figure
subplot(311)
plot([waypoints.lon]',[waypoints.lat]','ro',lon_s,lat_s,'m',...
    lon_p,lat_p,'b--');title('Trajectory Plot');
legend('waypoint','spline','pchip');xlabel('Longitude');ylabel('Latitude');
set(gca,'fontsize',15)

subplot(312)
plot(t,azimuthP,'ko');title('azimuth');
legend('bearing angle');xlabel('time');ylabel('angle(deg)');
set(gca,'fontsize',15)

subplot(313)
% bar([min(u_new) max(u_new) min(u_optS)...
%     max(u_optS) min(u_optP)  max(u_optP)...
%     min(u_optO)  max(u_optO)]);
% bar([min(diff(u_new)) max(diff(u_new)) min(diff(u_optS))...
%     max(diff(u_optS)) min(diff(u_optP))  max(diff(u_optP))...
%     min(diff(u_optO))  max(diff(u_optO))]);
bar( [min(azimuthN) min(azimuthP) min(azimuthS)...
    max(azimuthN)  max(azimuthP) max(azimuthS)] );
% bar( [min(diff(azimuthN)) min(diff(azimuthP)) min(diff(azimuthS))...
%     max(diff(azimuthN))  max(diff(azimuthP)) max(diff(azimuthS))] );
title('Bearing angle min and max variation');
