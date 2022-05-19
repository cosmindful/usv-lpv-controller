clear all, clc
% rowOffset = 1;
% columnOffset = 0;
filename = 'Cosmin MT V02.csv';
% file = csvread(filename,rowOffset,columnOffset);

%rt is permission r for read t for open in text mode
csv_file = fopen(filename,'rt');

%the formatspec represents what the scan is 'looking'for. 
formatSpec = '%s';

%textscan inputs work in pairs so your scanning the file using the format
%defined above and with a semicolon delimeter
C = textscan(csv_file, formatSpec, 'Delimiter', ';');
fclose(csv_file);

data = C{1,1};
data = data(12:end);
%%
routefile = 'Cux_Visby.rtz';
% global waypoints nOfWaypoints
% extract the waypoints, the given time to reach each one of them and the
% recommended vessel velocity
[waypoints, ~, ~, ~] = parseRoute(routefile);
% use the following section to select fewer Waypoints
section = 1:size(waypoints,1);
waypoints = waypoints(section);

nOfWaypoints = size(waypoints,1);
offset = 0.42;
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

circleRadiuses = 1.8;
[h,circlelat,circlelon] = circlem([waypoints.lat],[waypoints.lon],circleRadiuses,'facecolor','green');

geoshow([waypoints.lat],[waypoints.lon]);
% plot_google_map
% for narrow sectors .1 nm, and broad sectors: 1 nm
%%
lat = zeros(15002,1);
lon = zeros(15002,1);
cog = zeros(15002,1);
sog = zeros(15002,1);
th = zeros(15002,1);
j=1;
for i=2:11:size(data,1)
    lat(j,1) = str2double(strrep(data(i), ',', '.'));
    lon(j,1) = str2double(strrep(data(i+1), ',', '.'));
    cog(j,1) = str2double(strrep(data(i+2), ',', '.'));
    sog(j,1) = str2double(strrep(data(i+3), ',', '.'));
    th(j,1) = str2double(strrep(data(i+5), ',', '.'));
    j = j+1;
end
stopTime= 15619 ;
lat = lat(1:stopTime,1);
lon = lon(1:stopTime,1);

% lat_d = diff(lat)
% for j=2:size(lat,1)-1
%     lat(j) = lat(j-1) - lat_d(j);
% end

lat_offset = [waypoints(1).lat] - lat(1);
lon_offset = [waypoints(1).lon] - lon(1);

for j=1:size(lat,1)
    lat(j) = lat(j) + lat_offset;
    lon(j) = lon(j) + lon_offset;
end
geoshow(lat,lon)
% plot(lon,lat)
% figure
% subplot(2,1,1)
% plot(time, ref_u, 1:size(sog,1),sog); 
% legend('sog reference [kn]','sog real [kn]')
% subplot(2,1,2)
% plot(time, 90-(180/pi.*ref_psi),1:size(cog,1),cog);
% legend('cog reference [deg]','cog real [deg]')

% [row, col] = size(C);
% for kk = 1 : col
%     A = C{1,kk};
%     converted_data{1,kk} = str2double(strrep(A, ',', '.'));
% end
% 
% celldisp(converted_data)


%%
dist = 0;
for i =1:size(lat,1)-1
    dist =dist + lldistkm([lat(i),lon(i)],[lat(i+1),lon(i+1)]);
end
dist

%%
distRef = 0;
latRef = [waypoints.lat];
lonRef = [waypoints.lon];
for i =1:size([waypoints.lat],2)-1
    distRef =distRef + lldistkm([latRef(i) lonRef(i)],[latRef(i+1) lonRef(i+1)]);
end
distRef