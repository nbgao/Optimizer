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
end
x = x0;
y = feval(fun, x0);
end

