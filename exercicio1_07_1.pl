%--------------------------------------------------------------------------------------------

% Sistemas de Representação de Conhecimento e Raciocínio - Exercício 1

%--------------------------------------------------------------------------------------------
% Definição de invariante

:- op(900,xfy,'::').

%--------------------------------------------------------------------------------------------
% Base de conhecimento com informação sobre instituições, serviços, professionais e utentes


:- dynamic( instituicao/3 ).

:- dynamic( utente/4 ).

% Extensao do predicado instituicao: Instituicao,Servico,Profesional -> {V,F}

instituicao(hospital1,pediatria,medico1).
instituicao(hospital1,obstetricia,medico2).
instituicao(hospital1,orl,medico3).
instituicao(hospital1,fisioterapia,medico4).
instituicao(hospital1,oftalmologia,medico5).
instituicao(hospital2,pediatria,medico1).
instituicao(hospital2,orl,medico7).
instituicao(hospital2,fisioterapia,medico8).
instituicao(hostipal2,cardiologia,medico9).
instituicao(hospital2,cardiologia,medico10).


% Extensão do predicado utente: Utente, Instituicao, Servico, Professional -> {V, F}

utente(utente1,hospital1,pediatria,medico1).
utente(utente2,hospital1,pediatria,medico1).
utente(utente2,hospital2,cardiologia,medico9).
utente(utente3,hospital2,cardiologia,medico10).
utente(utente4,hospital2,orl,medico7).


% Invariante Estrutural para instituicao:  nao permitir a insercao de conhecimento repetido

+instituicao(I,S,P) :: (findall((I,S,P),(inst(I,S,P)),Ls ),
               		comprimento(Ls,N),
	       		N == 1
	       		).


% Identificar os serviçoes existentes numa instituição
% Extensão do predicado servicos: I, Ls -> {V,F}

servicos(I,[X]) :-
	instituicao(I,X,_).
servicos(I,[X|L]) :-
	instituicao(I,X,_),
	servicos(I,L).	


% Identificar os utentes de uma instituição
% Extensão do predicado utentes: I, Lu -> {V, F}

utentes(I,[X]) :-
	utente(X,I,_,_).
utentes(I,[X|L]) :-
	utente(X,I,_,_),
	utentes(I,L).



% Identificar os utentes de um determinado serviço
% Extensao do predicado utenteServico: S, Lu -> {V, F}

utenteServico(S,[X]) :-
	utente(X,_,S,_).
utenteServico(S,[X|L]) :-
	utente(X,_,S,_),
	utenteServico(S,L).


% Identificar os utentes de um determinado serviço numa instituição
% Extensao do predicado utenteServicoInst: S, I, Lu -> {V, F}

utenteServicoInst(S, I, [X]) :-
	utente(X,I,S,_).
utenteServicoInst(S,I,[X|L]) :-
	utente(X,I,S,_),
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
	instituicao(I,_,P).
professionalInst(P, [I|L]) :-
	instituicao(I,_,P),
	professionalInst(P,L). 


% Determinar todas as instituições (ou serviços, ou profissionais) a que um utente já recorreu
% Extensao do predicado utenteListaInst: U, Li -> {V, F}

utenteListaInst(U,[I]) :-
	utente(U,I,_,_).
utenteListaInst(U,[I|L]) :-
	utente(U, I, _, _),
	utenteListaInst(U, L).


% Extensao do predicado utenteListaServ: U, Ls -> {V, F}

utenteListaServ(U,[S]) :-
	utente(U,_,S,_).
utenteListaServ(U,[S|L]) :-
	utente(U, _, S, _),
	utenteListaServ(U, L).



% Extensao do predicado utenteListaPro: U, Lp -> {V, F}

utenteListaPro(U,[P]) :-
	utente(U,_,_,P).
utenteListaPro(U,[P|L]) :-
	utente(U, _, _, P),
	utenteListaPro(U, L).


% Registar utentes, profissionais, serviços ou instituições

% registaUtente(U,I,S,P) :-
%	evolucao(utente(U,I,S,P). 




% Remover utentes (ou profissionais, ou serviços, ou instituições) dos registos

% removeUtente(U) :-
	






















% Extensao do predicado pertence: Elemento,Lista -> {V,F}

pertence( X,[X|_] ).
pertence( X,[Y|L] ) :-
    X \= Y,
    pertence( X,L ).


% Extensao do predicado comprimento: Lista,Comprimento -> {V,F}

comprimento( [],0 ).
comprimento( [_|L],N ) :-
    comprimento( L,N1 ),
    N is N1+1.


% Extensao do meta-predicado nao: Q -> {V,F}

nao(Q) :-
  Q, !, fail.
nao(_).


% Extensão do predicado que permite a evolucao do conhecimento

evolucao(T) :-
	findall(I, +T::I, Li),
	inserir(T),
	verificar(Li).


inserir(T) :-
	assert(T).
inserir(T) :-
	retract(T), !, fail.


verificar([]).
verificar([I|L]) :-
	I, 
	verificar(L).



