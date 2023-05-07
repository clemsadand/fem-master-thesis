% Maillage de bord du carré (0,1)^2
% Nx nombre de subdivisions de l'axe des abscisses
% Ny nombre de subdivisions de l'axe des ordonnées
function [connect_f_front, vois] = mfrontiere(Nx, Ny)
	Nmab = 2*Nx+2*(Ny-1);
	Nma = 2*Nx*Ny;
	%Numérotation des noeuds de bord
	num_front = [1:Nx, (1:Ny-1)*Nx+1, (1:Ny-1)*Nx+Nx*Ny, (Nma-Nx+1):Nma];
	%tableau de connectivité géométriques
	connect_f_front = zeros(2,Nmab);
	connect_f_front(1,1:Nx) = 1;
	connect_f_front(1,Nx+(1:Ny-1)) = 2;
	connect_f_front(1,Nx+Ny-1+(1:Ny-1)) = 1;
	connect_f_front(1,(Nx+Ny+Ny-2+1):Nmab) = 2;
	connect_f_front(2,1) = 2;
	connect_f_front(2,Nmab) = 1;
	%Tableau des voisinages
	%vois : 3*Nma
	%vois(ni,k) numéro du triangle partageant la face ni en du triangle k
	%vois(ni,k) = 0 signifie que la face numéro ni est au bord
	vois = zeros(3,Nma);
	Nr = Nma/2;
	vois(3,1:Nr) = Nr+(1:Nr);
	vois(1,Nx+1:Nr) = Nr+ (1:Nr-Nx);
	vois(2,2:Nr) = Nr + (1:(Nr-1));
	vois(2,Nx+1:Nx:Nr) = 0;
	%*******************
	vois(3,Nr+(1:Nr)) = 1:Nr;
	vois(2,Nr+(1:Nr-Nx)) = (Nx+1):Nr;
	vois(1,Nr+(1:Nr-1)) = 2:Nr;
	vois(1,(Nr+Nx):Nx:Nma) = 0;
	%vois'
end
