function sSS = uss2sss(uSS);
%%

if strcmp(class(uSS), 'uss')
    
    [M, uDelta, Blkstruct, Normunc] = lftdata(uSS);

    nx = size(uSS.a, 1);
    nu = size(uSS.b, 2);
    ny = size(uSS.c, 1);

    sA = umat2smat(uSS.a);
    sB = umat2smat(uSS.b);
    sC = umat2smat(uSS.c);
    sD = umat2smat(uSS.d);

    sSS.a  = sA;
    sSS.b  = sB;
    sSS.c  = sC;
    sSS.d  = sD;
    
else
    
    sSS = uSS;
    
end