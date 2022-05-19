function Xd=Xd(X);

y =[X(1);X(3);X(5);X(7);X(9);X(11)];
yd=[X(2);X(4);X(6);X(8);X(10);X(12)];

Xdd=inv(inert(y))*(-[yd.'*cor1(y)*yd;yd.'*cor2(y)*yd;yd.'*cor3(y)*yd;yd.'*cor4(y)*yd;yd.'*cor5(y)*yd;yd.'*cor6(y)*yd]-grav(y)-fric(yd,y));


Xd=[X(2);Xdd(1);X(4);Xdd(2);X(6);Xdd(3);X(8);Xdd(4);X(10);Xdd(5);X(12);Xdd(6)];
