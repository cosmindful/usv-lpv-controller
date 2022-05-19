function [MultiplierConstraints, PiRR, PiRS, PiRQ, PiSR, PiSS, PiSQ] = formulateLMI_multiplierConstraintsFBSP(DeltaBlock)

dB = 1e-18;
% dB = 0;

ntheta = DeltaBlock.ntheta;
rtheta = DeltaBlock.rtheta;
wtheta = size(DeltaBlock.THETAP, 1);
ztheta = size(DeltaBlock.THETAP, 2);

[Lj, Thetaj, Rj, THETANominal] = model_nonDiagonalDeltaFactorization(DeltaBlock.THETAP);

%% S-Procedure scalings
        PiRR   = sdpvar(ztheta, wtheta, 'symmetric'  );
        PiRQ   = sdpvar(ztheta, wtheta, 'symmetric'  );
        PiRS   = sdpvar(ztheta, wtheta, 'full'       );
        PiSR   = sdpvar(ztheta, wtheta, 'symmetric'  );
        PiSQ   = sdpvar(ztheta, wtheta, 'symmetric'  );
        PiSS   = sdpvar(ztheta, wtheta, 'full'       );
        assign(PiRR,  0);
        assign(PiRQ,  0);
        assign(PiRS,  0);
        assign(PiSR,  0);
        assign(PiSS,  0);
        assign(PiSQ,  0);
    
    PiR  = [PiRQ  , PiRS  ;...
            PiRS' , PiRR  ];
  
    PiS  = [PiSQ  , PiSS  ;...
            PiSS' , PiSR ];

    MultiplierConstraints = [                         PiRR >=  dB];
    MultiplierConstraints = [MultiplierConstraints,   PiRQ <= -dB];
    MultiplierConstraints = [MultiplierConstraints,   PiSQ <= -dB];
    MultiplierConstraints = [MultiplierConstraints,   PiSR >=  dB];
    
    %% Generate vertices
    DeltajRange  = [-1, 1];
    DeltajValues = DeltajRange;
    for ii = 1:(ntheta-1)
        DeltajValues = combvec(DeltajValues, DeltajRange);
    end
    
    numVertices = size(DeltajValues, 2);
    if (numVertices > 2^5)
        disp(sprintf('Alert! Number of vertices = %9.4e\n ',numVertices));
    end
    
    for ii = 1:numVertices
        THETAPeval = THETANominal;
        for jj = 1:ntheta
            THETAPeval = THETAPeval + Lj{jj}*DeltajValues(jj, ii)*Rj{jj}';
        end
        
        vertexConstraintPiR   = [THETAPeval; I(wtheta)]' * PiR * [THETAPeval; I(wtheta)];
        vertexConstraintPiS   = [I(wtheta); -THETAPeval']' * PiS * [I(wtheta); -THETAPeval'];
        MultiplierConstraints = [MultiplierConstraints,   vertexConstraintPiR >=   dB];
        MultiplierConstraints = [MultiplierConstraints,   vertexConstraintPiS <=  -dB];  
    end
   