function qdMod = qdDH2Mod(qdDH)

qdMod = qdDH;

qdMod(2, :) = qdDH(2, :)                 ;
qdMod(3, :) = qdDH(2, :) + qdDH(3, :) ;