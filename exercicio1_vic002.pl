%--------------------------------------------------------------------------------------------

% Sistemas de Representação de Conhecimento e Raciocínio - Exercício 1

%--------------------------------------------------------------------------------------------
% Definição de invariante

:- op(900,xfy,'::').

%--------------------------------------------------------------------------------------------
% Base de conhecimento com informação sobre instituições, serviços, professionais e utentes

% :- dyanamic instituicao/3.

:- dynamic inst/2.

:- dynamic utente/4.

% Databse - versão futura
% dbgeral(nomeinst,[nomeservico,[profissionais],[utentes]]).


% instituicao(Instituicao, Servico, Profossional) :-
%    dbgeral(Instituicao, Servico, Profissional).

% Extensao do predicado profissional: Instituicao,Servico,Prof -> {V,F}	 
profissional(h1,pediatria,medico1).
profissional(h1,obstetricia,medico2).
profissional(h1,orl,medico3).
profissional(h1,fisioterapia,medico44).
profissional(h1,oftalmologia,medico55).

profissional(h2,oncologia,medico21).
profissional(h2,obstetricia,medico22).
profissional(h2,orl,medico23).
profissional(h2,mgf,medico44).
profissional(h2,oftalmologia,medico55).

% Extensao do predicado inst: Instituicao,Servico -> {V,F}
inst(h1,pediatria).
inst(h1,obstetricia).
inst(h1,orl).
inst(h1,fisioterapia).
inst(h1,oftalmologia).

inst(h2,oncologia).
inst(h2,obstetricia).
inst(h2,orl).
inst(h2,mgf).
inst(h2,oftalmologia).

% ----------- VER
% Invariante Estrutural:  nao permitir a insercao de serviços repetidos
% +int( I,S ) :: (
%   solucoes( (I,S),(inst( I,S )),C ), 
%      comprimento( C,N ), 
%			N == 1
%   ).


% Extensão do predicado utente: Utente, Instituicao, Servico, Professional -> {V, F}

utente(utente1,h1,pediatria,medico1).



% Identificar os serviçoes existentes numa instituição
% Extensão do predicado servicos: I, Ls -> {V,F}

servicos(I,[X]) :-
	inst(I,X).
servicos(I,[X|L]) :-
	inst(I,X),
	servicos(I,L).


% Identificar os utentes de uma instituição
% Extensão do predicado utentes: I, Lu -> {V, F}
% utente(Utente,Instiruicao,Servico,Medico).
utentes(I,[X]) :-
	utente(X,I,_,_).
utentes(I,[X|L]) :-
	utente(X,I,_,_);
	utentes(I,L).



% Identificar os utentes de um determinado serviço
% Extensao do predicado utenteServico: S, Lu -> {V, F}

utenteServico(S,[X]) :-
	utente(X,_,S,_).
utenteServico(S,[X|L]) :-
	utente(X,_,S,_),
	utenteServico(S,L).



% Identificar os utentes de um determinado serviço numa instituição
% utente(utente1,h1,pediatria,medico1).
utenteServicoInst(I, S,[X]) :-
	utente(X,I,S,_).
utenteServicoInst(I, S,[X|L]) :-
	utente(X,I,S,_),
	utenteServicoInst(I, S, L).


% Identificar as instituições onde seja prestado um dado serviço ou conjunto de serviços
servicoDe([X], Local) :- inst(Local,X).
servicoDe([X|Lista], Local) :-
	inst(Local,X), servicoDe([Lista], Local).

% Identificar as instituições onde seja prestado um dado serviço ou conjunto de serviços
profDe(Profissional, Instituicao) :-
	profissional(Instituicao, _ , Profissional).

% Identificar os serviços que não se podem encontrar numa instituição
servicosIndisponiveis(X) :- inst(I,S), I \= X, \member(S, servicosEm(X, S)).
% criar lista de servicos

% Determinar as instituições onde um profissional presta serviço

% Determinar todas as instituições (ou serviços, ou profissionais) a que um utente já recorreu

% Registar utentes, profissionais, serviços ou instituições

% Remover utentes (ou profissionais, ou serviços, ou instituições) dos registos






















% Extensao do predicado pertence: Elemento,Lista -> {V,F}
% member(X, [1,2,3])



% Extensao do predicado comprimento: Lista,Comprimento -> {V,F}

comprimento( [],0 ).
comprimento( [_|L],N ) :-
    comprimento( L,N1 ),
    N is N1+1.


% Extensao do meta-predicado nao: Q -> {V,F}
% nao(Q) :- Q, !, fail.
% nao(Q).
nao(Q):- call(Q),!,fail.
nao(_).


% Extensão do predicado que permite a evolucao do conhecimento

evolucao( Termo ) :-
		solucoes( Invariante,+Termo::Invariante,Lista ),
		insercao( Termo ),
		teste( Lista ).
		
insercao( Termo ) :- assert( Termo ).
insercao( Termo ) :- retract( Termo ),!,fail.

verificar( [] ).
verificar( [R|LR] ) :-
		R,
		verificar( LR ).

solucoes( X,Y,Z ) :-
		findall( X,Y,Z ).

% comprimento( S, N ) :-
%		length( S, N ).



% DAS PRATICAS para referencia - porventura ERRADO
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado filho: Filho,Pai -> {V,F,D}

filho( joao,jose ).
filho( jose,manuel ).
filho( carlos,jose ).

% Invariante Estrutural:  nao permitir a insercao de conhecimento
%                         repetido

+filho( F,P ) :: (solucoes( (F,P),(filho( F,P )),S ),
                  length( S,N ), 
				  N == 1
                  ).

% Invariante Referencial: nao admitir mais do que 2 progenitores
%                         para um mesmo individuo
% -**--*-*-*-*-**-*-*-** alterado **-*-*-*-*-*-*--*-*-*-*-*-*

+filho( F,_ ) :: (solucoes( (Ps),(filho( F,Ps )),S ),
				   length( S,N ),
				   N=<2
                  ).
									
% NOVO 
% vii. Não podem existir mais do que 2 progenitores para um dado indivíduo,
% na relação pai/2;
+pai( _,F ) :: (solucoes( (Ps),(filho( F,Ps )),S ),
				   comprimento( S,N ),
				   N=<2
                  ).

