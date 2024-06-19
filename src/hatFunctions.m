% hatFunctions : Calcul les coefficients des fonctios de forme d'un triangle
% nodes : matrices des nœuds du triangle
% a : 1er coefficient
% b : 2ieme coefficient
% c : 3ieme cefficient
function [a b c] = hatFunctions(nodes)
	milieu = zeros(3,2);
	milieu(1,:) = (nodes(1,:)+nodes(2,:))/2;
	milieu(2,:) = (nodes(1,:)+nodes(3,:))/2;
	milieu(3,:) = (nodes(2,:)+nodes(3,:))/2;
	%
	A = [[1;1;1] milieu];
	I = eye(3,3);
	X = A\I;
	%
	a = X'(:,1);
	b = X'(:,2);
	c = X'(:,3);
	%[a b c] = X';
end

