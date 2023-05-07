% Quadrature
function [poids, pointsg] = quadrature(Nx,Ny)
	Nma = 2*Nx*Ny;
	hx = 1/Nx;
	hy = 1/Ny;
	%Points de GAuss de l'élément de référence
	L = 7;%Nombre de points de Gauss
	pointsg = zeros(L,3);
	S = hx*hy/2;%aire de l'élément de référence
	a1 = (6-sqrt(15))/21;
	a2 = (6+sqrt(15))/21;
	%Coordonnées barycentriques des points de gauss
	pointsg = [1/3 1/3 1/3; a1 a1 (1-2*a1); a1 (1-2*a1) a1;%
	 (1-2*a1) a1 a1; a2 a2 (1-2*a2); a2 (1-2*a2) a2;%
	 (1-2*a2) a2 a2];
	%Poids de la quadrature
	omega1 = S*(155-sqrt(15))/1200;
	omega2 = S*(155+sqrt(15))/1200;
	poids = [9*S/40; omega1; omega1; omega1; omega2; omega2; omega2];
end
