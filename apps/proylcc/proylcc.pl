:- module(proylcc, 
	[  
		grid/2,
		flick/3,
		ayudaBasica/2,
		ayudaAdicional/2,
		verificarVictoria/2
	]).

grid(1, [
		 [y,g,b,g,v,y,p,v,b,p,v,p,v,r],
		 [r,r,p,p,g,v,v,r,r,b,g,v,p,r],
		 [b,v,g,y,b,g,r,g,p,g,p,r,y,y],
		 [r,p,y,y,y,p,y,g,r,g,y,v,y,p],
		 [y,p,y,v,y,g,g,v,r,b,v,y,r,g],
		 [r,b,v,g,b,r,y,p,b,p,y,r,y,y],
		 [p,g,v,y,y,r,b,r,v,r,v,y,p,y],
		 [b,y,v,g,r,v,r,g,b,y,b,y,p,g],
		 [r,b,b,v,g,v,p,y,r,v,r,y,p,g],
		 [v,b,g,v,v,r,g,y,b,b,b,b,r,y],
		 [v,v,b,r,p,b,g,g,p,p,b,y,v,p],
		 [r,p,g,y,v,y,r,b,v,r,b,y,r,v],
		 [r,b,b,v,p,y,p,r,b,g,p,y,b,r],
		 [v,g,p,b,v,v,g,g,g,b,v,g,g,g]
		]).

grid(2, [
		 [y,y,b,g,v,y,p,v,b,p,v,p,v,r],
		 [y,y,p,p,g,v,v,r,r,b,g,v,p,r],
		 [b,y,g,y,b,g,r,g,p,g,p,r,y,y],
		 [r,y,y,y,y,p,y,g,r,g,y,v,y,p],
		 [y,p,y,v,y,g,g,v,r,b,v,y,r,g],
		 [r,b,v,g,b,r,y,p,b,p,y,r,y,y],
		 [p,g,v,y,y,r,b,r,v,r,v,y,p,y],
		 [b,y,v,g,r,v,r,g,b,y,b,y,p,g],
		 [r,b,b,v,g,v,p,y,r,v,r,y,p,g],
		 [v,b,g,v,v,r,g,y,b,b,b,b,r,y],
		 [v,v,b,r,p,b,g,g,p,p,b,y,v,p],
		 [r,p,g,y,v,y,r,b,v,r,b,y,r,v],
		 [r,b,b,v,p,y,p,r,b,g,p,y,b,r],
		 [v,g,p,b,v,v,g,g,g,b,v,g,g,g]
		]).

grid(3, [
		 [y,y,b,g,v,y,p,v,b,p,v,p,v,r],
		 [y,y,p,p,g,v,v,r,r,b,g,v,p,r],
		 [p,g,v,y,y,r,b,r,v,r,v,y,p,y],
		 [b,y,v,g,r,v,r,g,b,y,b,y,p,g],
		 [b,y,g,y,b,g,r,g,p,g,p,r,y,y],
		 [r,b,b,v,g,v,p,y,r,v,r,y,p,g],
		 [r,p,g,y,v,y,r,b,v,r,b,y,r,v],
		 [r,b,b,v,p,y,p,r,b,g,p,y,b,r],
		 [r,y,y,y,y,p,y,g,r,g,y,v,y,p],
		 [y,p,y,v,y,g,g,v,r,b,v,y,r,g],
		 [r,b,v,g,b,r,y,p,b,p,y,r,y,y],
		 [v,b,g,v,v,r,g,y,b,b,b,b,r,y],
		 [v,v,b,r,p,b,g,g,p,p,b,y,v,p],
		 [v,g,p,b,v,v,g,g,g,b,v,g,g,g]
		]).

grid(4, [
		 [g,y,b,g,v,y,p,v,b,p,v,p,v,r],
		 [r,g,p,p,g,v,v,r,r,b,g,v,p,r],
		 [b,v,g,y,b,g,r,g,p,g,p,r,y,y],
		 [r,p,y,g,y,p,y,g,r,g,y,v,y,p],
		 [y,p,y,v,g,y,g,v,r,b,v,y,r,g],
		 [r,b,v,g,b,g,y,p,b,p,y,r,y,y],
		 [p,g,v,y,y,r,g,r,v,r,v,y,p,y],
		 [b,y,v,g,r,v,r,g,b,y,b,y,p,g],
		 [r,b,b,v,g,v,p,y,g,v,r,y,p,g],
		 [v,b,g,v,v,r,g,y,b,g,b,b,r,y],
		 [v,v,b,r,p,b,g,g,p,p,g,y,v,p],
		 [r,p,g,y,v,y,r,b,v,r,b,g,r,v],
		 [r,b,b,v,p,y,p,r,b,g,p,y,g,r],
		 [v,g,p,b,v,v,g,g,g,b,v,g,r,g]
		]).

grid(5, [
		 [y,y,y,y,y,y,y,y,y,y,y,y,y,y],
		 [y,y,y,y,y,y,y,y,y,y,y,y,y,y],
		 [y,y,y,y,y,y,y,y,y,y,y,y,y,y],
		 [y,y,y,y,y,y,y,y,y,y,y,y,y,y],
		 [y,y,y,y,y,y,y,y,y,y,y,y,y,y],
		 [y,y,y,y,y,y,y,y,y,y,y,y,y,y],
		 [y,y,y,y,y,y,y,y,y,y,y,y,y,y],
		 [y,y,y,y,y,y,y,y,y,y,y,y,y,y],
		 [y,y,y,y,y,y,y,y,y,y,y,y,y,y],
		 [y,y,y,y,y,y,y,y,y,y,y,y,y,y],
		 [y,y,y,y,y,y,y,y,y,y,y,y,y,y],
		 [y,y,y,y,y,y,y,y,y,y,y,y,y,y],
		 [y,y,y,y,y,y,y,y,y,y,y,y,y,y],
		 [y,y,y,y,y,y,y,y,y,y,y,y,y,y]
		]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% flick(+Grid, +Color, -FGrid)
%
% FGrid es el resultado de hacer 'flick' de la grilla Grid con el color Color. 
% En caso de que el color sea igual al color adyacente actual, se retorna la misma grilla.
flick(Grid,Color,Grid):-
	%este es una suerte de "caso base" para cuando ingresa el mismo color que la esquina sup izq
	Grid = [F|_],
	F = [Color|_].
flick(Grid,Color,FGrid):-
	Grid = [F|_],
	F = [X|_],
	pintar(X,Color,Grid,0,0,FGrid,_).
	%FGrid = [[Color|Xs]|Fs].

%metodo para pintar en un matriz de color "Color" las celda ingresada 
%y sus adyacentes si estas eran el color "Ant"
pintar(Ant,Color,Grid,X,Y,Rta,CantPintado):-
	getColorEnPos(Grid,X,Y,PosCol),
	Ant=PosCol,
	cambiarColorEnPosicion(Color,Grid,X,Y,RtaA),
	pintarContorno(Ant,Color,RtaA,X,Y,Rta,CPTotal),
	%agrego este contador para la ayuda
	CantPintado is CPTotal+1.
pintar(Ant,_,Grid,X,Y,Grid,0):-
	%aca controlo que no sea "adyacenteC*", es decir, no es del mismo color
	getColorEnPos(Grid,X,Y,PosCol),
	Ant\=PosCol.
pintar(_,_,[G|Grid],X,Y,[G|Grid],0):-
	%aca controlo que no se me caiga de la grilla
	X<0;
	Y<0;
	largo([G|Grid],LF),	X>=LF;
	largo(G,LC),	Y>=LC.

%metodo para pintar las celdas directamente adyacente a un celdas
%arriba, abajo, izquierda y derecha
pintarContorno(Ant,Color,Grid,X,Y,Rta,CantPintado):-
	Xmen is X-1,Ymen is Y-1,
	Xmas is X+1,Ymas is Y+1,
	pintar(Ant,Color,Grid,Xmen,Y,RtaA,CPA),
	pintar(Ant,Color,RtaA,Xmas,Y,RtaB,CPB),
	pintar(Ant,Color,RtaB,X,Ymas,RtaC,CPC),
	pintar(Ant,Color,RtaC,X,Ymen,Rta,CPD),
	%agrego este contador para la ayuda
	CantPintado is CPA+CPB+CPC+CPD.

%metodo recursivo para obtener el elemento en una posicion de la matriz
getColorEnPos([G|_],X,0,Rta):-
	getColorEnLista(G,X,Rta).
getColorEnPos([_|Grid],X,Y,Rta):-
	YY is Y-1,
	getColorEnPos(Grid,X,YY,Rta).

%metodo recursivo para obtener el elemento en una posicion de la lista
getColorEnLista([L|_],0,L).
getColorEnLista([_|Ls],X,Rta):-
	XX is X-1,
	getColorEnLista(Ls,XX,Rta).

%metodo recursivo para cambiar un elemento en un lista
%segun la posicion ingresada
reemplazarEnLista(Color,[_|Ls],0,[Color|Ls]).
reemplazarEnLista(Color,[L|Ls],X,[L|Rta]):-
	XX is X-1,
	reemplazarEnLista(Color,Ls,XX,Rta).

%metodo recursivo para cambiar un elemento en un matriz
%segun la coordenada ingresada
cambiarColorEnPosicion(Color,[G|Grid],X,0,[Rta|Grid]):-
	reemplazarEnLista(Color,G,X,Rta).
cambiarColorEnPosicion(Color,[G|Grid],X,Y,[G|Rta]):-
	YY is Y-1,
	cambiarColorEnPosicion(Color,Grid,X,YY,Rta).

%metodo para calcular el largo de una lista
largo([],0).
largo([_|Xs],Rta):- largo(Xs,Rtaa),
	Rta is Rtaa+1.

%hecho para retorna una lista de los colores posibles, sino los tengo que escribir
%a cada rato
colores(["r","v","p","g","b","y"]).

%metodo para calcular cuantas celdas se incorporan al cambiar a un cierto color
cantIncorpora(Grid,Color,0):-
	getColorEnPos(Grid,0,0,Color).
cantIncorpora(Grid,Color,Rta):-
	Grid = [F|_],
	F = [X|_],
	pintar(X,Color,Grid,0,0,FGrid,RtaA),
	pintar(Color,X,FGrid,0,0,_,RtaB),
	Rta is (RtaB-RtaA).

/*
Un metodo cascara que retorna una lista con cada uno de los adyacentes que se agregan a la
lista, haciendo uso del metodo cantIncorpora. 
*/
ayudaBasica(Grid,Rta):-
	colores(Colores),
	ayudaBasica2(Grid,Colores,Rta).

ayudaBasica2(_,[],[]).
ayudaBasica2(Grid,[Color|Ls],[R|Rta]):-
	cantIncorpora(Grid,Color,R),
	ayudaBasica2(Grid,Ls,Rta).
/*
Este metodo retorna una ayuda aun mayor que la básica. Mediante un primer color, se averigua
cuantas celdas adyacentes nuevas pueden obtenerse en caso de apretar dicho primer boton y luego
cualquiera de los otros seis. 
*/
ayudaAdicional(Grid,Rta):-
	colores(Colores),
	ayudaBasica(Grid,L),
	ayudaAdicional2(Grid,L,Colores,Rta).

ayudaAdicional2(_,[],[],[]).
ayudaAdicional2(Grid,[Cant | Rs],[Color|Ls],[R|Rta]):-
	flick(Grid,Color,FGrid),
	ayudaBasica(FGrid,L),
	max_member(CantSegunda,L),
	R is Cant + CantSegunda,
	ayudaAdicional2(Grid,Rs,Ls,Rta).

%Verifica si se dio una victoria mediante la grid que recibe.
%Retorna 1 en caso de victoria, 0 en caso contrario. 
verificarVictoria(Grid,1):-
	flick(Grid,y,GridN),
	grid(3,GridN).
verificarVictoria(_,0).
