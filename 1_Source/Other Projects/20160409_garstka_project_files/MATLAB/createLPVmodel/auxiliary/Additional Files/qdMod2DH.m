function qdDH = qdMod2DH(qdMod)

qdDH = qdMod;

qdDH(2, :) =   qdMod(2, :)                   ;
qdDH(3, :) = - qdMod(2, :)       + qdMod(3, :);
