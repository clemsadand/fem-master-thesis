% Connectivité géométrique des arêtes
function [Aretes] = aretes(Nx, Ny, connect_geo, connect_forme)
	%
	Nma = 2*Nx*Ny;
	Na = 3*Nx*Ny+Nx+Ny;%nombre d'arêtes
	%Tableau de connectivité géométrique des arêtes 
	Aretes = zeros(Na, 2);
	%Numérotation local des arêtes dans le triangle de référence
	nloc_ar = [1 2; 1 3; 2 3];
	for k = 1:Nma/2
		for ni = 1:3
			i = connect_forme(ni,k);
			Aretes(i,:) = connect_geo(nloc_ar(ni,:),k);
		end
	end
	%Arêtes de bord vertical droit
	for k = Nx*Ny+Nx:Nx:Nma
		ni = 1;
		i = connect_forme(ni,k);
		Aretes(i,:) = connect_geo(nloc_ar(ni,:),k);
	end
	%Aretes de bord horizontal supérieur
	for k = Nma-Nx+1:Nma
		ni = 2;
		i = connect_forme(ni,k);
		Aretes(i,:) = connect_geo(nloc_ar(ni,:),k);
	end
	%
	%
	%Aretes
end
