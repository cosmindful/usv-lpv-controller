function [sys, x0, str, ts] = s1FunctionPolytopicLPV(t, x, u, flag, K, x0, parameterVector, theta_bnds, T_sample, how, poly_A, poly_b);
%
% S-Function that simulates an LPV controller.
%

% Copyright
% A. Kwiatkowski
% Department of Control Engineering
% University of Technology Hamburg-Harburg
% 10.01.05

% [Sebastian, 29.08.06]   
% new function POLYDEC2 replacing POLYDEC for support of
% vertices of general convex set (e.g. intersection set)
%
% [Sebastian, 30.08.06]
% Added input arguments poly_A, poly_b, necessary for pv of type 'pol'.
% poly_A, poly_b represent polytope as inequality constraints 
%   poly_A * x <= poly_b.
% Used for check if theta inside polytope and correction of theta in case
% that 1 inequality is violated.
%
% [Andreas 8,12,06]
% changed variable names from ys to rho

% Initialize default outputs
str = [];
ts  = [-1 0];
sys = x0;
x0  = x0;


% Input handling
% -------------------------------------------------------------------------

% Continuous time simulation
if (nargin < 10) | (isempty(T_sample))
   Ts = -1;
   T_sample = [];
else
   Ts = T_sample;
end

if nargin < 11  how = [];       end;

if nargin < 12  poly_A = [];    end;

if nargin < 13  poly_b = [];    end;

% For discrete time control, the method of discretization and sampling
% time need to be specified.
% if xor(isempty(how), isempty(T_sample))
%     error('T_SAMPLE and HOW need to be provided both.');
% end;

% Retrieve information about the parameter vector
[parameterVectorType      , ...
 parameterVectorParameters, ...
 parameterVectorVertices        ] = pvinfo(parameterVector);

if (strcmp(parameterVectorType, 'pol')) & ...
   (isempty(poly_A) | isempty(poly_b))
    error('Inequality constrains representation of polytope (POLY_A*x <= POLY_b) not provided.');
end;


% S-Function Flag
% -------------------------------------------------------------------------
% Not in initialization phase
if flag ~= 0

    % Retrieve information about controller
   [controllerType              , ...
    num_ControllerSystemMatrices, ...
    num_ControllerStates        , ...
    num_ControllerInputs        , ...
    num_ControllerOutputs             ] = psinfo(K);

   is_x_error = 0;
   is_t_error = 0;
   
   % Check whether prespecified bounds on the scheduling signals rho are
   % violated.
   for i = 1:size(theta_bnds, 1)
      if (u(i) < theta_bnds(i, 1))
       %  disp(['Output -' num2str(i) '- with value rho =' num2str(u(i)) ' falls below specified range ' num2str(theta_bnds(i,1)) ' at time t=' num2str(t) ' ==> corrected']);
         u(i) = theta_bnds(i, 1) + eps;
         is_x_error = 1;
      end
      if (u(i) > theta_bnds(i, 2))
       %  disp(['Output -' num2str(i) '- with value rho =' num2str(u(i)) ' exceeds specified range ' num2str(theta_bnds(i,2)) ' at time t=' num2str(t) ' ==> corrected']);
         u(i) = theta_bnds(i, 2) - eps;
         is_x_error = 1;
      end
   end

%% CHECK HERE!   
%    for i = 1:size(theta_bnds, 1)
%       eval(['x' num2str(i) '= u( ' num2str(i) ' );'])
%    end
%    for i = 1:size(theta_bnds, 1)
%       eval(['rho' num2str(i) '= u( ' num2str(i) ' );'])
%    end

   % Evaluate scheduling signals theta by current values of rho
   for i = 1:size(theta_bnds, 1)
%      x(i)  =  u(i);
     theta(i) =  u(i);
   end
   
   % Check whether prespecified box bounds on the scheduling signals theta 
   % are violated.
   if strcmp(parameterVectorType, 'box')

       for i = 1:size(theta, 1)
          if (theta(i) < 1.1*parameterVector(i, 2))
             disp(['Parameter -' num2str(i) '- with value p=' num2str(theta(i)) ' falls below specified range ' num2str(parameterVector(i,2)) ' at time t=' num2str(t) ' ==> corrected']);
          end
          
          if (theta(i) < parameterVector(i, 2))
             theta(i) = parameterVector(i, 2) + eps;
             is_t_error = 1;
          end
          
          if (theta(i) > 1.1*parameterVector(i, 3))
             disp(['Parameter -' num2str(i) '- with value p=' num2str(theta(i)) ' exceeds specified range ' num2str(parameterVector(i,3)) ' at time t=' num2str(t) ' ==> corrected']);
          end
          
          if (theta(i) > parameterVector(i, 3));
             theta(i) = parameterVector(i, 3)-eps;
             is_t_error = 1;
          end
       end

   % Check whether prespecified polytopic bounds on the scheduling signals
   % theta are violated.       
   elseif strcmp(parameterVectorType, 'pol')

       delta = poly_A*theta-poly_b;
       outside_vec = (delta > norm(theta)*eps*10);
       
       if sum(outside_vec) == 1
           % correct if theta outside polytope
           % (implemented only for 1 violated inequality)
           % => projection on facet whose corresponding inequality is violated 
           A_viol = poly_A(outside_vec,:);                                                  % violated inequalities
           theta = theta + A_viol'*(-delta(outside_vec)*1./(A_viol*A_viol'));     % theta update
           disp(['Parameter vector outside polytope (delta = [',num2str(delta'),']) at time t=', num2str(t),' ==> corrected.']);
           delta = poly_A*theta-poly_b;
           outside_vec = (delta > norm(theta)*eps*10);
       end;
       if sum(outside_vec)~=0
           % warning if still not in polytope
           warning(['Parameter vector outside polytope (delta = [',num2str(delta'),']) at time t=', num2str(t),' ==> not corrected.']);
       end;
                  
   else
       error('Unknown type of parameter vector.');
   end;

   
    % Evaluate controller at current coordinate of convex polytope
    % -------------------------------------------------------------------------
    % Compute current polytopic coordinates alpha for given interior point
    % theta
          alpha = polydec2(parameterVector, theta);
          
          % Eliminate very small negative entries
          alpha = (alpha + abs(alpha))/2;
          
%     if (ispsys(K))
        % Compute SYSTEM matrix object for current controller snapshot
        [A_K, B_K, C_K, D_K, E_K] = ltiss(psinfo(K, 'eval', alpha));
%     elseif 
%         error('Controller must be of type PSYS.');    
%     end

end


% S-Function Flag Switch/Case
% -------------------------------------------------------------------------
switch flag,

% Initialization
% -------------------------------------------------------------------------
   case 0,
      [sys, x0, str, ts] = mdlInitializeSizes(t              , ...
                                              x              , ...
                                              u              , ...
                                              K              , ...
                                              x0             , ...
                                              parameterVector, ...
                                              theta_bnds     , ...
                                              Ts             );
 
% Derivatives
% -------------------------------------------------------------------------
% Continuous time case
   case 1,  
      if ((isempty(T_sample)) | (T_sample == 0))
         sys = mdlDerivatives(t, x, u, A_K, B_K);
      else
         sys = [];
      end

% Discrete time case
   case 2,
      if ~isempty(T_sample)
         sys = mdlDerivatives(t, x, u, A_K, B_K);
      else
         sys = [];
      end

% Outputs
% -------------------------------------------------------------------------
   case 3,
      sys = mdlOutputs(t, x, u, C_K, D_K);

% Unhandled Flags
% -------------------------------------------------------------------------
   case { 2, 4, 9 },
      sys = [];

% Unexpected Flags
% -------------------------------------------------------------------------
   otherwise
      error(['Unhandled flag = ',num2str(flag)]);

end
% end csfunc


%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys, x0, str, ts] = mdlInitializeSizes(t              , ...
                                                 x              , ...
                                                 u              , ...
                                                 K              , ...
                                                 x0             , ...
                                                 parameterVector, ...
                                                 theta_bnds       , ...
                                                 Ts             );


% Obtain LPV controller info
   [controllerType              , ...
    num_ControllerSystemMatrices, ...
    num_ControllerStates        , ...
    num_ControllerInputs        , ...
    num_ControllerOutputs             ] = psinfo(K);
% 
% if controllerType ~= 'pol';
%    error('input srhotem must be polytopic')
% end

sizes = simsizes;

if Ts == -1
   sizes.NumContStates  = num_ControllerStates;
   sizes.NumDiscStates  = 0;
else
   sizes.NumContStates  = 0;
   sizes.NumDiscStates  = num_ControllerStates;
end

sizes.NumOutputs     = num_ControllerOutputs;
sizes.NumInputs      = num_ControllerInputs + size(theta_bnds, 1);
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;

sys = simsizes(sizes);

x0   = x0;
str  = [];
ts   = [Ts 0];


% end mdlInitializeSizes
%
%=============================================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%=============================================================================
%
function sys = mdlDerivatives(t, x, u, A_K, B_K);
states = A_K*x + B_K*u((end-size(B_K, 2)+1):end);
   sys = states;


%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================
%
function sys = mdlOutputs(t, x, u, C_K, D_K);
output = C_K*x + D_K*u((end-size(D_K, 2)+1):end);
   sys = output;


