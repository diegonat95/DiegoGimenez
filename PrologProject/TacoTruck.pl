%Taco ingridients and cost
cost(carne_asada,6).
cost(lengua,2).
cost(birria,2).
cost(carnitas,2).
cost(adobado,2).
cost(al_pastor,2).
cost(guacamole,1).
cost(rice,1).
cost(beans,1).
cost(salsa,1).
cost(cheese,1).
cost(sour_cream,1).
cost(taco,1).
cost(tortilla,1).
cost(sopa, 0).

%Items and ingridients
ingredients(carnitas_taco,
 [taco,carnitas, salsa, guacamole]).
ingredients(birria_taco,
 [taco,birria, salsa, guacamole]).
ingredients(al_pastor_taco,
 [taco,al_pastor, salsa, guacamole, cheese]).
ingredients(guacamole_taco,
 [taco,guacamole, salsa,sour_cream]).
ingredients(al_pastor_burrito,
 [tortilla,al_pastor, salsa]).
ingredients(carne_asada_burrito,
 [tortilla,carne_asada, guacamole, rice, beans]).
ingredients(adobado_burrito,
 [tortilla,adobado, guacamole, rice, beans]).
ingredients(carnitas_sopa,
 [sopa,carnitas, guacamole, salsa,sour_cream]).
ingredients(lengua_sopa,
 [sopa,lengua, salsa, beans,sour_cream]).
ingredients(combo_plate,
 [al_pastor, carne_asada,rice, tortilla, beans,
salsa, guacamole, cheese]).
ingredients(adobado_plate,
 [adobado, guacamole, rice, tortilla, beans,
cheese]).

%Taco trucks
taco_truck(el_cuervo, [ana,juan,maria],
 [carnitas_taco, combo_plate, al_pastor_taco,
carne_asada_burrito]).
taco_truck(la_posta,
 [victor,maria,carla], [birria_taco, adobado_burrito,
carnitas_sopa, combo_plate, adobado_plate]).
taco_truck(robertos, [hector,carlos,miguel],
 [adobado_plate, guacamole_taco, al_pastor_burrito,
carnitas_taco, carne_asada_burrito]).
taco_truck(la_milpas_quatros, [jiminez, martin, antonio,miguel],
 [lengua_sopa, adobado_plate, combo_plate]).


isin(X,[X|_]).                %Check if X is in the head
isin(X,[_|Y]) :- isin(X,Y).   %Check if X is in the tail

%calculate length of a list
lengthList([],0).
lengthList([_|Tail], Length) :- lengthList(Tail, Total), Length is Total + 1.

%get intersection for avoids_ingredients
intersection([], _, []).
intersection([Head|L1tail], L2, L3) :- memberchk(Head, L2),!, L3 = [Head|L3tail], intersection(L1tail, L2, L3tail).
intersection([_|L1tail], L2, L3) :- intersection(L1tail, L2, L3).

%to make the union of two lists and remove duplicates
clean([],Soln,Y) :- reverse(Y,Soln).
clean([H|T],Soln,Y) :- isin(H,Y),!,clean(T,Soln,Y).
clean([H|T],Soln,Y) :- clean(T,Soln,[H|Y]).
remove_duplicates(L1,L2) :- clean(L1,L2,[]).
union(L1, L2, L3) :- append(L1, L2, L), remove_duplicates(L, L3).

%calculate worker
works(Person, Truck) :- taco_truck(Truck, People, _), isin(Person, People).

%calculate cost of every element
sum_ingredients([],0).
sum_ingredients([Head|Tail], Total) :- sum_ingredients(Tail, Rest), cost(Head, Cost), Total is Cost + Rest.

%True if item X is available at taco truck Y
available_at(X,Y) :- taco_truck(Y,_,Z), isin(X,Z).

%true	if	the	item	X is	available	at more	than	one	place.
multi_available(X) :- bagof(Truck, available_at(X,Truck),Trucks), lengthList(Trucks, Total), Total>1.

%true if the person X works at more than one taco truck
overworked(X) :- bagof(Truck, worker(X, Truck), Trucks), lengthList(Trucks, Total), Total>1.

%true if the item X has all the ingredients listed in L
has_ingredients(X,L) :- ingredients(X, IL), union(IL, L, IL).

%true if the item X does not have any of the ingredients in L.
avoids_ingredients(X, L) :- ingredients(X, Ingredients), intersection(L, Ingredients, L3), L3 = [].

%total cost of ingredients
total_cost(X,K) :- ingredients(X,L), sum_ingredients(L,K).
