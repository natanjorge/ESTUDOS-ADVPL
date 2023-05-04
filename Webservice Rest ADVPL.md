<h1 align="center">
ESTUDOS ADVPL - Webservice Rest
<img src="https://user-images.githubusercontent.com/115876464/236182574-caa40b48-8bba-4a9f-858a-d933cc7c72d1.png" alt="Image" height="60"/>
</h1>

# Índice 
* [Configurar Server](#Server)
* [Desenvolvendo a Classe Rest](#Classe)

# Server

<h3 align="left">
Realizar uma cópia da pasta appServer do Protheus (que se encontra dentro de "\Protheus\bin") e renomear a pasta copiada, deixei como "serverRest".
</h3>

![image](https://user-images.githubusercontent.com/115876464/236202274-a2005d51-401f-48c4-aa7b-fea804456ab4.png)

<h3 align="left">
Alterei os dados do "appserver.ini" da pasta "serverRest" como mostra imagem abaixo.
</h3>

![image](https://user-images.githubusercontent.com/115876464/236204141-9de11448-e512-4f8b-8032-e76a15c4380a.png)


<h3 align="left">
Adicionei alguns itens no "appserver.ini" da pasta "serverRest".
</h3>

[HTTPV11]<br>
Enable=1 <br>
Sockets=HTTPREST<br>

[HTTPREST]<br>
Port=8084<br>
IPsBind=<br>
URIs=HTTPURI<br>
Security=0<br>

[HTTPURI]<br>
URL=/rest<br>
PrepareIn=ALL<br>
Instances=1,1<br>
;CORSEnable=1<br>
AllowOrigin=*<br>

[HTTPJOB]<br>
MAIN=HTTP_START<br>
ENVIRONMENT=Environment<br>

[ONSTART]<br>
jobs=HTTPJOB<br>
RefreshRate=30<br>

[GENERAL]<br>
MAXSTRINGSIZE=10<br><br>

<h3 align="left">
Segue imagem de como o "appserver.ini" ficou após a inserção dos itens.</h3> <br>

![image](https://user-images.githubusercontent.com/115876464/236206886-3c5b1cd9-b4aa-4060-aa99-59a57d8ec9c8.png)

# Classe

Desenvolvendo a classe Rest ADVPL <br>

<h1 align="left">
Alterei os dados do "appserver.ini" da pasta "serverRest" como mostra imagem abaixo.
</h1>

Verbos existentes:  <br>

POST – Realiza inclusões de registros. <br>
PUT – Realiza alterações de registros. <br>
GET – Realiza o retorno de registros. <br>
DELETE – Realiza exclusões de registros. <br> <br>

    #include 'Totvs.ch'
    #include 'Restful.ch'
    #include 'Topconn.ch'

    //? Criando a rota de produtos
    WSRESTFUL Produtos DESCRIPTION 'API de produtos' 

        //? Método GET sem parâmetros na URL
        WSMETHOD GET DESCRIPTION 'Listar produtos' PATH '/'
    END WSRESTFUL

    //? Execução da rota
    WSMETHOD GET WSSERVICE Produtos

    Local cAlias := GetNextAlias()
    Local oJson := JSONObject():New()
    Local cQuery := ''

    cQuery := 'Select * from ' + RetSqlName('SB1') + " where D_E_L_E_T_= ' '"

    TCQUERY cQuery ALIAS (cAlias) NEW

    oJson['Produtos'] := {}

    (cAlias)->(DBGOTOP())

    while (cAlias)->(!EOF())
    
        AADD( oJson['Produtos'], JSONObject():New())
        oJson['Produtos'][len(oJson['Produtos'])]["Cod"]       := (cAlias)->(B1_COD)
        oJson['Produtos'][len(oJson['Produtos'])]["Descricao"] := (cAlias)->(B1_DESC)
        oJson['Produtos'][len(oJson['Produtos'])]["Preco"]     := (cAlias)->(B1_PRV1)
        oJson['Produtos'][len(oJson['Produtos'])]["UN"]        := (cAlias)->(B1_UM)

        (cAlias)->(DBSKIP())

    enddo

    ConOut(oJson:toJson())

    Self:SetContentType('application/json')
    Self:SetResponse(oJson)
    
    (cAlias)->(DBCLOSEAREA())

Return .T.
