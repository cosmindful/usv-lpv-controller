function grav=grav(y);
% G is (6*19) regressor matrix from symbolic toolbox
% grav is predicted gravity matrix

G=[                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0;...
                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,  981/100*sin(y(5))*cos(y(4))*sin(y(2))*sin(y(3))-981/100*sin(y(5))*cos(y(4))*cos(y(2))*cos(y(3))-981/100*cos(y(5))*sin(y(2))*cos(y(3))-981/100*cos(y(5))*cos(y(2))*sin(y(3)),                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                 -981/100*cos(y(2))*sin(y(3))-981/100*sin(y(2))*cos(y(3)),                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                  981/100*cos(y(2)),                                                                                                                                 -981/100*sin(y(2)),                                                                                                                                                0;...
                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,  981/100*sin(y(5))*cos(y(4))*sin(y(2))*sin(y(3))-981/100*sin(y(5))*cos(y(4))*cos(y(2))*cos(y(3))-981/100*cos(y(5))*sin(y(2))*cos(y(3))-981/100*cos(y(5))*cos(y(2))*sin(y(3)),                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                 -981/100*cos(y(2))*sin(y(3))-981/100*sin(y(2))*cos(y(3)),                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0;...
                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                        981/100*sin(y(5))*sin(y(4))*(cos(y(2))*sin(y(3))+sin(y(2))*cos(y(3))),                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0;...
                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0, -981/100*sin(y(5))*cos(y(2))*cos(y(3))+981/100*sin(y(2))*sin(y(3))*sin(y(5))-981/100*cos(y(4))*cos(y(5))*sin(y(2))*cos(y(3))-981/100*cos(y(4))*cos(y(5))*cos(y(2))*sin(y(3)),                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0;...
                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0,                                                                                                                                                0];
                                                                                                                                            
%%%%%%%%%%%
grav=G*pardyn;