function [K_d] = discretizeController(K, Ts, method)


[type, num_Vertices, num_States, num_Inputs, num_Outputs] = psinfo(K);

Sk = cell(1, num_Vertices);

for i = 1:num_Vertices
    
    [Aki, Bki, Cki, Dki] = ltiss(psinfo(K, 'sys', i));
    
    Ki   =  ss(Aki, Bki, Cki, Dki);
    Ki_d = c2d(Ki, Ts, method);
    
    Sk{i} = ltisys(Ki_d.A, Ki_d.B, Ki_d.C, Ki_d.D);
end

K_d = psys(cell2mat(Sk));