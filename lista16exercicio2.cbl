      $set sourceformat"free"
      *>----Divisão de identificação do programa
       Identification Division.
       Program-id. "lista16exercicio2".
       Author. "Julia Krüger".
       Installation. "PC".
       Date-written. 23/07/2020.
       Date-compiled. 23/07/2020.

      *>----Divisão para configuração do ambiente
       Environment Division.
       Configuration Section.
           special-names. decimal-point is comma.

      *>----Declaração dos recursos externos
       Input-output Section.
       File-control.
           select arqEstados assign to "arqEstados.txt"
           organization is line sequential
           access mode is sequential
           lock mode is automatic
           file status is ws-fs-arqEstados.

       I-O-Control.


      *>----Declaração de variáveis
       Data Division.

      *>----Variáveis de arquivos
       File Section.
       fd arqEstados.
       01 fd-estados.
           05 fd-estadosorteio                     pic x(20)
                                                   value "x".
           05 fd-capitalsorteio                    pic x(20)
                                                   value "x".
       77 fd-num_random                            pic 9(02) value 0.
       77 fd-ind                                   pic 9(02) value 0.



      *>----Variáveis de trabalho
       Working-storage Section.

       01 ws-estados occurs 27.
           05 ws-estadosorteio                     pic x(20)
                                                   value "x".
           05 ws-capitalsorteio                    pic x(20)
                                                   value "x".
       77 ws-semente                               pic 9(02).
       77 ws-ind                                   pic 9(02)
                                                   value 1.
       77 ws-num_random                            pic 9(02).
       77 ws-num-novo                              pic 9(03).
       77 ws-respostacapital                       pic x(25).
       77 ws-estado-mostrar                        pic x(25).

       01 ws-jogo occurs 50.
           05 ws-jogador                           pic x(20)
                                                   value "x".
           05 ws-pontos                            pic 9(05)
                                                   value 0.

       77 ws-fimprograma                           pic x(03).
       77 ws-controle                              pic x(10).
       77 ws-aux                                   pic x(01).
       77 ws-auxjogador                            pic x(20).
       77 ws-auxpontos                             pic 9(02).
       77 ws-lugar                                 pic 9(02)
                                                   value 0.
       77 ws-sair-programa                         pic x(01).
       77 ws-sair-rodada                           pic x(01).

       77 ws-jogador-1                             pic x(50).
       77 ws-jogador-2                             pic x(50).
       77 ws-jogador-3                             pic x(50).
       77 ws-jogador-4                             pic x(50).
       77 ws-capital                               pic x(50).
       77 ws-primeiro-lugar-jogador                pic x(50).
       77 ws-segundo-lugar-jogador                 pic x(50).
       77 ws-terceiro-lugar-jogador                pic x(50).
       77 ws-quarto-lugar-jogador                  pic x(50).
       77 ws-aux-imprime-nome-1                    pic x(50).
       77 ws-aux-imprime-nome-2                    pic x(50).
       77 ws-aux-imprime-nome-3                    pic x(50).
       77 ws-aux-imprime-nome-4                    pic x(50).
       77 ws-aux-imprime-pontos-1                  pic x(50).
       77 ws-aux-imprime-pontos-2                  pic x(50).
       77 ws-aux-imprime-pontos-3                  pic x(50).
       77 ws-aux-imprime-pontos-4                  pic x(50).

       77 ws-fs-arqEstados                         pic 9(02).
       01 ws-msn-erro.
           05 ws-msn-erro-ofsset                   pic 9(04).
           05 filler                               pic x(01) value "-".
           05 ws-msn-erro-cod                      pic 9(02).
           05 filler                               pic x(01) value space.
           05 ws-msn-erro-text                     pic x(42).




      *>----Variáveis para comunicação entre programas
       .Linkage Section.

      *>----Declaração de tela
       screen section.
      *>                                0    1    1    2    2    3    3    4    4    5    5    6    6    7    7    8
      *>                                5    0    5    0    5    0    5    0    5    0    5    0    5    0    5    0
      *>                            ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
      *> tela para cadastrar os jogadores
       01 tela-jogadores.
           05 blank screen.
           05 line 01 col 01 value "                   ---- Jogo de Perguntas e Respostas ----                     "
           foreground-color 14.
           05 line 03 col 01 value "      JOGADORES                                                                "
            foreground-color 14.
           05 line 04 col 01 value "      Jogador(a) 1:                                                            ".
           05 line 05 col 01 value "      Jogador(a) 2:                                                            ".
           05 line 06 col 01 value "      Jogador(a) 3:                                                            ".
           05 line 07 col 01 value "      Jogador(a) 4:                                                            ".
           05 line 11 col 01 value "                                                                        [ ]Sair".

           05 sc-jogador-1             line 04 col 21 pic x(50)
           using ws-jogador-1 foreground-color 12.
           05 sc-jogador-2             line 05 col 21 pic x(50)
           using ws-jogador-2 foreground-color 12.
           05 sc-jogador-3             line 06 col 21 pic x(50)
           using ws-jogador-3 foreground-color 12.
           05 sc-jogador-4             line 07 col 21 pic x(50)
           using ws-jogador-4 foreground-color 12.
           05 sc-sair-programa         line 11 col 74 pic x(01)
           using ws-sair-programa foreground-color 12.

      *>                                0    1    1    2    2    3    3    4    4    5    5    6    6    7    7    8
      *>                                5    0    5    0    5    0    5    0    5    0    5    0    5    0    5    0
      *>                            ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
      *> tela para o jogo
       01 tela-pergunta.
           05 blank screen.
           05 line 02 col 01 value "                        Jogador(a)                                             "
           foreground-color 14.
           05 line 04 col 01 value "      Qual a capital desse estado do Brasil:                                   ".
      *>    05 line 11 col 01 value "                                                                        [ ]Sair".

           05 sc-capital                   line 05 col 07 pic x(25)
           using ws-respostacapital.

      *>                                0    1    1    2    2    3    3    4    4    5    5    6    6    7    7    8
      *>                                5    0    5    0    5    0    5    0    5    0    5    0    5    0    5    0
      *>                            ----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
      *> tela para mostrar a colocação dos jogadores
       01 tela-colocacao.
           05 blank screen.
           05 line 02 col 01 value "                                COLOCACAO                                      "
           foreground-color 14.
           05 line 04 col 01 value "      1 lugar:                                                                 ".
           05 line 05 col 01 value "      Pontos:                                                                  ".
           05 line 07 col 01 value "      2 lugar:                                                                 ".
           05 line 08 col 01 value "      Pontos:                                                                  ".
           05 line 10 col 01 value "      3 lugar:                                                                 ".
           05 line 11 col 01 value "      Pontos:                                                                  ".
           05 line 13 col 01 value "      4 lugar:                                                                 ".
           05 line 14 col 01 value "      Pontos:                                                                  ".
           05 line 18 col 01 value "                                                                        [ ]Sair".

           05 sc-sair                                    line 18 col 74 pic x(01)
           using ws-sair-programa foreground-color 12.

      *>----Declaração do corpo do programa
       Procedure Division.

           perform inicializa.
           perform processamento.
           perform finaliza.

      *>---------------------------------------------------------------------------------------------------
      *> Abrindo o arquivo com os estados e capitais e guardando os dados nas variáveis da working-storage
      *>---------------------------------------------------------------------------------------------------
       inicializa section.
           open input arqEstados.
           if  ws-fs-arqEstados <> 0 then
               move 1                                to ws-msn-erro-ofsset
               move ws-fs-arqEstados                 to ws-msn-erro-cod
               move "Erro ao abrir arq. arqEstados." to ws-msn-erro-text
               perform finaliza-anormal
           end-if

           perform varying ws-ind from 1 by 1 until ws-fs-arqEstados = 10 or ws-ind > 27
               read arqEstados into ws-estados(ws-ind)
               if  ws-fs-arqEstados <> 0 and ws-fs-arqEstados <> 10 then
                   move 2                              to ws-msn-erro-ofsset
                   move ws-fs-arqEstados               to ws-msn-erro-cod
                   move "Erro ao ler arq. arqEstados." to ws-msn-erro-text
                   perform finaliza-anormal
               end-if

               move  fd-estadosorteio to  ws-estadosorteio(ws-ind)
               move fd-capitalsorteio to ws-capitalsorteio(ws-ind)
           end-perform

           close arqEstados.
           if ws-fs-arqEstados <> 0 then
               move 3                                 to ws-msn-erro-ofsset
               move ws-fs-arqEstados                  to ws-msn-erro-cod
               move "Erro ao fechar arq. arqEstados." to ws-msn-erro-text
               perform finaliza-anormal
           end-if
           .
       inicializa-exit.
           exit.


      *>------------------------------------------------------------------------
      *> Processamento do programa
      *>------------------------------------------------------------------------
       processamento section.
               move 1 to ws-ind
               display tela-jogadores
               accept tela-jogadores
               move ws-jogador-1 to ws-jogador(ws-ind)
               move ws-jogador-2 to ws-jogador(ws-ind + 1)
               move ws-jogador-3 to ws-jogador(ws-ind + 2)
               move ws-jogador-4 to ws-jogador(ws-ind + 3)

               perform until ws-sair-programa = "X" or ws-sair-programa = "x"
                   perform until ws-sair-rodada = "X" or ws-sair-rodada = "x"
                       move space to ws-sair-rodada
                       move 1 to ws-ind
                       perform until ws-ind > 4
                           perform sorteio
      *> mostrando na tela a pergunta e recebendo a resposta do usuário
                           display tela-pergunta
                           display ws-jogador(ws-ind) line 02 col 36
                           display ws-estadosorteio(ws-num_random) line 04 col 46
                           accept tela-pergunta
      *> conferindo se a resposta está certa
                           if ws-respostacapital = ws-capitalsorteio(ws-num_random) then
                               display "Voce acertou!" line 07 col 07
                               add 1 to ws-pontos(ws-ind)
                           else
                               display "Voce errou!" line 07 col 07
                           end-if
                           if ws-ind = 4 then
                               display "[ ]Sair" line 11 col 73
                               accept ws-sair-rodada line 11 col 74
                           end-if
                           if ws-ind < 4 then
                               accept ws-aux
                           end-if
                           add 1 to ws-ind
                           move spaces to ws-respostacapital
                       end-perform
                   end-perform
      *> ordenar a colocação dos jogadores
                   perform ordena
      *> mostrar na tela a colocação dos jogadores
                   perform imprime
               end-perform
               .
       processamento-exit.
           exit.

      *>------------------------------------------------------------------------
      *> Cadastrar os jogadores
      *>------------------------------------------------------------------------
       cadastrojogadores section.
           move 1 to ws-ind
           perform until ws-ind > 4
               display "Insira o nome do jogador " ws-ind  ": "
               accept ws-jogador(ws-ind)
               add 1 to ws-ind
           end-perform
           .
       cadastrojogadores-exit.
           exit.

      *>------------------------------------------------------------------------
      *> Sortear um número
      *>------------------------------------------------------------------------
       sorteio section.
           move zero to ws-num_random
           accept ws-semente from time
           compute ws-num_random = function random(ws-semente) * 27 + 1
           .
       sorteio-exit.
           exit.


      *>------------------------------------------------------------------------
      *> Ordenar a colocação dos jogadores
      *>------------------------------------------------------------------------
       ordena section.
           move "trocou" to ws-controle
           perform until ws-controle <> "trocou"
               move 1 to ws-ind
               move "Ntrocou" to ws-controle
               perform until ws-ind > 4
                   if ws-pontos(ws-ind) < ws-pontos(ws-ind + 1) then
                       move ws-pontos(ws-ind + 1) to ws-auxpontos
                       move ws-jogador(ws-ind + 1) to ws-auxjogador
                       move ws-pontos(ws-ind) to ws-pontos(ws-ind + 1)
                       move ws-jogador(ws-ind) to ws-jogador(ws-ind + 1)
                       move ws-auxpontos to ws-pontos(ws-ind)
                       move ws-auxjogador to ws-jogador(ws-ind)
                       move "trocou" to ws-controle
                   end-if
                   add 1 to ws-ind
               end-perform
               move 1 to ws-ind
           end-perform
           .
       ordena-exit.
           exit.

      *>------------------------------------------------------------------------
      *> Mostrar na tela a colocação dos jogadores
      *>------------------------------------------------------------------------
       imprime section.
           move 1 to ws-ind
           move ws-jogador(ws-ind) to ws-aux-imprime-nome-1
           move ws-jogador(ws-ind + 1) to ws-aux-imprime-nome-2
           move ws-jogador(ws-ind + 2) to ws-aux-imprime-nome-3
           move ws-jogador(ws-ind + 3) to ws-aux-imprime-nome-4
           move ws-pontos(ws-ind) to ws-aux-imprime-pontos-1
           move ws-pontos(ws-ind + 1) to ws-aux-imprime-pontos-2
           move ws-pontos(ws-ind + 2) to ws-aux-imprime-pontos-3
           move ws-pontos(ws-ind + 3) to ws-aux-imprime-pontos-4
           move 1 to ws-ind
           display tela-colocacao
           display ws-aux-imprime-nome-1 line 04 col 16
           display ws-aux-imprime-pontos-1  line 05 col 15
           display ws-aux-imprime-nome-2 line 07 col 16
           display ws-aux-imprime-pontos-2 line 08 col 15
           display ws-aux-imprime-nome-3 line 10 col 16
           display ws-aux-imprime-pontos-3 line 11 col 15
           display ws-aux-imprime-nome-4 line 13 col 16
           display ws-aux-imprime-pontos-4 line 14 col 15
           accept tela-colocacao
           .
       imprime-exit.
           exit.

      *>------------------------------------------------------------------------
      *> Finalização Anormal
      *>------------------------------------------------------------------------
       finaliza-anormal section.
           display erase
           display ws-msn-erro
           stop run
           .
       finaliza-anormal-exit.
           exit.

      *>------------------------------------------------------------------------
      *> Finalização Normal
      *>------------------------------------------------------------------------
       finaliza section.
           stop run
           .
       finaliza-exit.
           exit.



