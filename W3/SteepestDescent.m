function [x, y, k] = SteepestDescent(fun, gfun, x0)
% min f(x)
% x0: Init point
% fun: Object function
% gfun: gradient
% x: Optim point
% y: Optim value
% k: Iterator

max_k = 5000;
rho = 0.5;
sigma = 0.4;
epsilon = 1d-5;
k = 0;
while(k<max_k)
    gk = feval(gfun, x0);
    dk = -gk;
    if(norm(dk)<epsilon)
        break;
    end
    m = 0;
    mk = 0;
    while(m<20)
        if(feval(fun,x0+rho^m*dk) < feval(fun,x0)+sigma*rho^m*gk'*dk)
            mk = m;
            break;
        end
        m = m+1;
    end
    x0 = x0+rho^mk*dk;
    k = k+1;
end
x = x0;
y = feval(fun, x0);
end

