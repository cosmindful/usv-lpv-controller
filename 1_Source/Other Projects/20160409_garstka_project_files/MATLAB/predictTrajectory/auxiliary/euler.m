function [ z_out,n_f ] = euler(f,z_0,t_0,h,b)
    % anonymuous dgl function
    % y(x_0) = y_0 initial value
    % h: step size
    % b: intervall endpoint
    % n_f: number of function calls
    z_out = z_0;
    z = z_0;
    n_f = 0;
    k_end = abs(round((b-t_0)/h));

    for k = 0:k_end
        t = t_0 + k*h;
        z_next = z + h*f(t,z);
        z_out = [z_out,z_next];
        z = z_next;
        n_f = n_f + 1;
        if z_next(1) < 0
            break;
        end
    end  
end

