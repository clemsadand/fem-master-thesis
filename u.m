%Solution exacte du problème
function [z, grad1, grad2] = u(x,y,t)
	z = exp(-t)*x.*y.*(x-1).*(y-1);
	grad1 = exp(-t)*y.*(2.*x-1).*(y-1);
	grad2 = exp(-t)*x.*(x-1).*(2.*y-1);
	%z = exp(-4*pi^2*t)*sin(pi*x).*sin(pi*y);
	%grad1 = pi*exp(-4*pi^2*t)*cos(pi*x).*sin(pi*y);
	%grad2 = pi*exp(-4*pi^2*t)*sin(pi*x).*cos(pi*y);
end
