      *********************************************************
      * Autor: Marco Antônio Machado Junior.
      * Data: 08/11/2023.
      * Propósito: MENU PARA CADASTRO DE CONTATOS
      *********************************************************

      
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MENUCNTT.
      
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
            DECIMAL-POINT IS COMMA.
           
            
       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01 WS-COM-AREA
          03 WS-COM-AREA  PIC X(20).
       77 WS-OPCAO PIC X.
      
       PROCEDURE DIVISION.
       MAIN PROCEDURE.

       MOVE SPACES TO WS-OPCAO
       DISPLAY 'ESCOLHA A SUA OPCAO:'
       ACCEPT WS-OPCAO

       EVALUATE WS-OPCAO
          WHEN '1'
            CALL 'C:\cobol\CADCONTT'
                  USING WS-COM-AREA
       WHEN '2'
            CALL 'C:\cobol\LISCONTT'
                  USING WS-COM-AREA
       WHEN '3'
            CALL 'C:\cobol\CONCONTT'
                  USING WS-COM-AREA
       WHEN '4'
            CALL 'C:\cobol\ALTCONTT'
                  USING WS-COM-AREA
       WHEN '5'
            CALL 'C:\cobol\DELCONTT'
                  USING WS-COM-AREA
       WHEN OTHER
            DISPLAY 'OPCAO INVALIDA'
       END EVALUATE.
          

       STOP RUN.
       END PROGRAM MENUCNTT.
