%--------------------------------------------------------------------------------------------

% Sistemas de Representação de Conhecimento e Raciocínio - Exercício 1

%--------------------------------------------------------------------------------------------
% Definição de invariante

:- op(900,xfy,'::').

%--------------------------------------------------------------------------------------------
% Base de conhecimento com informação sobre instituições, serviços, professionais e utentes

:- dyanamic instituicao/3.

:- dynamic inst/2.

:- dynamic utente/4.

% Extensao do predicado instituicao: Instituicao,Servico,Profesional -> {V,F}

instituicao(hospital,pediatria,doutor1).
instituicao(hospital,obstetricia,doutor2).
instituicao(hospital,otorrinolaringologia,doutor3).
instituicao(hospital,fisioterapia,doutor4).
instituicao(hospital,oftalmologia,doutor5).

% Extensao do predicado inst: Instituicao,Servico -> {V,F}

inst(hospital,pediatria).
inst(hospital,obstetricia).

% Extensão do predicado utente: Utente, Instituicao, Servico, Professional -> {V, F}

utente(utente1,hospital,pediatria,doutor1).



% Identificar os serviçoes existentes numa instituição
% Extensão do predicado servicos: I, Ls -> {V,F}

servicos(I,[X]) :-
	inst(I,X).
servicos(I,[X|L]) :-
	inst(I,X),
	servicos(I,L).	


% Identificar os utentes de uma instituição
% Extensão do predicado utentes: I, Lu -> {V, F}

utentes(I,[X]) :-
	utente(X,I,S,D).
utentes(I,[X|L]) :-
	utente(X,I,S,D),
	utentes(I,L).



% Identificar os utentes de um determinado serviço
% Extensao do predicado utenteServico: S, Lu -> {V, F}

utenteServico(S,[X]) :-
	utente(X,I,S,D).
utenteServico(S,[X|L]) :-
	utente(X,I,S,D),
	utenteServico(S,L).



% Identificar os utentes de um determinado serviço numa instituição



% Identificar as instituições onde seja prestado um dado serviço ou conjunto de serviços

% Identificar os serviços que não se podem encontrar numa instituição

% Determinar as instituições onde um profissional presta serviço

% Determinar todas as instituições (ou serviços, ou profissionais) a que um utente já recorreu

% Registar utentes, profissionais, serviços ou instituições

% Remover utentes (ou profissionais, ou serviços, ou instituições) dos registos






















% Extensao do predicado pertence: Elemento,Lista -> {V,F}

pertence( X,[X|L] ).
pertence( X,[Y|L] ) :-
    X \= Y,
    pertence( X,L ).


% Extensao do predicado comprimento: Lista,Comprimento -> {V,F}

comprimento( [],0 ).
comprimento( [X|L],N ) :-
    comprimento( L,N1 ),
    N is N1+1.


% Extensao do meta-predicado nao: Q -> {V,F}

nao(Q) :-
  Q, !, fail.
nao(Q).


% Extensão do predicado que permite a evolucao do conhecimento

evolucao(T) :-
	findall(I, +T::I, Li).
	inserir(T).
	verificar(Li).


inserir(T) :-
	assert(T).
inserir(T) :-
	retract(T), !, fail.


verificar([]).
verificar([I|L]) :-
	I, 
	verificar(L).



