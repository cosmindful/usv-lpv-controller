function qDH = qMod2DH(qMod)

qDH = qMod;

qDH(2, :) =   qMod(2, :) + pi/2                  ;
qDH(3, :) = - qMod(2, :)        + qMod(3, :) - pi;
