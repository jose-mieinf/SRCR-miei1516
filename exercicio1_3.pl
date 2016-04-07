%--------------------------------------------------------------------------------------------

% Sistemas de Representação de Conhecimento e Raciocínio - Exercício 1

%--------------------------------------------------------------------------------------------
% Definição de invariante

:- op(900,xfy,'::').

%--------------------------------------------------------------------------------------------
% Base de conhecimento com informação sobre instituições, serviços, professionais e utentes


% :- dyanamic instituicao/3.

% :- dynamic inst/2.

% :- dynamic utente/4.

% Extensao do predicado instituicao: Instituicao,Servico,Profesional -> {V,F}

instituicao(h1,pediatria,medico1).
instituicao(h1,obstetricia,medico2).
instituicao(h1,orl,medico3).
instituicao(h1,fisioterapia,medico4).
instituicao(h1,oftalmologia,medico5).
instituicao(h2,pediatria,medico1).
instituicao(h2,orl,medico7).
instituicao(h2,fisioterapia,medico8).
instituicao(h2,cardiologia,medico9).
instituicao(h2,cardiologia,medico10).


% Extensao do predicado inst: Instituicao,Servico -> {V,F}

inst(hospital,pediatria).
inst(hospital,obstetricia).
inst(hospital,otorrinolaringologia).
inst(hospital,fisioterapia).
inst(hospital,oftalmologia).



% Extensão do predicado utente: Utente, Instituicao, Servico, Professional -> {V, F}

utente(utente1,h1,pediatria,medico1).
utente(utente2,h1,pediatria,medico1).
utente(utente2,h2,cardiologia,medico9).
utente(utente3,h2,cardiologia,medico10).
utente(utente4,h2,orl,medico7).


% Invariante Estrutural:  nao permitir a insercao de conhecimento repetido

+inst(I,S) :: (findall((I,S),(inst(I,S)),Ls ),
                  comprimento(Ls,N), 
		  N == 1
                  ).



% Identificar os serviçoes existentes numa instituição
% Extensão do predicado servicos: I, Ls -> {V,F}

servicos(I,[X]) :-
	instituicao(I,X,P).
servicos(I,[X|L]) :-
	instituicao(I,X,P),
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
% Extensao do predicado utenteServicoInst: S, I, Lu -> {V, F}

utenteServicoInst(S, I, [X]) :-
	utente(X,I,S,D).
utenteServicoInst(S,I,[X|L]) :-
	utente(X,I,S,D),
	utenteServicoInst(S,I,L).


% Identificar as instituições onde seja prestado um dado serviço ou conjunto de serviços
% Extensao do predicado instServicos: Ls, Li -> {V, F}

% instsServicos() :-




% Identificar os serviços que não se podem encontrar numa instituição
% Extensao do predicado servicosNdInst: I, Ls -> {V, F}


% servicosNdInst(I, [X]) :-
%	instituicao(I,X,P).
% servicosNdInst(I, [X|L]) :-
%	instituicao(I,X,P),
%	servicosNdInst(I,L).


% Determinar as instituições onde um profissional presta serviço
% Extensao do predicado professionalInst: P, Li -> {V, F}

professionalInst(P, [I]) :-
	instituicao(I,X,P).
professionalInst(P, [I|L]) :-
	instituicao(I,X,P),
	professionalInst(P,L). 


% Determinar todas as instituições (ou serviços, ou profissionais) a que um utente já recorreu
% Extensao do predicado utenteListaInst: U, Li -> {V, F}

utenteListaInst(U,[I]) :-
	utente(U,I,S,P).
utenteListaInst(U,[I|L]) :-
	utente(U, I, S, P),
	utenteListaInst(U, L).


% Extensao do predicado utenteListaServ: U, Ls -> {V, F}

utenteListaServ(U,[S]) :-
	utente(U,I,S,P).
utenteListaServ(U,[S|L]) :-
	utente(U, I, S, P),
	utenteListaServ(U, L).



% Extensao do predicado utenteListaPro: U, Lp -> {V, F}

utenteListaPro(U,[P]) :-
	utente(U,I,S,P).
utenteListaPro(U,[P|L]) :-
	utente(U, I, S, P),
	utenteListaPro(U, L).


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



