function [Lj, NDeltaj, Rj, subsDeltaNominal] = model_nonDiagonalNormalizedDeltaFactorization(uDELTA)
% Constructs factorization, such that
% uDELTA = SUM Lj * NDeltaj * Rj'
% where NDeltaj is normalized between [-1, 1]

[M, Delta, Blkstruct, Normunc] = lftdata(uDELTA);

     rDelta     = [Blkstruct.Occurrences];
     
     deltaNames = fieldnames(Delta.Uncertainty);
     numDeltas  = length(deltaNames);
     
    [delta_bnd, delta_nom] = umat_getUncertaintyBounds(uDELTA);
     
     % Substituting nominal value
     % Substituting zeros or ones is not correct!
%      for ii = 1:numDeltas
%         subsStructNominal.(deltaNames{ii}) = delta_mid(ii);
%      end
%      subsDeltaNominal = usubs(uDELTA, subsStructNominal);
     subsDeltaNominal = uDELTA.NominalValue;
     subsDeltaNominal(abs(subsDeltaNominal) < 1e-8) = 0;
     
     for jj = 1:numDeltas
        for ii = 1:numDeltas
            % Take nominal value if ii ~= jj, otherwise upper bound
            subsStruct_upperBound(jj).(deltaNames{ii}) = delta_bnd(ii, 2)*double(ii == jj) + delta_nom(ii)*(1-double(ii == jj));%double(ii == jj);
            subsStruct_lowerBound(jj).(deltaNames{ii}) = delta_bnd(ii, 1)*double(ii == jj) + delta_nom(ii)*(1-double(ii == jj));%double(ii == jj);
        end
        
          NDeltaj{jj} = Delta.Uncertainty.(deltaNames{jj});
        subsDelta_upperBound{jj} = usubs(uDELTA, subsStruct_upperBound(jj)) - subsDeltaNominal;
        subsDelta_lowerBound{jj} = usubs(uDELTA, subsStruct_lowerBound(jj)) - subsDeltaNominal;
        
        subsDelta_upperBound{jj}(abs(subsDelta_upperBound{jj}) < 1e-8) = 0;
        subsDelta_lowerBound{jj}(abs(subsDelta_lowerBound{jj}) < 1e-8) = 0;
        
        [Uu,Su,Vu] = svd(subsDelta_upperBound{jj});
        [Ul,Sl,Vl] = svd(subsDelta_lowerBound{jj});
        
        [nwSu, nzSu] = size(Su);
        
        % For non-square blocks
        if nwSu == nzSu
            SQRTSu = sqrtm(Su);
        else
            SQRTSu = O(nwSu, nzSu);
            if nwSu < nzSu
                SQRTSu(1:nwSu, 1:nwSu) = sqrtm(Su(1:nwSu, 1:nwSu));
            else
                SQRTSu(1:nzSu, 1:nzSu) = sqrtm(Su(1:nzSu, 1:nzSu));
            end
        end
        
        Lj{jj} = Uu*SQRTSu;
        Lj{jj} = removeconstantrows(Lj{jj}')';
        Rj{jj} = (SQRTSu*Vu')';
        Rj{jj} = removeconstantrows(Rj{jj}')';
     end
