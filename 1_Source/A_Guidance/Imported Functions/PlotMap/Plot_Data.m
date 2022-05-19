clear;
%% Load data 
load data.mat

name = 'SomeShip';
maxSogc = 18;
colors = jet(max(10));
sogc(find(sogc>maxSogc))= maxSogc; %% replace speed vlaues higher than 10% of max sog

%% Plot Map
% Setup the default figure options to look good when printed
set(0,'DefaultFigureColor','w','DefaultAxesFontSize',15,...
    'DefaultFigureUnits','centimeters',...
    'DefaultFigurePosition',[1 1 15.9 10],...
    'DefaultFigurePaperPositionMode','auto')

map = figure('Units', 'centimeters', 'Position',  [5, 5, 20, 15]);
axis tight manual 
set(gca,'nextplot','replacechildren'); 
lonOff = 2;
latOff = 2;
lonlim = [min(longc)-lonOff max(longc)+lonOff];
latlim = [min(latc)-latOff max(latc)+latOff];

% generate world map and see countries
w = worldmap(latlim, lonlim);

setm(w,'LabelUnits', 'degrees');
xticks = lonlim(1):.1:lonlim(2);
yticks = latlim(1):.1:latlim(2);
set(w, 'XMinorGrid','on','XTick', xticks, 'YTick', yticks)
land = shaperead('landareas.shp', 'UseGeoCoords', true);
geoshow(land, 'FaceColor', [0.15 0.5 0.15]);

% colour bar design
colls = min(sogc):0.1:max(sogc);
CM = jet(length(colls));
caxis([min(sogc) max(sogc)]);
colormap('jet');
c = colorbar;
c.Label.String = 'Speed [knots]';
c.Label.FontSize = 12;

%% Plot colour plot of SOG
pack;
steps = length(latc);
for i = 1:steps
geoshow(latc(i),longc(i), 'DisplayType', 'point', 'MarkerSize', 10, 'Marker', '.', 'MarkerEdgeColor', CM(round((sogc(i)+.1-min(sogc))*10),:));
end

%% Safe figure
safeFig = [name '_sog.png'];
saveas(map, safeFig);
close(map);



