*** Settings ***
Documentation     Keywords e Variables para ações carrinho_keyword
Resource          ../support/base.robot
Resource          ../Keywords/login_keyword.robot
Resource          ../Keywords/produtos_keyword.robot

*** Keywords ***
POST /carrinhos
    ${headers}=    Create Dictionary    Authorization=${token_auth}

    # Cria o dicionário do produto
    ${produto}=    Create Dictionary    idProduto=${id_produto}    quantidade=1

    # Cria a lista e adiciona o produto
    @{produtos}=    Create List
    Append To List    ${produtos}    ${produto}

    # Cria o payload com a lista de produtos
    ${payload}=    Create Dictionary
    Set To Dictionary    ${payload}    produtos=${produtos}

    # Faz a requisição
    ${response}=    POST On Session    serverest    /carrinhos    json=${payload}    headers=${headers}
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}
    [Return]    ${response}
    
Criar Carrinho e Armazenar ID
    POST /carrinhos
    Validar Status Code "201"
    ${id_carrinho}=    Set Variable    ${response.json()["_id"]}
    Log To Console    ID do Carrinho Salvo: ${id_carrinho}
    Set Global Variable    ${id_carrinho}
    Set Global Variable    ${CARRINHO_ID}    ${id_carrinho}
    [Return]    ${id_carrinho}

DELETE /carrinhos/concluir-compra
    ${headers}=    Create Dictionary
    ...    Authorization=${token_auth}
    ${response}=    DELETE On Session    serverest    /carrinhos/concluir-compra    headers=${headers}
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}
    [Return]    ${response}
    
Concluir Compra e Validar
    DELETE /carrinhos/concluir-compra
    Validar Status Code "200"
    Should Contain    ${response.json()["message"]}    Registro excluído com sucesso

# Este endpoint não existe na API - removendo este keyword

DELETE /carrinhos sem produtos
    &{header}=    Create Dictionary
    ...    Authorization=${token_auth}
    ${response}=    DELETE On Session    serverest    /carrinhos/cancelar-compra    headers=${header}
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}
    [Return]    ${response}

GET /carrinhos
    [Arguments]    ${id}=${EMPTY}
    ${endpoint}=    Set Variable    /carrinhos
    ${endpoint}=    Set Variable If    "${id}" != "${EMPTY}"    /carrinhos/${id}    ${endpoint}
    ${response}=    GET On Session    serverest    ${endpoint}
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}
    [Return]    ${response}