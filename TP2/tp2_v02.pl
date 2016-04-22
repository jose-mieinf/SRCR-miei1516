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
% utente: IdUt, Nome, Idade, Morada --> { V, F, D }
% servi�o: Serv, Descri��o, Institui��o, Cidade --> { V, F, D }
% consulta: DataHora, IdUt, Serv, Custo --> { V, F, D }
% datahora: Dia, Mes, Ano, Hora, Minuto --> {V,F,D} 


% Representar conhecimento positivo e negativo;
% Atencao: os identificadores devem ser obrigatoriamente v�lidos conhecidos
% -utente( yesIdUt, noNome, noIdade, noMorada ). 
% -servico( yesServ, noDescri��o, noInstituicao, Cidade ).
% -consulta( yesDataHora, yesIdUt, yesServ, noCusto ).

utente(1,joao,98,"Rua da Liberdade nr. 19").
utente(2,jaime,95,"Rua da Liberdade nr. 21").
utente(3,joana,90,"Rua do Peloirinho nr. 7").
utente(4,manuel,89,"Rua da Liberdade nr. 8").
utente(5,mario,85,"Rua do Peloirinho nr. 12").
utente(6,marco,82,"Avenida Marechal M�rio nr. 11").
utente(7,ana,79,"Rua da Liberdade nr. 25").
utente(8,sofia,81,"Rua do Peloirinho nr. 19").
utente(9,maria,92,"Avenida Marechal M�rio nr. 12").
utente(10,susana,25,"Rua Guida Aguiar nr. 3").
utente(11,sandra,45,"Rua da Liberdade nr. 31").
utente(12,filipe,76,"Rua da Guida Aguiar nr. 8").
utente(13,artur,67,"Avenida Marechal M�rio nr. 3").
utente(14,jose,15,"Avenida Dom Miguel III nr. 8").
utente(15,jorge,34,"Avenida Dom Miguel III nr. 8").
utente(16,diana,56,"Avenida Dom Miguel III nr. 16").
utente(17,soraia,32,"Rua Conde de Cant�bria nr. 13").
utente(18,filipa,33,"Rua do Peloirinho nr. 27").
utente(19,antonio,34,"Rua do Peloirinho nr. 27").
utente(20,rui,90,"Avenida Marechal M�rio nr. 32").
utente(21,franscisca,15,"Rua Conde de Cant�bria nr. 19").
utente(22,igor,16,"Rua Ant�nio Antero Alves nr 9").
utente(23,vitor,67,"Rua da Liberdade nr. 32").
utente(24,francisco,67,"Rua 29 de Fevereiro nr. 2").
utente(25,daniel,16,"Rua da Liberdade nr. 5").
utente(26,tiago,16,"Rua Ant�nio Antero Alves nr 15").
utente(27,celeste,43,"Rua da Liberdade nr. 5").
utente(28,eurico,45,"Rua 29 de Fevereiro nr. 7").
utente(29,fernando,48,"Avenida Rainha Gertrudes nr. 10").
utente(30,paula,50,"Avenida Rainha Gertrudes nr. 10").
utente(31,nome_desconhecido,50,"Avenida Rainha Gertrudes nr. 12").
utente(32,manuela,idade_desconhecida,"Rua do Olival nr. 40").


-utente(Id,Nome,Idade,Morada) :-
	nao(utente(Id,Nome,Idade,Morada)) ,
	nao(excecao(utente(Id,Nome,Idade,Morada))).
	
excecao(utente(Id,Nome,Idade,Morada)) :-
	utente(Id,nome_desconhecido,Idade,Morada).
	
excecao(utente(Id,Nome,Idade,Morada)) :-
	utente(Id,Nome,idade_desconhecida,Morada).

excecao(utente(31,maria,50,"Avenida Rainha Gertrudes nr. 12")).
excecao(utente(31,anabela,50,"Avenida Rainha Gertrudes nr. 12")).

% Invariante estrutural
+utente(Id,Nome,Idade,Morada) :: (solucoes((Id,Nome,Idade,Morada),(utente(Id,Nome,Idade,Morada)),S),
								 comprimento(S,N),
								 N == 1).


% Representar casos de conhecimento imperfeito, pela utiliza��o de valores nulos de todos os tipos estudados;
% Manipular invariantes que designem restri��es � inser��o e � remo��o de conhecimento do sistema;
% Lidar com a problem�tica da evolu��o do conhecimento, criando os procedimentos adequados;
% Desenvolver um sistema de infer�ncia capaz de implementar os mecanismos de racioc�nio inerentes a estes sistemas.

% Invariantes Estruturais: nao permitir a insercao de conhecimento repetido.
% utente (permitidos utentes com dados semelhantes mas com id diferente; ex. pai e filho com mesmo nome e morada)
%+utente( IdUt, Nome, Idade, Morada ) :: (solucoes( IdUt, (utente( IdUt, _, _, _ )), S ), 
%                                        comprimento( S, N ), N == 1 ).
%+utente( IdUt, Nome, Idade, Morada ) :: (solucoes( IdUt, (utente( IdUt, Nome, Idade, Morada )), S ), comprimento( S, N ), N == 1 ).
%
% servico (permitidos servi�os identicos mas com id diferente)
%+servico( Serv, Descricao, Instituicao, Cidade ) :: (solucoes( Serv, (servico( Serv, _, _, _ )), S ), 
%                                        comprimento( S, N ), N == 1 ).

% consulta
%+consulta( DataHora, IdUt, Serv, Custo ) :: (solucoes( XXXX, (consulta( DataHora, IdUt, Serv, Custo )), S ), 
%                                        comprimento( S, N ), N == 1 ).
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
%utente( 1, joao, 20, braga ).
%utente( 2, joao, 22, porto ).
%utente( 3, maria, 60, chaves ).
%utente( 4, jose, 33, aveiro ).
%
%servico( 1, orl, hosp1, braga ).
%servico( 2, pediatria, hosp1, braga ).
%servico( 3, orl, hosp2, porto ).
%servico( 4, cardiologia, hosp3, aveiro ).
%
%consulta( dt(2016, 01, 11), 3, 3, 160).
%consulta( dt(2016, 01, 12), 4, 3, 80).
%consulta( dt(2016, 02, 20), 1, 1, 100).
%consulta( dt(2016, 02, 12), 2, 4, 50).
%
%consulta(dt(2016, 02, 12), 2, 4, xpto).
%excecao( consulta(D, U, S, C) ) :- consulta(D, U, S, xpto).
%  ii.	O �rbitro Baltazar Borges apitou o segundo jogo, tendo recebido 
%       a t�tulo de ajudas de custo um valor que ainda ningu�m conhece;
% jogo(2, 'Baltazar Borges', xpto).
% excecao(jogo(J, +, V) :- jogo(J, A, xpto).

% viii. O Fausto n�o sabe se a filha se chama F�bia ou Oct�via e desconhece-se o nome da m�e;
% pais(F, "Fausto", M).
% F=F�bia; F=Oct�via
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
