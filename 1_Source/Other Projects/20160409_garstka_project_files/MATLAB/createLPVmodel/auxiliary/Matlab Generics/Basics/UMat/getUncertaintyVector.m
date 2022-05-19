function [uvec, uNvec, ru] = getUncertaintyVector(umat)

    [Mumat, U, Blkstruct_umat, Normunc_umat] = lftdata(umat);
     
     ru = [Blkstruct_umat.Occurrences];
     
     unames = fieldnames(U.Uncertainty);
     for ii = 1:size(ru, 2)
         uvec(ii, 1) = U.Uncertainty.(unames(ii));
     end
     
     for ii = 1:size(ru, 2)
         uNvec(ii, 1) = Normunc_umat{ii};
     end
     