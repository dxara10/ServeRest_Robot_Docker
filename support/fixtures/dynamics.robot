*** Settings ***
Documentation     Keywords e variaveis para geração de Massa de Dados
Library           FakerLibrary
Library           RequestsLibrary
Library           Collections




*** Keywords ***
Criar Dados Usuario Aleatorio Válido
    ${nome_aleatorio}=    FakerLibrary.Name
    ${email_aleatorio}=    FakerLibrary.Email
    ${senha_aleatoria}=    FakerLibrary.Password    length=8    special_chars=False
    ${payload_aleatorio}=    Create Dictionary    nome=${nome_aleatorio}    email=${email_aleatorio}    password=${senha_aleatoria}    administrador=true
    Log To Console    Usuário criado: ${payload_aleatorio}
    Set Global Variable    ${DYNAMIC_EMAIL}    ${email_aleatorio}
    Set Global Variable    ${DYNAMIC_PASSWORD}    ${senha_aleatoria}
    [Return]    ${payload_aleatorio}

    

Criar Dados carrinho Válido
    ${ID_PRODUTO} =    FakerLibrary.Word
    ${ID_CARRINHO} =    FakerLibrary.Word
    ${payload} =    Create Dictionary    idProduto=${ID_PRODUTO}    quantidade=1
    Log To Console         ${payload}
    Set Global Variable    ${payload}
    
Criar Dados Produto Aleatorio
    ${nome_produto}=    FakerLibrary.Word
    ${descricao}=    FakerLibrary.Sentence    nb_words=10
    ${preco}=    Evaluate    random.randint(10, 5000)
    ${quantidade}=    Evaluate    random.randint(1, 100)
    ${payload}=    Create Dictionary
    ...    nome=Produto ${nome_produto}
    ...    preco=${preco}
    ...    descricao=${descricao}
    ...    quantidade=${quantidade}
    Log To Console    Produto criado: ${payload}
    [Return]    ${payload}
    
POST /produtos_dinamicos
    ${headers}=    Create Dictionary
    ...    Authorization=${token_auth}
    ${payload}=    Criar Dados Produto Aleatorio
    ${response}=    POST On Session    serverest    /produtos    json=${payload}    headers=${headers}
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}
    [Return]    ${response}
