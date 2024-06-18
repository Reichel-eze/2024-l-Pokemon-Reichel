% Aquí va el código.
/*
type Pokemon = String

data Entrenador = Entrenador {
	pokemones :: [Pokemon]
}

ash = Entrenador {
	pokemones = ["pikachu", "eevee"]
}

tieneA :: Pokemon -> Entrenador -> Bool
tieneA pokemon = elem pokemon . pokemones

tieneAlgun entrenador = not.null.pokemones
*/
%propiedad
%Principio de Universo Cerrado
%relacion
%tieneA(Entrenador, Pokemon).
tieneA(ash,pikachu).   % ash tiene a pikachu
tieneA(ash,charizard). % ash tiene a charizard
tieneA(ash,pidgeot).
tieneA(brock,pikachu).
tieneA(brock,charizard).
tieneA(brock,gyarados).
tieneA(misty,charizard).
tieneA(alf,capy).
tieneA(eze,jiji).

/*
Consultas que podmos hacer con un solo predicado:
?- tieneA(ash, pikachu). % ¿ash tiene a pikachu?
?- tieneA(ash, Pokemon). % ¿que pokemones tiene ash?
?- tieneA(Entrenador, pikachu). % ¿existe un entrenador que tiene a pikachu?
?- tieneA(Entrenador, Pokemon). % ¿existe un entrenador que tiene a que pokemon?
?- tieneA(Entrenador, _). % ¿quienes tienen pokemones?
?- tieneA(_, Pokemon). % ¿quienes son tenidos por un entrenador?
?- tieneA(ash, _). % ¿tiene ash a alguen pokemon?
?- tieneA(_, pikachu). % ¿alguien tiene a pikachu?
?- tieneA(_, _). % ¿alguien tiene a alguien?
*/

%p => q se pone como q :- p
quiereSerElMejor(Persona) :- entrenador(Persona).

entrenador(Persona) :- tieneA(Persona,_). % si tiene un pokemon -> es un entrenador

entrenador(pepito). % NO tiene pokemones pepito

% 1) es poderoso: persona tiene a charizard y pikachu o bien si es ash

% p^q => se pone como r :- p,q.
% pvq => se pone como r :- p. r :- q.

esPoderoso(ash).

esPoderoso(Persona) :-
    tieneA(Persona,pikachu),
    tieneA(Persona,charizard).

% BACKTRACKING: lo que nos hace felices :)

% 2) es un buen pokemon: si su ataque es > a su defensa
% o si su entrenador es poderoso

esBuenPokemon(Pokemon) :-
    tieneA(Entrenador,Pokemon),     % pero el entrenador lo tiene que tener al pokemon
    esPoderoso(Entrenador).         % su entrenador es poderoso

    % o (disyuncion)

esBuenPokemon(Pokemon) :-
    seCaracterizaPor(Pokemon,Ataque,Defensa),
    Ataque > Defensa.

% seCaracterizaPor(Pokemon, Ataque, Defensa).
seCaracterizaPor(pikachu, 100, 50).
seCaracterizaPor(pidgeot, 30, 70).
seCaracterizaPor(charizard, 130, 130).
seCaracterizaPor(capy, 6, 5).

% INVERSIBILIDAD

% Un entrenador esta solo cuando NO tiene pokemones
estaSolo(Entrenador) :-
    entrenador(Entrenador),    % tengo que decirle que es un entrenador
    not(tieneA(Entrenador,_)). % NO tiene pokemones (por ej: pepito)
