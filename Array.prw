#INCLUDE 'TOTVS.CH'

//! USOS DE ARRAY EM ADVPL

//! AAdd    - Inclui um elemento no array e ao elemento, do array rec�m-criado, � atribuido o valor especificado por par�metro.
//! AClone  - Duplica um array (estrutura e elementos).
//! ACopy   - Copia elementos de um array para outro.
//! ADel    - Elimina um elemento do array e "arrasta" os demais para tr�s tornando nulo o �ltimo elemento.
//! AFill   - Preenche um array com um �nico valor de qualquer tipo de dados (inclusive array�s, blocos de c�digo ou nulo) na faixa especificada.
//! AIns    - Inclui um elemento nulo na posi��o definida e 'empurra' os demais para frente descartando o �ltimo elemento.
//! AScan   - Percorre um array procurando por um valor especificado. Pode ser especificado um valor a ser buscado, ou pode ser informada uma condi��o de busca atrav�s de um bloco de c�digo.
//! ASize   - Aumenta ou diminui um array a um tamanho especificado
//! ASort   - Coloca em ordem tudo ou parte de um array.
//! ATail   - Retorna o �ltimo elemento do array

//* ******************************************************************************************************************************************************************************************

//! NO FINAL EST�O EXEMPLOS DE ARRAY (Ap�s ATail)

//* ******************************************************************************************************************************************************************************************


User Function ArrayTestes()
    
    Local aNumeros := {10, 9, 8, 7, 6, 5, 4, 3, 2, 1}
    Local aLetras  := {'Natan', 'Tiagaum', 'Ste', 'Dani', 'Giu', 'Ighor'}
    Local nCont    := 0

    FwAlertInfo(STR(aNumeros[2])) //! Print do segundo valor do array, ou seja, "9"

    FwAlertInfo(aLetras[1]) //! Print do primeiro valor do array, ou seja, "Natan"

    For nCont := 1 to LEN(aLetras)
        FwAlertInfo(ALLTRIM(aLetras[nCont]) + ' e ' + ALLTRIM(STR(aNumeros[nCont]))) //! Print dos nomes e n�meros 
    Next

Return


User Function ArrayAClone()
    
    //! FUN��O AClone  - Duplica um array (estrutura e elementos).

    Local aArmazena := {'Natan', 'Tiagaum', 'Ste', 'Dani', 'Giu', 'Ighor'}    
    Local aRecebe   := {}
    Local cMsg      := ''
    Local nCont     := 0

    aRecebe := AClone(aArmazena)

    For nCont := 1 to LEN(aArmazena)
        cMsg+=('Array Armazena: '+ CRLF + (aArmazena[nCont]) + CRLF + CRLF + 'Array Recebe: ' + CRLF + (aRecebe[nCont]))  + CRLF + CRLF //! Resultado: 2, o nome 'Tiagaum' aparece duas vezes no array
    Next

    FwAlertInfo(cMsg) //! Print dos nomes 

Return


User Function ArrayACopy()
    
    //! FUN��O ACopy - Copia elementos de um array para outro.

    Local aNumeros := {10, 9, 8}
    Local aRecebe  := {, , }
    Local cMsg     := ''

    ACopy(aNumeros, aRecebe)

    cMsg += "C�pia[1] = " + cValToChar(aRecebe[1]) + CRLF
    cMsg += "C�pia[2] = " + cValToChar(aRecebe[2]) + CRLF  
    cMsg += "C�pia[3] = " + cValToChar(aRecebe[3]) + CRLF

    FwAlertInfo(cMsg) //! Print dos nomes 

Return


User Function ArrayADel()
    
    //! FUN��O ADel - Elimina um elemento do array e "arrasta" os demais para tr�s tornando nulo o �ltimo elemento.

    Local aNumeros := {10, 9, 8, 7, 5}
    Local cMsg     := ''
    Local nCont    := 0


    ADel(aNumeros, 3) //!O n�mero 8 (que est� na terceira posi��o) � eliminado

    for nCont:= 1 to LEN(aNumeros)
        cMsg += "aNumeros ["+cValToChar(nCont)+"] = " + cValToChar(aNumeros[nCont]) + CRLF
    next

    FwAlertInfo(cMsg) 

Return


User Function ArrayAFillASize()
    
    //! FUN��O AFill   - Preenche um array com um �nico valor de qualquer tipo de dados (inclusive array�s, blocos de c�digo ou nulo) na faixa especificada.
    //! FUN��O ASize   - Aumenta ou diminui um array a um tamanho especificado

    Local aArmazena := {}
    Local cMsg     := ''
    Local nCont    := 0

    ASize(aArmazena, 8 )
    AFill(aArmazena, "TESTE")
    AFill(aArmazena, "OK", 2, 6) //! IMPRIMIR� TESTE NA PRIMEIRA E �LTIMA POSI��O (2X) E OK (6X) ENTRE AS PALABRAS TESTE

    for nCont:= 1 to LEN(aArmazena)
        cMsg += "Exemplo ["+cValToChar(nCont)+"] = " + cValToChar(aArmazena[nCont]) + CRLF
    next

    FwAlertInfo(cMsg) 

Return


User Function ArrayAIns()
    
    ///! AIns - Inclui um elemento nulo na posi��o definida e 'empurra' os demais para frente descartando o �ltimo elemento.

    Local aArmazena := { 1, 2, { 11, 22, 33 }, 4, 5 }
    Local cMsg      := ''
    Local nCont     := 0

    AIns(aArmazena[3], 2 )
    AIns(aArmazena, 2 )
    AIns(aArmazena, 5 )

    for nCont:= 1 to LEN(aArmazena)
        cMsg += "Exemplo ["+cValToChar(nCont)+"] = " + cValToChar(aArmazena[nCont]) + CRLF
    next

    FwAlertInfo(cMsg) 

Return


User Function ArrayAscan()
    
    //! FUN��O ASCAN
    Local aNumeros := {10, 9, 8, 7, 6, 5, 4, 3, 2, 1}
    Local aLetras  := {'Natan', 'Tiagaum', 'Ste', 'Dani', 'Giu', 'Ighor', 'Tiagaum'}

    FwAlertInfo(STR(ASCAN(aNumeros, 7))) //! Resultado: 4, que � a posi��o do n�mero 7

    FwAlertInfo(STR(ASCAN(aLetras, 'Tiagaum'))) //! Resultado: 2, o nome 'Tiagaum' aparece duas vezes no array

Return


User Function ArrayASort()
    
    //! FUN��O ASort   - Coloca em ordem tudo ou parte de um array.

    Local aNumeros := {8,11,1,28,2,32,15,10,55}
    Local nCont    := 0
    Local cMsg     := ''

    ASort(aNumeros)

    for nCont:= 1 to LEN(aNumeros)
        cMsg += "Exemplo ["+cValToChar(nCont)+"] = " + cValToChar(aNumeros[nCont]) + CRLF
    next

    FwAlertInfo(cMsg) 
Return


User Function ArrayATail()
    
    //! FUN��O ATail   - Retorna o �ltimo elemento do array

    Local aNumeros := {8,11,1,28,2,32,15,10,55}


    ATail(aNumeros)

    FwAlertInfo(STR(ATail(aNumeros))) //! IMPRIMIR� 55, O �LTIMO VALOR DO ARRAY
Return


User Function MBid_EX1()
    
    Local aC    := {}
    Local nCont := 0
    Local cMsg  := 'PRINT DO ARRAY 3,1 ' + CRLF + CRLF
        
    //! Este array foi definido com 3 linhas e apenas uma coluna. aC � um array 3,1
    //*                 IMPRESS�O
    AADD(aC, 1)    //*    | 1 |              
    AADD(aC, 9)    //*    | 9 | 
    AADD(aC, 3)    //*    | 3 | 
    

    For nCont := 1 to LEN(aC)
        cMsg += (STR(aC[nCont])) + CRLF
    Next

    FwAlertInfo(cMsg)

Return


User Function MatrizBidimensional()
    
    Local aB := ARRAY(4,3)
    Local nCont          := 0, nCont2 := 0, nI := 0
    Local cMsg           := ''

    //! Este array foi definido com 4 linhas e 3 COLUNAS. aB � um array 4,3
    //*                          IMPRESS�O    
    aB[1][1] := 10    //*    | 10   20   40 |
    aB[1][2] := 20    //*    | 15   35   42 | 
    aB[1][3] := 40    //*    | 53   25   37 | 
    aB[2][1] := 15    //*    | 12   91   33 |
    aB[2][2] := 35
    aB[2][3] := 42
    aB[3][1] := 53
    aB[3][2] := 25
    aB[3][3] := 37
    aB[4][1] := 12
    aB[4][2] := 91
    aB[4][3] := 33

    For nCont := 1 to 4
        For nCont2 := 1 to 3
            cMsg+=(STR(aB[nCont][nCont2]))
            nI ++       //! Para printar as 3 colunas e 4 linhas
            if nI == 3
                cMsg+= CRLF + CRLF
                nI:= 0
            endif
        Next
    Next

    FwAlertInfo(cMsg)

Return


User Function MatrizMultidimensional()
    
    Local aDados := {}
    Local nCont  := 0 

    //* INDICES      1        2      3             4    
    AADD(aDados, {'Natan',   24,'13/06/1998', 'S�o Paulo'})
    AADD(aDados, {'Tiagaum', 18,'25/12/2005', 'Araras'})
    AADD(aDados, {'Dani',    40,'06/01/1983', 'Disney'})
    AADD(aDados, {'Ste',     22,'16/05/2001', 'Limeira'})
    AADD(aDados, {'Ighor',   18,'13/06/2005', 'S�o Paulo'})
    AADD(aDados, {'Giu',     59,'06/02/1964', 'S�o Paulo'})

    For nCont := 1 to LEN(aDados)

        FwAlertInfo('NOME: '       + aDados[nCont, 1] + CRLF +;
                    'IDADE: '      + STR(aDados[nCont, 2]) + CRLF +;
                    'NASCIMENTO: ' + aDados[nCont, 3] + CRLF +;
                    'CIDADE: '     + aDados[nCont, 4] )
    Next
Return
