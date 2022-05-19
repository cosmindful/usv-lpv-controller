function [MultiplierConstraints, PiRR, PiRS, PiRQ, PiSR, PiSS, PiSQ] = formulateLMI_multiplierConstraintsDG(DeltaBlock)

dB = 1e-5;
% dB = 0;

ntheta = DeltaBlock.ntheta;
rtheta = DeltaBlock.rtheta;

% S-Procedure scalings
    % Requirements: THETA*R = R*THETA, THETA*S = S*THETA
    for i = 1:ntheta
        PiRRblock{i}   = sdpvar(rtheta(1,i), rtheta(1,i), 'symmetric'  );
        PiRSblock{i}   = sdpvar(rtheta(1,i), rtheta(1,i), 'skew'       );
        PiSRblock{i}   = sdpvar(rtheta(1,i), rtheta(1,i), 'symmetric'  );
        PiSSblock{i}   = sdpvar(rtheta(1,i), rtheta(1,i), 'skew'       );
        assign(PiRRblock{i}, 0);
        assign(PiRSblock{i}, 0);
        assign(PiSRblock{i}, 0);
        assign(PiSSblock{i}, 0);
    end
    
    % Assemble to one big R matrix / S matrix
    if (ntheta > 10)
        PiRS   =  mdiag(PiRSblock{1:10});
        PiRS   =  mdiag(PiRS, PiRSblock{11:end});
        PiRR   =  mdiag(PiRRblock{1:10});
        PiRR   =  mdiag(PiRR, PiRRblock{11:end});
        PiRQ   =  -PiRR;

        PiSS   =  mdiag(PiSSblock{1:10});
        PiSS   =  mdiag(PiSS, PiSSblock{11:end});
        PiSR   =  mdiag(PiSRblock{1:10});
        PiSR   =  mdiag(PiSR, PiSRblock{11:end});
        PiSQ   =  -PiSR;
    else
        PiRS   =  mdiag(PiRSblock{:});
        PiRR   =  mdiag(PiRRblock{:});
        PiRQ   =  -PiRR;

        PiSS   =  mdiag(PiSSblock{:});
        PiSR   =  mdiag(PiSRblock{:});
        PiSQ   =  -PiSR;
    end
    
    PiR  = [PiRR  , PiRS'  ;...
            PiRS  , PiRQ  ];
  
    PiS  = [-PiSQ  ,  PiSS  ;...
             PiSS' , -PiSR ];
         
%     PiS  = [-PiSR  ,  PiSS' ;...
%              PiSS  , -PiSQ ];

        
    MultiplierConstraints =                          [PiRR >= dB];%, 'Positive Definiteness of Scaling PiR11');
    MultiplierConstraints = [MultiplierConstraints,   PiSR >= dB];%, 'Positive Definiteness of Scaling PiS11');
    
    couplingConstraintRR = [PiRR                             I(size(PiRR, 1), size(PiSR, 2));...
                            I(size(PiSR, 1), size(PiRR, 2))  PiSR                           ];
                        
    couplingConstraintQQ = [PiRQ                             I(size(PiRQ, 1), size(PiSQ, 2));...
                            I(size(PiSQ, 1), size(PiRQ, 2))  PiSQ                           ];
                        
    MultiplierConstraints = [MultiplierConstraints,   couplingConstraintRR >=  dB];%, 'Coupling constraint on PiRR, PiSR');
    MultiplierConstraints = [MultiplierConstraints,   couplingConstraintQQ <= -dB];%, 'Coupling constraint on PiRR, PiSR');

    
   