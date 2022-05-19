function qMod = qDH2Mod(qDH)

qMod = qDH;

qMod(2, :) = qDH(2, :)  - pi/2                 ;
qMod(3, :) = qDH(2, :)  - pi/2 + qDH(3, :) + pi;