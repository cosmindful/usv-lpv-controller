function Ntheta = NthetaOftheta(theta, theta_bnd)

    theta_mid   = (theta_bnd(:,2) + theta_bnd(:,1))/2;
    theta_range = (theta_bnd(:,2) - theta_bnd(:,1));

    Ntheta = 2*(theta - theta_mid)./theta_range;

    