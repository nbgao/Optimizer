x0 = [-1, 2.1]';
[x, y, k] = Newton1('Rosenbrock', 'gRosenbrock', 'HessRosenbrock', x0)

% 曲面图
[x1, x2] = meshgrid(-2:0.02:2, -3:0.02:2);
z = 100*(x2-x1.^2).^2+(x1-1).^2;
surf(x1, x2, z);
shading interp;

function f = Rosenbrock(x)
f = 100*(x(2)-x(1)^2)^2+(x(1)-1)^2;
end

function g = gRosenbrock(x)
g = [-400*x(1)*(x(2)-x(1)^2)+2*(x(1)-1), 200*(x(2)-x(1)^2)]';
end

function H = HessRosenbrock(x)
H = [1200*x(1)^2-400*x(2)+2, -400*x(1);
    -400*x(1), 200];
end

function [x, y, k] = Newton1(fun, gfun, Hess, x0)
% fun: Object function
% gfun: Gradient function
% Hess: Hess matrix function
% x: Optim point
% y: Optim value
% k: iterate num
max_k = 100;
epsilon = 1e-5;
k = 0;
while(k<max_k)
    gk = feval(gfun, x0);
    Gk = feval(Hess, x0);
    dk = -Gk\gk;
    if(norm(gk)<epsilon)
        break;
    end
    x0 = x0+dk;
    k = k+1;
   
    % 绘制搜索点
    z = feval(fun, x0);
    plot3(x0(1), x0(2), z, 'r.', 'MarkerSize', 10+k); hold on;
end
x = x0;
y = feval(fun, x0);
end

function [x, y, k] = Newton2(fun, gfun, Hess, x0)
% fun: Object function
% gfun: Gradient function
% Hess: Hess matrix function
% x: Optim point
% y: Optim value
% k: iterate num
max_k = 100;
rho = 0.55;
sigma = 0.4;
epsilon = 1e-5;
k = 0;
while(k<max_k)
    gk = feval(gfun, x0);
    Gk = feval(Hess, x0);
    dk = -Gk\gk;
    if(norm(gk)<epsilon)
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
    x0 = x0+rho^m*dk;
    k = k+1;
   
    % 绘制搜索点
    z = feval(fun, x0);
    plot3(x0(1), x0(2), z, 'r.', 'MarkerSize', 10+k); hold on;
end
x = x0;
y = feval(fun, x0);
end

