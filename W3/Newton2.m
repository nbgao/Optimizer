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
end
x = x0;
y = feval(fun, x0);
end

