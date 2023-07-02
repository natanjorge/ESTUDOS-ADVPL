#Include "Protheus.ch"
#Include "MsObject.ch"

 /*/{Protheus.doc} ParamTest
    Definição de Parambox
    @type  User Function
    @author Natan Jorge
    @since 24/06/2023
    /*/
User Function ParamTest()

    Local aArea := GetArea()
    Local lContinua := .F.

	Private oParamBox
    Private cNumIni       := ""
    Private cNumFim       := ""
    Private dDatIni       := ""
    Private dDatFim       := ""
    Private cNotaFIni     := ""
    Private cNotaFFin     := ""
    Private lOrdemVai     := .T.

    //! Setar o nome da função a que o objeto será atribuído o oParambox
    oParamBox := IpParamBoxObject():newIpParamBoxObject("ParamTest")

    //! Título do oParambox
	oParamBox:setTitle("Testes oParambox")

    //! Função para adicionar os parâmetros no objeto oParambox
	addParams(@oParamBox)

    //! Se mostrar a Parambox
    If oParamBox:show()

        //! Se o valor selecionado for igual a C (com ordem de separação)
        if oParamBox:getValue("cOrdemRec") == "C"
            lOrdemVai := .T.
        elseif oParamBox:getValue("cOrdemRec") == "S"
            lOrdemVai := .F.
        endif

        cNumIni       := oParamBox:getValue("cOrdIni")
        cNumFim       := oParamBox:getValue("cOrdFim")
        dDatIni       := oParamBox:getValue("dEmiIni")
        dDatFim       := oParamBox:getValue("dEmiFim")
        
        lContinua := .T.
    endif

    RestArea(aArea)

Return 

Static Function addParams(oParamBox)

    Local oParam := Nil
    Local aCombo := {"C=Com Ord.Separação", "S=Sem Ord.Separação"}

    //!----------------------------------------------------------
    //!              Utilizando combo com oParam                |
    //!----------------------------------------------------------
    
    //! Criando um novo parâmetro no objeto   - Variável,   modelo,  Mensagem do parâmetro, Tipo, Tamanho
    oParam := IpParamObject():newIpParamObject("cOrdemRec", "combo", "Ordem de Sep.",       "C",  80)
    
    //! Array que receberá as opções da combo
    oParam:setValues(aCombo)

    //! É um campo obrigatório? 
    oParam:setRequired(.T.)
    oParamBox:addParam(oParam)

    //*--------------------------------------------------------------------------------------------------------------------

    //!----------------------------------------------------------
    //!              Utilizando campo com oParam                |
    //!----------------------------------------------------------
    
    //! Criando um novo parâmetro no objeto   - Variável,   modelo, Mensagem do parâmetro, Tipo, Tamanho, Tamanho do campo 
	oParam := IpParamObject():newIpParamObject("cOrdIni",  "get",   "Ordem Sep De",        "C",  60,      TamSX3("CB7_ORDSEP")[01])
	
    //! Lupa de consulta padrão na CB7
    oParam:setF3("CB7") 

    //! Adicionando no oParambox
    oParamBox:addParam(oParam)	

	oParam := IpParamObject():newIpParamObject("cOrdFim", "get", "Ordem Sep Até", "C", 60, TamSX3("CB7_ORDSEP")[01])
	oParam:setF3("CB7")
    oParamBox:addParam(oParam)	

    //*--------------------------------------------------------------------------------------------------------------------

    //!----------------------------------------------------------
    //!              Utilizando data com oParam                 |
    //!----------------------------------------------------------
    
    //! Criando um novo parâmetro no objeto   - Variável,   modelo, Mensagem do parâmetro, Tipo, Tamanho
	oParam := IpParamObject():newIpParamObject("dEmiIni",   "get",  "Dt Emissao de",       "D",  60)
    
    //! Adicionando no oParambox
    oParamBox:addParam(oParam)

	oParam := IpParamObject():newIpParamObject("dEmiFim", "get", "Dt Emissao Até", "D", 60)
    oParamBox:addParam(oParam)	

Return






    //!----------------------------------------------------------
    //!              Utilizando com Parambox                    |
    //!----------------------------------------------------------

 /*/{Protheus.doc} xParamBox
    (long_description)
    @type  User Function
    @author Natan Jorge
    @since 24/06/2023
    @see https://www.blacktdn.com.br/2012/05/para-quem-precisar-desenvolver-uma.html
    /*/
User Function xParamBox()
    Local aRet := {}
    Local aParamBox := {}
    Local aCombo := {"Janeiro","Fevereiro","Março","Abril","Maio","Junho","Julho","Agosto","Setembro","Outubro","Novembro","Dezembro"}
    Local i := 0

    Private cCadastro := "xParambox"

    // --------------------------------------------------------------
    // Abaixo está a montagem do vetor que será passado para a função
    // --------------------------------------------------------------

    aAdd(aParamBox,{1,"Produto",Space(15),"","","SB1","",0,.F.}) // Tipo caractere

    aAdd(aParamBox,{1,"Valor",0,"@E 9,999.99","mv_par02>0","","",20,.F.}) // Tipo numérico

    aAdd(aParamBox,{1,"Data"  ,Ctod(Space(8)),"","","","",50,.F.}) // Tipo data
    // Tipo 1 -> MsGet()
    //           [2]-Descricao
    //           [3]-String contendo o inicializador do campo
    //           [4]-String contendo a Picture do campo
    //           [5]-String contendo a validacao
    //           [6]-Consulta F3
    //           [7]-String contendo a validacao When
    //           [8]-Tamanho do MsGet
    //           [9]-Flag .T./.F. Parametro Obrigatorio ?

    aAdd(aParamBox,{2,"Informe o mês",1,aCombo,50,"",.F.})
    // Tipo 2 -> Combo
    //           [2]-Descricao
    //           [3]-Numerico contendo a opcao inicial do combo
    //           [4]-Array contendo as opcoes do Combo
    //           [5]-Tamanho do Combo
    //           [6]-Validacao
    //           [7]-Flag .T./.F. Parametro Obrigatorio ?
    // Cuidado, há um problema nesta opção quando selecionado a 1ª opção.

    aAdd(aParamBox,{3,"Mostra deletados",1,{"Sim","Não"},50,"",.F.})
    // Tipo 3 -> Radio
    //           [2]-Descricao
    //           [3]-Numerico contendo a opcao inicial do Radio
    //           [4]-Array contendo as opcoes do Radio
    //           [5]-Tamanho do Radio
    //           [6]-Validacao
    //           [7]-Flag .T./.F. Parametro Obrigatorio ?

    aAdd(aParamBox,{4,"Marca todos ?",.F.,"Marque todos se necessário for.",90,"",.F.})
    // Tipo 4 -> Say + CheckBox
    //           [2]-Descricao
    //           [3]-Indicador Logico contendo o inicial do Check
    //           [4]-Texto do CheckBox
    //           [5]-Tamanho do Radio
    //           [6]-Validacao
    //           [7]-Flag .T./.F. Parametro Obrigatorio ?

    aAdd(aParamBox,{5,"Marca todos ?",.F.,50,"",.F.})
    // Tipo 5 -> Somente CheckBox
    //           [2]-Descricao
    //           [3]-Indicador Logico contendo o inicial do Check
    //           [4]-Tamanho do Radio
    //           [5]-Validacao
    //           [6]-Flag .T./.F. Parametro Obrigatorio ?

    aAdd(aParamBox,{6,"Buscar arquivo",Space(50),"","","",50,.F.,"Todos os arquivos (*.*) |*.*"})
    // Tipo 6 -> File
    //           [2]-Descricao
    //           [3]-String contendo o inicializador do campo
    //           [4]-String contendo a Picture do campo
    //           [5]-String contendo a validacao
    //           [6]-String contendo a validacao When
    //           [7]-Tamanho do MsGet
    //           [8]-Flag .T./.F. Parametro Obrigatorio ?
    //           [9]-Texto contendo os tipos de arquivo, exemplo: "Arquivos .CSV |*.CSV"
    //           [10]-Diretorio inicial do cGetFile
    //           [11]-Número relativo a visualização, podendo ser por diretório ou por arquivo (0,1,2,4,8,16,32,64,128)

    aAdd(aParamBox,{7,"Monte o filtro","SX5","X5_FILIAL==xFilial('SX5')"})
    // Tipo 7 -> Montagem de expressao de filtro
    //           [2]-Descricao
    //           [3]-Alias da tabela
    //           [4]-Filtro inicial

    aAdd(aParamBox,{8,"Digite a senha",Space(15),"","","","",80,.F.})
    // Tipo 8 -> MsGet Password
    //           [2]-Descricao
    //           [3]-String contendo o inicializador do campo
    //           [4]-String contendo a Picture do campo
    //           [5]-String contendo a validacao
    //           [6]-Consulta F3
    //           [7]-String contendo a validacao When
    //           [8]-Tamanho do MsGet
    //           [9]-Flag .T./.F. Parametro Obrigatorio ?

    aAdd(aParamBox,{9,"Texto aleatório, apenas demonstrativo.",150,7,.T.})
    // Tipo 9 -> Somente uma mensagem, formato de um título
    //           [2]-Texto descritivo
    //           [3]-Largura do texto
    //           [4]-Altura do texto
    //           [5]-Valor lógico sendo: .T. => fonte tipo VERDANA e .F. => fonte tipo ARIAL

    aAdd(aParamBox,{10,"Cliente",Space(6),"SA1",40,"C",6,".T."})
    // Tipo 10 -> Range de busca
    //            [2] = Título
    //            [3] = Inicializador padrão
    //            [4] = Consulta F3
    //            [5] = Tamanho do GET
    //            [6] = Tipo do dado, somente (C=caractere e D=data)
    //            [7] = Tamanho do espaço
    //            [8] = Condição When

    aAdd(aParamBox,{11,"Informe o motivo","",".T.",".T.",.T.})
    // Tipo 11 -> MultiGet (Memo)
    //            [2] = Descrição
    //            [3] = Inicializador padrão
    //            [4] = Validação
    //            [5] = When
    //            [6] = Campo com preenchimento obrigatório .T.=Sim .F.=Não (incluir a validação na função ParamOk)

    // Parametros da função Parambox()
    // -------------------------------
    // 1 - < aParametros > - Vetor com as configurações
    // 2 - < cTitle >      - Título da janela
    // 3 - < aRet >        - Vetor passador por referencia que contém o retorno dos parâmetros
    // 4 - < bOk >         - Code block para validar o botão Ok
    // 5 - < aButtons >    - Vetor com mais botões além dos botões de Ok e Cancel
    // 6 - < lCentered >   - Centralizar a janela
    // 7 - < nPosX >       - Se não centralizar janela coordenada X para início
    // 8 - < nPosY >       - Se não centralizar janela coordenada Y para início
    // 9 - < oDlgWizard >  - Utiliza o objeto da janela ativa
    //10 - < cLoad >       - Nome do perfil se caso for carregar
    //11 - < lCanSave >    - Salvar os dados informados nos parâmetros por perfil
    //12 - < lUserSave >   - Configuração por usuário

    // Caso alguns parâmetros para a função não seja passada será considerado DEFAULT as seguintes abaixo:
    // DEFAULT bOk   := {|| (.T.)}
    // DEFAULT aButtons := {}
    // DEFAULT lCentered := .T.
    // DEFAULT nPosX  := 0
    // DEFAULT nPosY  := 0
    // DEFAULT cLoad     := ProcName(1)
    // DEFAULT lCanSave := .T.
    // DEFAULT lUserSave := .F.

    If ParamBox(aParamBox,"Teste Parâmetros...",@aRet)
    For i:=1 To Len(aRet)
        MsgInfo(aRet[i],"Opção escolhida")
    Next
    Endif

Return
