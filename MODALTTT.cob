      *********************************************************
      * Autor: Marco Antônio Machado Junior.
      * Data: 08/11/2023.
      * Propósito: Transformar programa em módulo (ALTCONTT)
      *********************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. MODALTTT.

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
       77 WS-CONFIRM       PIC X VALUE SPACES.

       LINKAGE SECTION.
       01 LK-COM-AREA.
          03 LK-MENSAGEM   PIC X(20).

       PROCEDURE DIVISION USING LK-COM-AREA.
       MAIN PROCEDURE.
            DISPLAY '***** ALTERAÇÃO DE CONTATOS *****'
            SET EXIT-OK TO FALSE
            PERFORM P300-ALTERAR THRU P300-FIM UNTIL EXIT-OK
            PERFORM P900-FIM
            .

       P300-ALTERAR.
       SET EOF-OK TO FALSE.
       SET FS-OK TO TRUE.

       OPEN I-O CONTATOS

       IF FS-OK THEN
          DISPLAY 'INFORME O NUMERO DE IDENTIFICACAO DO CONTATO:'
          ACCEPT ID-CONTATO

          READ CONTATOS INTO WS-REGISTRO
                KEY IS ID-CONTATO
                  INVALID KEY 
                    DISPLAY 'CONTATO NÃO EXISTE'
                  NOT INVALID KEY
                    DISPLAY 'NOME ATUAL: ' WS-NM-CONTATO
                    DISPLAY 'INFORME O NOVO NOME:'
                    ACCEPT NM-CONTATO
                    DISPLAY 'TECLE:'
                            '<S> PARA CONFIRMAR OU <QUALQUER TECLA> PARA
                            CONTINUAR COM O ATUAL'
                    ACCEPT WS-CONFIRM
                    IF WS-CONFIRM EQUAL 'S' THEN 
                       REWRITE REG-CONTATOS
                       DISPLAY 'CONTATO ATUALIZADO COM SUCESSO'
                    ELSE
                       DISPLAY 'ALTERAÇÃO NÃO REALIZADA'
                    END-IF
          END-READ
        ELSE
          DISPLAY 'ERRO AO ABRIR O ARQUIVO DE CONTATOS'
          DISPLAY 'FILE STATUS:' WS-FS
        END-IF

       CLOSE CONTATOS

       DISPLAY 'TECLE: '
       DISPLAY ' QUALQUER <TECLA> PARA CONTINUAR OU <F> PARA FINALIZAR'
       ACCEPT WS-EXIT

       .
       P300-FIM.
       P900-FIM.

       GOBACK.
       END PROGRAM MODALTTT.
