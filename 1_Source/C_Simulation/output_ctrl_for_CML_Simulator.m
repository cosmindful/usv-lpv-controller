clc
timeInSec = 1:time(end);
new_lti_uss_inputs = resample(lti_uss_inputs, timeInSec);
sog = new_lti_uss_inputs.Data(:,1);
deflection = new_lti_uss_inputs.Data(:,2);

DataVec = zeros(size(timeInSec,2),3);
for i=1:timeInSec(end)
    DataVec(i,:) = [timeInSec(i) sog(i) deflection(i)];
end

% csvwrite('ctrl_inputs.csv',DataVec);

%% Verify resampling is ok
figure
grid on
subplot(2,1,1)
% plot(new_lti_uss_inputs.Time,new_lti_uss_inputs.Data(:,1),'r'); hold on
plot(lti_uss_inputs.Time,lti_uss_inputs.Data(:,1),'g-');
subplot(2,1,2)
% plot(new_lti_uss_inputs.Time,new_lti_uss_inputs.Data(:,2),'r'); hold on
plot(lti_uss_inputs.Time,lti_uss_inputs.Data(:,2),'g-');