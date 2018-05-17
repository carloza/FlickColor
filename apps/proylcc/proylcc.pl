:- module(proylcc, 
	[  
		grid/2,
		flick/3,
		ayudaBasica/2,
		ayudaAdicional/3,
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

flick(Grid,Color,Grid):-
	Grid = [F|_],
	F = [X|_],
	X == Color.
	
flick(Grid,Color,FGrid):-
	Grid = [F|_],
	F = [X|_],
	pintar(X,Color,Grid,0,0,FGrid).
	%FGrid = [[Color|Xs]|Fs].


pintar(Ant,Color,Grid,X,Y,Rta):-
	getColorEnPos(Grid,X,Y,PosCol),
	Ant=PosCol,
	cambiarColorEnPosicion(Color,Grid,X,Y,RtaA),
	pintarContorno(Ant,Color,RtaA,X,Y,Rta).

pintar(Ant,_,Grid,X,Y,Rta):-
	getColorEnPos(Grid,X,Y,PosCol),
	Ant\=PosCol,
	Rta=Grid.

pintar(_,_,[G|Grid],X,Y,[G|Grid]):-
	X<0;
	Y<0;
	(largo([G|Grid],LF),	X>=LF);
	(largo(G,LC),	Y>=LC).

pintarContorno(Ant,Color,RtaA,X,Y,Rta):-
	Xmen is X-1,Ymen is Y-1,
	Xmas is X+1,Ymas is Y+1,
	pintar(Ant,Color,RtaA,Xmen,Y,RtaB),
	pintar(Ant,Color,RtaB,Xmas,Y,RtaC),
	pintar(Ant,Color,RtaC,X,Ymas,RtaD),
	pintar(Ant,Color,RtaD,X,Ymen,Rta).

getColorEnPos([G|_],X,0,Rta):-
	getColorEnLista(G,X,Rta).

getColorEnPos([_|Grid],X,Y,Rta):-
	YY is Y-1,
	getColorEnPos(Grid,X,YY,Rta).

getColorEnLista([L|_],0,L).
getColorEnLista([_|Ls],X,Rta):-
	XX is X-1,
	getColorEnLista(Ls,XX,Rta).

reemplazarEnLista(Color,[_|Ls],0,[Color|Ls]).
reemplazarEnLista(Color,[L|Ls],X,[L|Rta]):-
	XX is X-1,
	reemplazarEnLista(Color,Ls,XX,Rta).

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
dimenciones([G|Grid],Ancho,Alto):-
	largo([G|Grid],Ancho),
	largo(G, Alto).
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% contarCantColor(C,Grid,Res)
%
% Cuenta la cantidad de colores igual a c que hay en Grid y lo retorna en Res.

contarCantColor(C,[G|Grid],Res):- 
	recorrerLista(C,G,ResA), 
	contarCantColor(C,Grid,ResB), 
	Res is ResA + ResB.

contarCantColor(C,[],0). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% recorrerLista(C,Lista,Res)
% 
% Metodo auxiliar que recorre Lista contando la cantidad de apariciones de C que sera retornada en Res.

recorrerLista(C,[C | Cs],Res):- 
	recorrerLista(C,Cs,ResA), 
	Res is ResA + 1. 
	
recorrerLista(C,[Cn | Cs],Res):- 
	C \= Cn,
	recorrerLista(C,Cs,Res).

recorrerLista(C,[],0). 

/*
adyanceteC/4
*/

adyacenteC(Grid,(X,Y),Color,Rta):-
	adyacenteCAux(Grid,(X,Y),Color,[],RtaTemp),
	lsr_longitud(RtaTemp,Rta). 

adyacenteCAux(Grid,(X,Y),Color,LC,LC):- 
	getColorEnPos(Grid,X,Y,ColorRta), 
	ColorRta \= Color. 
	
adyacenteCAux(Grid,(X,Y),Color,LC,Rta):- 
	getColorEnPos(Grid,X,Y,ColorRta), 
	
	ColorRta == Color, 
	lsr_agregarElem(LC,(X,Y),LCAux),
	(derecha((X,Y),(Xd,Yd)), adyacenteCAux(Grid,(Xd,Yd),Color,LCAux,RtaAux)),
	(abajo((X,Y),(Xa,Ya)), adyacenteCAux(Grid,(Xa,Ya),Color,RtaAux,Rta)).

	
/*Obtener nuevos pares segun direccion*/	
derecha((X,Y),(Xn,Y)):- Xn is X + 1.
abajo((X,Y),(X,Yn)):- Yn is Y + 1.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% ayudaBasica/2
% 
% Retorna un arreglo indicando la cantidad de celdas que cambian en caso de 
% seleccionar dicho color para la proxima jugada. 
% Grid: grilla a ser analizada.
% [red, violet, pink, green, blue, yellow]

ayudaBasica(Grid,[Red,Violet,Pink,Green,Blue,Yellow]):-
	(getColorEnPos(Grid,0,0,ColorRta),adyacenteC(Grid,(0,0),ColorRta,ConjuntoC)),
	(flick(Grid,"r",GridR), adyacenteC(GridR,(0,0),"r",ConjuntoCR), Red is ConjuntoCR - ConjuntoC),
	(flick(Grid,"v",GridV), adyacenteC(GridV,(0,0),"v",ConjuntoCV), Violet is ConjuntoCV - ConjuntoC),
	(flick(Grid,"p",GridP), adyacenteC(GridP,(0,0),"p",ConjuntoCP), Pink is ConjuntoCP - ConjuntoC),
	(flick(Grid,"g",GridG), adyacenteC(GridG,(0,0),"g",ConjuntoCG), Green is ConjuntoCG - ConjuntoC),
	(flick(Grid,"b",GridB), adyacenteC(GridB,(0,0),"b",ConjuntoCB), Blue is ConjuntoCB - ConjuntoC),
	(flick(Grid,"y",GridY), adyacenteC(GridY,(0,0),"y",ConjuntoCY), Yellow is ConjuntoCY - ConjuntoC).
	
	
	
ayudaAdicional(Grid,PrimerColor,[Red,Violet,Pink,Green,Blue,Yellow]):-
	(getColorEnPos(Grid,0,0,ColorRta),adyacenteC(Grid,(0,0),ColorRta,ConjuntoC)),
	(flick(Grid,PrimerColor,GridN),adyacenteC(GridN,(0,0),PrimerColor,ConjuntoPC), PrimerColorBeneficio is ConjuntoPC - ConjuntoC),
	ayudaBasica(GridN,[Red1,Violet1,Pink1,Green1,Blue1,Yellow1]),
	Red is Red1 + PrimerColorBeneficio,
	Violet is Violet1 + PrimerColorBeneficio,
	Pink is Pink1 + PrimerColorBeneficio,
	Green is Green1 + PrimerColorBeneficio,
	Blue is Blue1 + PrimerColorBeneficio,
	Yellow is Yellow1 + PrimerColorBeneficio.
	
	
/* Lista sin repeticiones */
%lsr_agregarElem([],E,[E]).
lsr_agregarElem(L,E,[E | L]):- not(lsr_perteneceLista(L,E)).
lsr_agregarElem(L,E,L):- lsr_perteneceLista(L,E). 

lsr_perteneceLista([E | Es], E).
lsr_perteneceLista([El | Es], E):- 
	E \= El, 
	lsr_perteneceLista(Es,E).
	
lsr_longitud([],0).
lsr_longitud([E | Es],Rta):- 
	lsr_longitud(Es,Rta1), 
	Rta is Rta1 + 1.
	
lsr_concatenar(L,[],L).
lsr_concatenar(L,[E | Es],Ln):- 
	lsr_agregarElem(L,E,L1),
	lsr_concatenar(L,Es,L2),
	append(L1,L2,Ln).
	
/* Lista sin repeticiones */

verificarVictoria(Grid,1):-
	flick(Grid,y,GridN),
	grid(3,GridN).


verificarVictoria(Grid,0). 


