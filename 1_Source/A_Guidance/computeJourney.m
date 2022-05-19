function [u_opt, azimuthAngle, distancesVector] = computeJourney(varargin)
% extra stuff for being a fct %%%%%%%%%%%%%%%%
global meshFactor
myMeshFactor = meshFactor;
if nargin == 2
    %     myMeshFactor = meshFactor;
else
    %     myMeshFactor = varargin{3};
    time = varargin{3};
end
global nOfWaypoints deltaETA
lat = varargin{1};
lon = varargin{2};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% initialise vector for archiving distance between waypoints (WP)
distancesVector=zeros(length(lat)-1,1);
distBetweenWPPair = 0;
wpIndex = 0;

u_opt = zeros(nOfWaypoints-1,1);
% u_opt(1) = u(1);
u_betweenMP = zeros(length(lat)-1,1);

azimuthAngle= zeros(length(lat),1);
% azimuth(1) = 0;
% azimuth(end)= 0;
lastPos = 1;

% first WP is considered the starting point, thus the array of distances,
% azimuths and velocities are computed considering the current and the next
% MeshPoint/Waypoint. This gives arrays that have a size of N-1, where N is
% the total number of points considered (#WP-1)*(#Meshpoint-1)+1. The Nth
% component of these vectors can be considered 0 for the distance and the
% last values for the azimuth and velocity.
for meshIndex = 1:length(lat)-1
    % calculate dist between each the current and previous mesh points
    [deltaDist,~] = lldistkm([lat(meshIndex) lon(meshIndex)],...
        [lat(meshIndex+1) lon(meshIndex+1)]);
    % add mesh distance to the distance between current 2 WP
    distBetweenWPPair = distBetweenWPPair + deltaDist;
    % save the distance between current 2 Meshpoints
    distancesVector(meshIndex) = deltaDist;
    % calculate azimuth angle between current and previous mesh points
%     azimuth(meshIndex) = llbearingangle(lat(meshIndex),lon(meshIndex),...
%         lat(meshIndex+1),lon(meshIndex+1));
    azimuthAngle(meshIndex) = azimuth(lat(meshIndex),lon(meshIndex),...
        lat(meshIndex+1),lon(meshIndex+1));
    % if the mesh point counter reaches a multiple of the mesh factor,
    % then another WP is reached
    %     meshIndex+1;
    u_betweenMP(meshIndex) = 0.539956803 * 3600 * deltaDist / time(wpIndex+1);
    % as we have myMeshFactor-2 number of points between each 2 Waypoints
    % and thus myMeshFactor-1 distances, when the meshIndex reaches a
    % multiple of myMeshFactor-1, then we have already computed all
    % distances between the 2 Waypoints and we can proceed to the next pair
    % of WaypointsS
    if mod(meshIndex,myMeshFactor-1)==0
        %         disp(distBetweenWPPair)
        % change WP index
        wpIndex = wpIndex+1;
        % compute the optimal velocity as v = d/dT [kn] between the 2 WP
        % current vel = distance to next WP / time to reach the next WP
        % u(i) = d(WP(i),WP(i+1)) / deltaETA(i+1)
        %         u_betweenWP = 0.539956803 * 3600 * distBetweenWPPair / deltaETA(wpIndex);
        u_betweenWP = 0.539956803 * 3600 * distBetweenWPPair / deltaETA(wpIndex+1);
        u_opt(wpIndex) = u_betweenWP;
        lastPos = meshIndex;
        % archive the distance between the 2 WP
        distancesVector(wpIndex) = distBetweenWPPair;
        % reset the distance between past 2 WP
        distBetweenWPPair = 0;
    end
end
azimuthAngle(end) = azimuthAngle(end-1);
% u_opt(end) = u_opt(end-1);
end