function az = llbearingangle(lat1,lon1,lat2,lon2)
% 
% = atan2( sin Δλ ⋅ cos φ2 , cos φ1 ⋅ sin φ2 − sin φ1 ⋅ cos φ2 ⋅ cos Δλ )
% where	φ1,λ1 is the start point, φ2,λ2 the end point (Δλ is the difference in longitude)
% ATAN2(COS(lat1)*SIN(lat2)-SIN(lat1)*COS(lat2)*COS(lon2-lon1), 
%        SIN(lon2-lon1)*COS(lat2)) 
radius=6371;
lat1=lat1*pi/180;
lat2=lat2*pi/180;
lon1=lon1*pi/180;
lon2=lon2*pi/180;
% deltaLat=lat2-lat1;
deltaLon=lon2-lon1;

y = sin(deltaLon)*cos(lat2);
x = cos(lat1)*sin(lat2)-sin(lat1)*cos(lat2)*cos(deltaLon);
az = rad2deg(atan2(y,x));
end