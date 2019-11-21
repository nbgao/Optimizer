x0 = [-1.2 1]';
[x, y, k] = SteepestDescent('fun1', 'gfun1', x0) 

% 曲面图
[x1, x2] = meshgrid(-2:0.02:2, 0:0.02:2);
z = 3*x1.^2+2*x2.^2-4*x1-6*x2;
surf(x1, x2, z);
shading interp;

function f = fun1(x)
f = 3*x(1)^2+2*x(2)^2-4*x(1)-6*x(2);
end

function g = gfun1(x)
g = [6*x(1)-4, 4*x(2)-6]';
end

function f = fun3(x)
f = 100*(x(1)^2-x(2))^2+(x(1)-1)^2;
end

function g = gfun3(x)
g = [400*x(1)*(x(1)^2-x(2))+2*(x(1)-1), -200*(x(1)^2-x(2))]';
end

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
    
    % 绘制搜索点
    z = feval(fun, x0);
    plot3(x0(1), x0(2), z, 'r.', 'MarkerSize', 10+k); hold on;    
end
x = x0;
y = feval(fun, x0);
end


