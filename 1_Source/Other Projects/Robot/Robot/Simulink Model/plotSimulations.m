%% Plot simulation results

t = Kinit_phi1_q2qr2.time;

% Reference
plot(t, Kinit_phi1_q2qr2.signals.values(:, 2));
hold on

% Kinit w/o optimization
plot(t, Kinit_phi1_q2qr2.signals.values(:, 1), 'r');

% Kopt
plot(t, Kopt_phi1_q2qr2.signals.values(:, 1), 'k');

%% MSE
MSEKinit = sqrt(mean((Kinit_phi1_q2qr2.signals.values(:, 1) - Kinit_phi1_q2qr2.signals.values(:, 2)).^2))
MSEKopt  = sqrt(mean((Kopt_phi1_q2qr2.signals.values(:, 1) - Kopt_phi1_q2qr2.signals.values(:, 2)).^2))
MSEPD    = sqrt(mean((KPD_q2qr2.signals.values(:, 1) - KPD_q2qr2.signals.values(:, 2)).^2))
