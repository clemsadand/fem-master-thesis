%Affiche les solutions numérique et exacte
%
function ufem2(N)
	%Nn = [2 4 8 16 32 64];
	%Discrétisation du temps
	Nt = 10;
	t = linspace(0,1,Nt+1);
	tau = t(2:end)-t(1:end-1);
	%
	%errL2 = zeros(6,Nt+1);
	%errH10 = zeros(6,Nt+1);
	
	%for n = 1:4
		Nx = N;
		Ny = N;
		%
		[coord, connect_geo, connect_forme, connect_f_bord] = maillage(Nx, Ny);
		[Aretes] = aretes(Nx, Ny, connect_geo, connect_forme);
		[poids, pointsg] = quadrature(Nx,Ny);
		%
		uef = assemblage(N,N);
		%Ngeo = (Nx+1)*(Ny+1);
		Na = connect_forme(2,end);
		Nma = size(connect_geo,2);
		%
		x = zeros(Na,1);
		y = zeros(Na,1);
		z = zeros(Na,1);

	
		for p = Nt+1
			%Coordonnées de la solution éléments finis
			uc = uef(:,p);
			%Boucle sur les triangles
			for k = 1:Nma
				nodes = coord(connect_geo(:,k),:);
				[a b c] = hatFunctions(nodes);
				for ni = 1:3
					i = connect_forme(ni,k);
					%Gradient de uph
					duph_dx = uef(i,p)*[b(ni);c(ni)];
					%arete i
					arete = Aretes(i,:);
					%coordonnées du milieu de l'arête i
					milieu = (coord(arete(1),:)+coord(arete(2),:))/2;
					x(i) = milieu(1);
					y(i) = milieu(2);
					z(i) = uc(i);
					[zu(i) grad1, grad2] = u(milieu(1),milieu(2), t(p));
					%du_dx = [grad1 ;grad2];
					%errL2(n,p) += (z(i)-zu(i))^2;
					%errH10(n,p) += sum((du_dx-duph_dx).^2);
				end
			end
		end
	%end
	%errL2 = sqrt(errL2)
	%save errL2.txt errL2 -ascii;
	%errH10 = sqrt(errH10);
	%save errH10.txt errH10 -ascii;
	%err = max(max(abs(zu-z)))
	%err = errH10(:,Nt+1);
	%dof = 3*Nn.^2+2*Nn;
	%loglog(dof(1:4), err(1:4), 'r-*','linewidth',2);

	clf;close;
	figure(1);
	trisurf(connect_forme',x,y,z);
	title("Solution élément fini");
	print -dpng figureuef.png;
	figure(2);
	trisurf(connect_forme',x,y,zu);
	title("Solution exacte");
	print -dpng figureexa.png;
end
