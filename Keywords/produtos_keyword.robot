*** Settings ***
Documentation     Keywords e Variables para ações produtos_keyword
Resource          ../support/base.robot
Resource          ../Keywords/login_keyword.robot

*** Keywords ***
POST /produtos
    ${headers}=    Create Dictionary
    ...    Authorization=${token_auth}
    &{payload}=    Create Dictionary    
    ...    nome=Notebook Gamer DELL ULTRA PROMAX    
    ...    preco=2000
    ...    descricao=Notebook Gamer com 16GB de RAM e 512GB SSD
    ...    quantidade=100
    ${response}=    POST On Session    serverest    /produtos    json=${payload}    headers=${headers}
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}
    [Return]    ${response}

DELETE /produtos
    [Arguments]    ${produto_id}=${PRODUTO_ID}
    ${headers}=    Create Dictionary
    ...    Authorization=${token_auth}
    ${response}=    DELETE On Session    serverest    /produtos/${produto_id}    headers=${headers}
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}
    [Return]    ${response}

Validar Ter Criado produto
    Should Be Equal    ${response.json()["message"]}    Cadastro realizado com sucesso
    Should Not Be Empty    ${response.json()["_id"]}

Criar produto e Armazenar ID
    POST /produtos
    Validar Ter Criado produto
    ${id_produto}=    Set Variable    ${response.json()["_id"]}
    Log To Console    ID do Produto Salvo: ${id_produto}
    Set Global Variable    ${id_produto}
    [Return]    ${id_produto}
    
Criar Produto Dinamico
    POST /produtos_dinamicos
    Validar Status Code "201"
    ${id_produto}=    Set Variable    ${response.json()["_id"]}
    Log To Console    ID do Produto Dinâmico Salvo: ${id_produto}
    Set Global Variable    ${id_produto}
    [Return]    ${id_produto}

PUT /produtos
    [Arguments]    ${produto_id}=${PRODUTO_ID}
    ${headers}=    Create Dictionary
    ...    Authorization=${token_auth}
    &{payload}=    Create Dictionary    
    ...    nome=Notebook Gamer DELL Atualizado 4x    
    ...    preco=2500
    ...    descricao=Notebook Gamer com 16GB de RAM e 1TB SSD
    ...    quantidade=5
    ${response}=    PUT On Session    serverest    /produtos/${produto_id}    json=${payload}    headers=${headers}
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}
    [Return]    ${response}

GET /produtos
    ${response}=    GET On Session    serverest    /produtos
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}
    [Return]    ${response}

GET /produtosEspecificos   
    [Arguments]    ${id}
    ${response}=    GET On Session    serverest    /produtos/${id}
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}
    [Return]    ${response}

POST /produtosSemToken
    &{payload}=    Create Dictionary    
    ...    nome=Notebook Gamer SuperPRO    
    ...    preco=2000
    ...    descricao=Notebook Gamer com 16GB de RAM e 512GB SSD
    ...    quantidade=10
    ${response}=    POST On Session    serverest    /produtos    json=${payload}    expected_status=any
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}
    [Return]    ${response}