load Optimisation_data_2017-10-18.mat
offset = .02;
segment = 80:100;
lonlim = [min([waypoints(segment).lon])-offset max([waypoints(segment).lon])+offset];
latlim = [min([waypoints(segment).lat])-offset max([waypoints(segment).lat])+offset];


% w = axesm('miller','Frame','off','LabelUnits', 'degrees',...
%     'maplatlim',latlim,'maplonlim',lonlim);
% mlabel; plabel;
set(0,'DefaultFigureColor','w','DefaultAxesFontSize',25,...
    'DefaultFigureUnits','centimeters',...
    'DefaultFigurePosition',[1 1 15.9 10],...
    'DefaultFigurePaperPositionMode','auto')
w = worldmap(latlim, lonlim);
% set(gcf,'color','w');
setm(w,'Frame','off','FontSize',25,'grid','off');
xticks = lonlim(1):.001:lonlim(2);
yticks = latlim(1):.001:latlim(2);
set(w,'XMinorGrid','on','XTick', xticks, 'YTick', yticks)
land = shaperead('landareas.shp', 'UseGeoCoords', true);
geoshow(land, 'FaceColor', [0.15 0.5 0.15]);

[h,circlelat,circlelon] = circlem([waypoints.lat],[waypoints.lon],.3,'facecolor','green');

geoshow([waypoints.lat],[waypoints.lon]);
geoshow(latO3,lonO3,'Color','cyan');
geoshow(latO5,lonO5,'Color','red');

set(findall(gcf,'type','line'),'linewidth',4)
legend('Waypoint','Direct path',...
    '3p Optimisation path','5p Optimization path',...
    'other','other');

