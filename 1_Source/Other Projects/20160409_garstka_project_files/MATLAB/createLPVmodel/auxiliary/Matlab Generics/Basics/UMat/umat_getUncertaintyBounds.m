function [delta_bnd, delta_nom] = umat_getUncertaintyBounds(uDELTA)

     deltaNames = fieldnames(uDELTA.Uncertainty);
     numDeltas  = length(deltaNames);
     
     for ii = 1:numDeltas
        delta_bnd(ii, :) = uDELTA.Uncertainty.(deltaNames{ii}).Range;
        delta_nom(ii)    = uDELTA.Uncertainty.(deltaNames{ii}).NominalValue;
     end