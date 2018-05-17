:- module(proylcc, 
	[  
		grid/2,
		flick/3
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
	getColorEnPos(Grid,X,Y,PosCol),
	Ant\=PosCol.
pintar(_,_,[G|Grid],X,Y,[G|Grid],0):-
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

%metodo para calcular las dimenciones de la grilla
dimensiones([G|Grid],Ancho,Alto):-
	largo([G|Grid],Ancho),
	largo(G, Alto).

colores([g,v,b,r,y,p]).

listaDeJugadas(Grid,Rta):-
	colores(Colores),
	listaDeJugadasCascara(Colores,Grid,Rta).
listaDeJugadasCascara([],_,[]).
listaDeJugadasCascara([Color|Ls],Grid,[[Color,CantIncor]|Sig]):-
	cantIncorpora(Grid,Color,CantIncor),
	listaDeJugadasCascara(Ls,Grid,Sig).

%metodo para calcular cuantas celdas se incorporan añ cambiar a un cierto color
cantIncorpora(Grid,Color,Rta):-
	Grid = [F|_],
	F = [X|_],
	pintar(X,Color,Grid,0,0,FGrid,RtaA),
	pintar(Color,X,FGrid,0,0,_,RtaB),
	Rta is (RtaB-RtaA).

mejorDosJugas(Grid,Rta):-
	colores(Colores),
	mejorDosJugasCascara(Colores,Grid,RtaA)
	mejorPar(RtaA,Rta).

mejorDosJugasCascara([],_,[]).
mejorDosJugasCascara([Color|Ls],Grid,[[(Color,Col),CantTotal]|Rta])
	Grid = [F|_],
	F = [X|_],
	pintar(X,Color,Grid,0,0,FGrid,CantPintado),
	listaDeJugadas(Grid,LDJ),
	mejorPar(LFJ,[Col,Cant]),
	CantTotal is CantPintado+Cant,
	mejorDosJugasCascara(Ls,Grid,Rta).

mejorPar([],[a,0]).
mejorPar([[Color,Cantidad]|Ls],Rta):-
	mejorPar(Ls,[Col,Cant]),
	Cant>Cantidad,
	Rta = [Col,Cant];
	Rta = [Color,Cantidad].

