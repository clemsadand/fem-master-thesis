function uph = assemblage(Nx,Ny)
	[coord, connect_geo, connect_forme, connect_f_bord] = maillage(Nx, Ny);
	[Aretes] = aretes(Nx, Ny, connect_geo, connect_forme);
	[poids, pointsg] = quadrature(Nx,Ny);
	%Nombre d'arête
	Na = connect_forme(2,end);
	%Nombre d'arêtes au bord
	Nbo = size(connect_f_bord,2);
	%Nombre de mailles
	Nma = size(connect_geo,2);
	%Nombre de points de gauss
	L = size(pointsg,1);
	%Numéro temps final
	N = 10;
	%Discrétisation du temps
	t = linspace(0,1,N+1);
	%Pas de discrétisation
	tau = t(2:end)-t(1:end-1);
	%
	uph = zeros(Na,N+1);
	%Condition initale
	%Approximation u0h de la condition initiale u0 dans X0ph
	for k = 1:Nma
		nodes = coord(connect_geo(:,k),:);
		milieu(1,:) = (nodes(1,:)+nodes(2,:))/2;
		milieu(2,:) = (nodes(1,:)+nodes(3,:))/2;
		milieu(3,:) = (nodes(2,:)+nodes(3,:))/2;
		%for ni = 1:3
			i = connect_forme(1:3,k);
			uph(i,1) = u(milieu(:,1),milieu(:,2),0);
		%end
	end
	%
	for p = 2:N+1
		A = zeros(Na,Na);
		F = zeros(Na,1);
		mass = zeros(Na,Na);
		stiffness = zeros(Na,Na);
		for k = 1:Nma
			nodes = coord(connect_geo(:,k),:);
			%Fonctions de forme
			[a b c] = hatFunctions(nodes);
			%Points de gauss
			xi = (nodes'*pointsg')';
			Xi = [ones(7,1) xi];%taille 3*L
			%f(xi,t(p))
			f1 = f(xi(:,1),xi(:,2),t(p))';
			for ni = 1:3
				i = connect_forme(ni,k);
				theta_ni = [a(ni) b(ni) c(ni)]*Xi';%taille 1*L
				dtheta_dx_ni = [b(ni);c(ni)]*ones(1,L);%taille 2*L
				%uph(xi,p-1)
				u0 = uph(i,p-1)*theta_ni;%taille 1*L
				for nj = 1:3
					j = connect_forme(nj,k);
					theta_nj = [a(nj) b(nj) c(nj)]*Xi';%taille 1*L
					dtheta_dx_nj = [b(nj);c(nj)]*ones(1,L);%taille 2*L
					mass(i,j) += (theta_ni.*theta_nj)*poids;
					temp = dtheta_dx_ni.*dtheta_dx_nj;
					stiffness(i,j) += sum(temp)*poids;
				end
				%
				F(i) += ((u0+tau(p-1)*f1).*theta_ni)*poids;
			end
			
		end
		A = mass+tau(p-1)*stiffness;
		%Condition au bord
		F(connect_f_bord) = zeros(Nbo,1);
		for i = 1:Nbo
			bi = connect_f_bord(i);
			A(bi,:) = zeros(1,Na);
			A(bi,bi) = 1;
		end
		%A
		uph(:,p) = A\F;
	end
end
