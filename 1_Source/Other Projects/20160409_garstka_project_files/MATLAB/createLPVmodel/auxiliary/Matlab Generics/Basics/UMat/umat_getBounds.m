function [DELTA_bnd, DELTA_nom] = umat_getBounds(uDELTA);

    DELTA_nom = uDELTA.NominalValue;

    [delta_bnd, delta_nom] = umat_getUncertaintyBounds(uDELTA);

    DELTA_bnd{1} = umat_subs(uDELTA, delta_bnd(:, 1));
    DELTA_bnd{2} = umat_subs(uDELTA, delta_bnd(:, 2));