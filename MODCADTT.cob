      *********************************************************
      * Autor: Marco Antônio Machado Junior.
      * Data: 08/11/2023.
      * Propósito: Transformar de programa para módulo (CADCONTT)
      *********************************************************


       IDENTIFICATION DIVISION.
       PROGRAM-ID. MODCADTT.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
            DECIMAL-POINT IS COMMA.
            INPUT-OUTPUT SECTION.
            FILE-CONTROL.
                SELECT CONTATOS ASSIGN TO 
                'C:\cobol\CONTATOS.DAT'
                ORGANIZATION IS INDEXED.
                ACCESS MODE IS RANDOM.
                RECORD KEY IS ID-CONTATO.
                FILE STATUS IS WS-FS.

       DATA DIVISION.
       FILE SECTION.
       FD CONTATOS.
          COPY FD_CONTT. 

       WORKING-STORAGE SECTION.

       01 REGISTRO         PIC X(22) VALUE SPACES.
       01 FILLER REDEFINES REGISTRO
          03 WS-ID-CONTATO PIC 9(02).
          03 WS-NM-CONTATO PIC X(20).
       77 WS-FS            PIC 99.
          88 FS-OK         VALUE 0.
       77 WS-EOF           PIC X.
          88 EOF-OK        VALUE 'S' FALSE 'N'.
       77 WS-EXIT          PIC X.
          88 EXIT-OK       VALUE 'F' FALSE 'N'.

       LINKAGE SECTION.
       01 LK-COM-AREA.
          03 LK-MENSAGEM   PIC X(20).

       PROCEDURE DIVISION USING LK-COM-AREA.
       MAIN PROCEDURE.
            DISPLAY '***** CADASTRO DE CONTATOS *****'
            SET EXIT-OK TO FALSE
            PERFORM P300-CADASTRA THRU P300-FIM UNTIL EXIT-OK
            PERFORM P900-FIM
            .

       P300-CADASTRA.
       SET EOF-OK TO FALSE.
       SET FS-OK TO TRUE.

       DISPLAY 'PARA REGISTRAR UM CONTATO, INFORME: '
       DISPLAY 'UM NUMERO PARA A IDENTIFICACAO E TECLE <ENTER>: '
       ACCEPT WS-ID-CONTATO
       DISPLAY 'UM NOME PARA O CONTATO E TECLE ENTER: '
       ACCEPT WS-NM-CONTATO

       OPEN I-O CONTATOS

       IF WS-FS IQUAL 35 THEN
          OPEN INPUT CONTATOS
       END-IF

       IF FS-OK THEN
          MOVE WS-ID-CONTATO TO ID-CONTATO
          MOVE WS-NM-CONTATO TO NM-CONTATO

          WRITE REG-CONTATOS
             INVALID KEY
                DISPLAY 'CONTATO JÁ CADASTRADO'
             NOT INVALID KEY
                DISPLAY 'CONTATO CADASTRADO COM SUCESSO'
          END-WRITE
       ELSE
          DISPLAY 'ERRO AO ABRIR O ARQUIVO DE CONTATOS'
          DISPLAY 'FILE STATUS: ' WS-FS
       END-IF

       CLOSE CONTATOS.

       DISPLAY 
       'TECLE:  '
       'QUALQUER TECLA PARA CONTINUAR, OU <F> PARA FINALIZAR.'
       ACCEPT WS-EXIT
       .
       P300-FIM.
       P900-FIM.

       GOBACK.
       END PROGRAM MODCADTT.
