function [varargout] = parseRouteFile(routefile)
%PARSEROUTE This script fetches navigation data from a routing file
%   waypoints = parseRoute(routefile) returns the waypoints from the file
%   as a struct with lat, lon (in decimal degrees) as components
%
%   [waypoints, deltaETA] = parseRoute(routefile) returns the waypoints 
%   and the given time interval (in seconds) to reach them
%
%   [waypoints, time, speed] = parseRoute(routefile) returns the waypoints, 
%   the given time interval and recommended speed(in knots) to reach them
%
%   [waypoints, time, speed, eta] = parseRoute(routefile) returns the
%   waypoints, the given time interval and recommended speed(in knots) and
%   the estimated time of arrival(ETA) for every waypoint
  
% try to open the routefile
try
    xDoc = xmlread(fullfile(pwd,'A_Guidance',routefile));
catch
    error('Failed to read XML/RTZ file %s.',routefile,...
        '\n Please check that you are in the Source/ folder');
end

% change here if .RTZ file in older or newer version
if strcmp(routefile,'2_Puerto Ordaz-Kingsnorth_TS_WP0_4223830877.rtz')
    etaFormat = 'dd-mm-yyyy HH:MM:SS';
else
    etaFormat = 'yyyy-mm-ddTHH:MM:SS';
end

% grab the 'routeinfo' element of the routefile and 
startTimeRaw = char(xDoc.getElementsByTagName('routeInfo').item(0).getAttribute('lastChanged'));
startTime = datetime(startTimeRaw(4:end),'InputFormat','MMM dd HH:mm:ss yyyy','Locale','de_DE');
startTime = datevec(startTime);
clear startTimeRaw

% grab all fields that contains the 'waypoint' tag in the routefile. The
% output is also a list that has to be browsed later
allWayPoints = xDoc.getElementsByTagName('waypoint');
latitude = repmat(cellstr(''), allWayPoints.getLength,1);
longitude= repmat(cellstr(''), allWayPoints.getLength,1);

% browse the list of waypoints and grab the position elements of each
% waypoint. Each waypoint has only one position element. Each position has
% one latitute or longitude. Save latitude/longitude in the waypoint struct
for index = 0:allWayPoints.getLength-1
    thisWayPoint = allWayPoints.item(index);
    thisPosition = thisWayPoint.getElementsByTagName('position');
    latitude{index+1} = str2double(char(thisPosition.item(0).getAttribute('lat')));
    longitude{index+1} = str2double(char(thisPosition.item(0).getAttribute('lon')));
end
waypoints = struct('lat',latitude,'lon',longitude);
clear index allWayPoints thisPosition thisWayPoint latitude longitude

% grab the calculated itinerary and fetch al scheduling elements as a list
theCalculation = xDoc.getElementsByTagName('calculated').item(0);
allScheduleElements = theCalculation.getElementsByTagName('scheduleElement');
clear theCalculation
etaDate = repmat(cellstr(''), allScheduleElements.getLength,1);
speed = repmat(cellstr(''), allScheduleElements.getLength,1);
deltaETA = repmat(cellstr(''), allScheduleElements.getLength,1);
% declare ETA also as repmat for easier working with other variables
etaInSeconds = repmat(cellstr(''), allScheduleElements.getLength,1);

% browse the list of scheduling elements and extract the attributes
% referring ETA and speed. By comparing the ETA between every 2 waypoints
% compute the time interval [seconds]
% delta(i) = eta(i+1) - eta(i)

for index = 0:allScheduleElements.getLength-1
    etaDate{index+1} = char(allScheduleElements.item(index).getAttribute('eta'));
    speed{index+1} = str2double(allScheduleElements.item(index).getAttribute('speed'));
end

for index = 0:allScheduleElements.getLength-1
    if index == 0
        deltaETA{index+1} = etime(datevec(etaDate{index+1},etaFormat),startTime);
        etaInSeconds{index+1} =  deltaETA{index+1};
    else
        deltaETA{index+1} = etime(datevec(etaDate{index+1},etaFormat),datevec(etaDate{index},etaFormat));
        etaInSeconds{index+1} = etaInSeconds{index} + deltaETA{index+1};
    end
    
    if strcmp(routefile,'Cux_Visby.rtz')
        deltaETA{1} = 0;
        etaInSeconds{1} = 0;
    end
end
clear index allScheduleElements startTime xDoc

% output the desired parameters based on the number of output variables
if nargout == 4
    varargout{1} = waypoints;
    varargout{2} = cell2mat(deltaETA);
    varargout{3} = cell2mat(speed);
    varargout{4} = cell2mat(etaInSeconds);
elseif nargout == 3
    varargout{1} = waypoints;
    varargout{2} = cell2mat(deltaETA);
    varargout{3} = cell2mat(speed);
elseif nargout == 2
    varargout{1} = waypoints;
    varargout{2} = cell2mat(deltaETA);
else
    varargout = waypoints;
    
end

