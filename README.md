# fem-master-thesis

# Implémentation d'une méthode d'éléments finis non conformes de
Crouzeix-Raviart pour résoudre le problème de la chaleur

Ce code a été réalisé dans le cadre de mon mémoire de master
en Analyse numérique des EDP.

Les scripts principales de ce code sont : maillage.m, mfrontiere.m,
aretes.m, quadrature, hatFuntions.m, assemblage.m, f.m, u.m, ufem2.m

Script 1 : maillage.m 
Ce script genère un maillage conforme du carré (0,1)^2

Script 2: mfrontiere.m 
Ce script génère le tableau des arêtes de bords et le tableau des voisins de bords.

Script 3: aretes.m
Ce script génère le tableau de connectivité des arêtes.

Script 4: quadrature.m
Ce script genère les poids et les points de Gauss de la formule de 
quadrature utilisée pour les calculs d'intégrales.

Script 5: hatFunctions.m
Ce script génère la fonction forme associée au triangle de référence

Script 6: assemblable.m
Ce script génère la solution du problème. 

Script 7: f.m
Ce script implémente la fonction f

Scritp 8: u.m
ce script implémente la solution exacte du problème

Scrit 9: ufem2.m
Ce script affiche la solution obtenue par éléments finis et la solution exacte.
