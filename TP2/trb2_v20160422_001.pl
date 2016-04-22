%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SRCR - MiEI/3
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programacao em logica estendida
%
% Representacao de conhecimento imperfeito
% Trabalho pratico 2
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: Declaracoes iniciais

:- set_prolog_flag( discontiguous_warnings,off ).
:- set_prolog_flag( single_var_warnings,off ).
:- set_prolog_flag( unknown,fail ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SICStus PROLOG: definicoes iniciais

:- op( 900,xfy,'::' ).
:- dynamic utente/4.
:- dynamic servico/4.
:- dynamic consulta/4.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -


% =====================================================================
% =====================================================================
% TRABALHO 2
% utente: #IdUt, Nome, Idade, Morada --> { V, F, D }
% serviço: #Serv, Descrição, Instituição, Cidade --> { V, F, D }
% consulta: DataHora, #IdUt, #Serv, Custo --> { V, F, D }

% Representar conhecimento positivo e negativo;
% Atencao: os identificadores devem ser obrigatoriamente válidos/conhecidos
% -utente( yesIdUt, noNome, noIdade, noMorada ). 
% -servico( yesServ, noDescrição, noInstituicao, Cidade ).
% -consulta( yesDataHora, yesIdUt, yesServ, noCusto ).

% Representar casos de conhecimento imperfeito, pela utilização de valores nulos de todos os tipos estudados;
% Manipular invariantes que designem restrições à inserção e à remoção de conhecimento do sistema;
% Lidar com a problemática da evolução do conhecimento, criando os procedimentos adequados;
% Desenvolver um sistema de inferência capaz de implementar os mecanismos de raciocínio inerentes a estes sistemas.

% Invariantes Estruturais: nao permitir a insercao de conhecimento repetido.
% utente (permitidos utentes com dados semelhantes mas com id diferente; ex. pai e filho com mesmo nome e morada)
+utente( IdUt, Nome, Idade, Morada ) :: (solucoes( IdUt, (utente( IdUt, _, _, _ )), S ), 
                                         comprimento( S, N ), N == 1 ).
%+utente( IdUt, Nome, Idade, Morada ) :: (solucoes( IdUt, (utente( IdUt, Nome, Idade, Morada )), S ), comprimento( S, N ), N == 1 ).
%
% servico (permitidos serviços identicos mas com id diferente)
+servico( Serv, Descricao, Instituicao, Cidade ) :: (solucoes( Serv, (servico( Serv, _, _, _ )), S ), 
                                         comprimento( S, N ), N == 1 ).

% consulta
+consulta( DataHora, IdUt, Serv, Custo ) :: (solucoes( XXXX, (consulta( DataHora, IdUt, Serv, Custo )), S ), 
                                         comprimento( S, N ), N == 1 ).
%--------------------------------- - - - - - - - - - -  -  -  -  -   -

evolucao( Termo ) :-
    solucoes( Invariante,+Termo::Invariante,Lista ),
    insercao( Termo ),
    teste( Lista ).

insercao( Termo ) :- assert( Termo ).
insercao( Termo ) :- retract( Termo ),!,fail.

teste( [] ).
teste( [R|LR] ) :- R, teste( LR ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado demo: Questao,Resposta -> {V,F}

demo( Questao,verdadeiro ) :- Questao.
demo( Questao, falso ) :- -Questao.
demo( Questao,desconhecido ) :-
    nao( Questao ),
    nao( -Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :- Questao, !, fail.
nao( Questao ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

solucoes( X,Y,Z ) :- findall( X,Y,Z ).

comprimento( S,N ) :- length( S,N ).

% =====================================================================

% MANIOULACAO DE DATAS
data(A, M, D).
% Invariante EstruturaL: nao permitir a insercao de conhecimento repetido.
+data(A, M, D) :: (solucoes( data(A, M, D), S ), comprimento( S, N ), N == 1).

% =====================================================================

% conhecimento exemplo
utente( 1, joao, 20, braga ).
utente( 2, joao, 22, porto ).
utente( 3, maria, 60, chaves ).
utente( 4, jose, 33, aveiro ).

servico( 1, orl, hosp1, braga ).
servico( 2, pediatria, hosp1, braga ).
servico( 3, orl, hosp2, porto ).
servico( 4, cardiologia, hosp3, aveiro ).

consulta( dt(2016, 01, 11), 3, 3, 160).
consulta( dt(2016, 01, 12), 4, 3, 80).
consulta( dt(2016, 02, 20), 1, 1, 100).
consulta( dt(2016, 02, 12), 2, 4, 50).

consulta(dt(2016, 02, 12), 2, 4, xpto).
excecao( consulta(D, U, S, C) ) :- consulta(D, U, S, xpto).
%  ii.	O árbitro Baltazar Borges apitou o segundo jogo, tendo recebido 
%       a título de ajudas de custo um valor que ainda ninguém conhece;
% jogo(2, 'Baltazar Borges', xpto).
% excecao(jogo(J, +, V) :- jogo(J, A, xpto).

% viii. O Fausto não sabe se a filha se chama Fábia ou Octávia e desconhece-se o nome da mãe;
% pais(F, "Fausto", M).
% F=Fábia; F=Octávia
% pais(filhoxpto, "Fausto", maexpto). % maexpto (existe mae)
% excecao(pais("Fabia", "Fausto", Maexpto)). % Maexpto vs maexpto
% excecao(pais("Otavia", "Fausto", Maexpto)). % Maexpto vs maexpto
%
% CONHECIMENTO IMPERFEITO
% CONHECIMENTO INTERDITO
% O Julio tem um filho que ninguem pode conhecer
% filho( xpto732,julio ).
% excecao( filho( F,P ) ) :- filho( xpto732,P ).
% nulo( xpto732 ).
% +filho( F,P ) :: (solucoes( (Fs,P),(filho(Fs,julio),nao(nulo(Fs))),S ),
%                   comprimento( S,N ), N == 0 
%                  ).
