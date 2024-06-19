%terme source
function z = f(x,y,t)
	z = -exp(-t)*(x.*y.*(x-1).*(y-1) + 2.*x.*(x-1) + 2.*y.*(y-1));
	%z = -2*pi^2*exp(-4*pi^2*t)*sin(pi*x).*sin(pi*y);
end
