function fric=fric(yd,y);

fc=parfric;
fric=[fc(11)*yd(1)+fc(12)*sign(yd(1));fc(9)*yd(2)+fc(10)*sign(yd(2));fc(7)*yd(3)+fc(8)*sign(yd(3));fc(5)*yd(4)+fc(6)*sign(yd(4));fc(3)*yd(5)+fc(4)*sign(yd(5));fc(1)*yd(6)+fc(2)*sign(yd(6))];