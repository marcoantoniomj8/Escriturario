      *********************************************************
      * Autor: Marco Antônio Machado Junior.
      * Data: 08/11/2023.
      * Propósito: Deletar contatos.
      *********************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. DELCONTT.

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

       PROCEDURE DIVISION.
       MAIN PROCEDURE.
            DISPLAY '***** EXCLUSÃO DE CONTATOS *****'
            SET EXIT-OK TO FALSE
            PERFORM P300-EXCLUIR THRU P300-FIM UNTIL EXIT-OK
            PERFORM P900-FIM
            .

       P300-EXCLUIR.
       SET EOF-OK TO FALSE.
       SET FS-OK TO TRUE.

       MOVE SPACES TO WS-CONFIRM.

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
                            ABORTAR'
                    ACCEPT WS-CONFIRM
                    IF WS-CONFIRM EQUAL 'S' THEN 
                       DELETE CONTATOS RECORD
                       DISPLAY 'CONTATO EXCLUIR COM SUCESSO'
                    ELSE
                       DISPLAY 'O CONTATO NÃO FOI EXCLUIDO'
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

       STOP RUN.
