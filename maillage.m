% Maillage du carré (0,1)^2
% Nx nombre de subdivisions de l'axe des abscisses
% Ny nombre de subdivisions de l'axe des ordonnées
function [coord, connect_geo, connect_forme, connect_f_bord] = maillage(Nx, Ny)
	Nr = Nx*Ny;%nombre de rectangle
	Nma = 2*Nr;%nombre de triangles
	Na = 3*Nx*Ny+Nx+Ny;%nombre d'arêtes
	Ngeo = (Nx+1)*(Ny+1);%nombre de nœuds géométriques
	%
	%Coordonnées des noeuds géométriques
	x = linspace(0,1, Nx+1);
	y = linspace(0,1, Ny+1);
	[Y X] = meshgrid(y, x);
	coord = [X(:) Y(:)];
	%Numérotation des noeuds
	numg = reshape(1:Ngeo,Nx+1,Ny+1)';
	%tableau de connectivité géométriques
	connect_geo = zeros(3,Nma);
	%tableau de connectivité des formes
	connect_forme = zeros(3,Nma);
	%fonction calcul le numéro global des arêtes
	ng = @(x) (3-3*Nx)*x.^2 .+(12*Nx-13)*x .+15-9*Nx;
	%
	%
	%
	%Remplissage des tableaux
	for k = 1:Nr
		q = floor((k-1)/Nx)+1;%Numéro de ligne
		r = mod((k-1),Nx)+1;%Numéro de la colonne
		%Numéro global de chaque noeud du triangle k
		connect_geo(:,k) = [numg(q,r) numg(q,r+1) numg(q+1,r)];
		%Numéro global de chaque nœud du triangle k+Nr
		connect_geo(:,k+Nr) = [numg(q+1,r+1) numg(q,r+1) numg(q+1,r)];
		%******************************************
		connect_forme(:,k) = (1:3) + 3*(k-1);
		connect_forme(:,k+Nr) = ng(1:3) + 3*(k-1);
		%******************************************
	end
	connect_forme(1, Nr + Nx*(1:Ny-1)) = 3*Nma/2+(1:Ny-1);
	connect_forme(2, Nr+Nx*(Ny-1)+(1:Nx-1)) = 3*Nma/2+Ny-1+(1:Nx-1);
	connect_forme(1, Nma) = Na-1;
	connect_forme(2, Nma) = Na;
	%connect_forme
	%
	%
	%Numéros globaux des arêtes de bord
	%Tableau de connectivités des fonctions de forme au bord
	Nbor = 2*Nx+2*Ny;
	connect_f_bord = zeros(1,Nbor);
	num_ar = 3*Nma/2;
	connect_f_bord(1:Nx) = 1+3*(0:Nx-1);
	connect_f_bord(Nx+1:2*Ny-1) = num_ar+(1:Ny-1);
	connect_f_bord(2*Ny) = Na-1;
	connect_f_bord(2*Ny+1) = Na;
	connect_f_bord(2*Ny+2:3*Nx) = num_ar+Nx-1+(Nx-1:-1:1);
	connect_f_bord(3*Nx+1:4*Ny-1) = 2+3*Ny*(Ny-1:-1:1);
	connect_f_bord(4*Ny) = 2;
	%connect_f_bord
	%
	%Numéros globaux des nœuds de bord
	%connect_g_bord = zeros(1,2*(Nx+1)+2*(Ny-1));
	%connect_g_bord(1:Nx+1) = 1:Nx+1;
	%connect_g_bord(Nx+2:Nx+Ny) = 1+(Nx+1)*(1:Ny-1);
	%connect_g_bord(Nx+Ny+1:Nx+2*Ny-1) = (Nx+1)*(2:Ny);
	%connect_g_bord(Nx+2*Ny:+2*Ny+2*Ny) = (Nx+1)*Ny+(1:(Nx+1));
	%connect_g_bord
	%
	%
	%Construction du maillage
	%h = 1/(M-1);
	clf;close;
	%Boucle sur les mailles
	for k = 1:Nma
		%Initialisation du triangle
		triangle = zeros(3,2);
		%Restitution des coordonnées des triangles
		for ni = 1:3	
			triangle(ni,:) = coord(connect_geo(ni,k),:);
		end
		%Ajout du premier point au triangle
		triangle = [triangle ;triangle(1,:)];
		axis([0 1 0 1])
		hold on;%pour tracer plusieurs courbes dans le même repère
		%Construction du triangle
		plot(triangle(:,1), triangle(:,2), 'b');
	%	%Numérotation du triangle
	%	point = [h/3 h/3];
	%	point = transAff(point, k,M);
	%	text(point(1), point(2), num2str(k,'%2.0f'));
	end
	%print -dpng maillage.png
end
