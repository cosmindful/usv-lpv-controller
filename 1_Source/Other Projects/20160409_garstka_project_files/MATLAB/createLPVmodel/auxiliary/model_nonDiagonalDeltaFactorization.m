function [Lj, Deltaj, Rj, subsDeltaNominal] = model_nonDiagonalDeltaFactorization(uDELTA);

[M, Delta, Blkstruct, Normunc] = lftdata(uDELTA);

     rDelta     = [Blkstruct.Occurrences];
     
     deltaNames = fieldnames(Delta.Uncertainty);
     numDeltas  = length(deltaNames);
     

     for ii = 1:numDeltas
        subsStructNominal.(deltaNames{ii}) = 0;
     end
     subsDeltaNominal = usubs(uDELTA, subsStructNominal);
     
     for jj = 1:numDeltas
        for ii = 1:numDeltas
            subsStruct(jj).(deltaNames{ii}) = double(ii == jj);
        end
        
           Deltaj{jj} = Delta.Uncertainty.(deltaNames{jj});
        subsDelta{jj} = usubs(uDELTA, subsStruct(jj)) - subsDeltaNominal;
        
        [U,S,V] = svd(subsDelta{jj});
        
        Lj{jj} = U*sqrtm(S);
        Lj{jj} = removeconstantrows(Lj{jj}')';
        Rj{jj} = (sqrtm(S)*V')';
        Rj{jj} = removeconstantrows(Rj{jj}')';
     end
