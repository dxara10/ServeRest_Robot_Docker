*** Settings ***
Documentation     Keywords e Variables para ações carrinho_keyword
Resource          ../support/base.robot



*** Keywords ***

POST /carrinhos
    &{header}=    Create Dictionary    authorization=${token}
    &{payload}=   Create Dictionary    idPordutos=dtQPE0Yl8grLdBQG    quantidade=1
    ${response}=  POST On Session      serverest    /carrinhos    json=${payload}    headers=${header}
    Status Should Be                  201    ${response.status_code}
    Log To Console                   Response: ${response.content}





DELETE /carrinhos
    &{header}=    Create Dictionary
    ...    Authorization=${token}        #tornar o token dinâmico
    ${response}    DELETE On Session    serverest    /carrinhos    headers=${header}
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}

adição de produto ID_PRODUTO ao carrinho ID_CARRINHO
    [Arguments]    ${ID_PRODUTO}    ${ID_CARRINHO}
    &{header}=    Create Dictionary
    ...    Authorization=${token}        #tornar o token dinâmico
    &{payload}=    Create Dictionary    
    ...    idProduto=${ID_PRODUTO}    
    ...    quantidade=1
    ${response}    POST On Session    serverest    /carrinhos/${ID_CARRINHO}/produtos    data=${payload}    headers=${header}
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}

DELETE /carrinhos sem produtos
    &{header}=    Create Dictionary
    ...    Authorization=${token}        #tornar o token dinâmico
    ${response}    DELETE On Session    serverest    /carrinhos/sem_produtos    headers=${header}
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}

GET /carrinhos
    ${response}    GET On Session    serverest    /carrinhos
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}

GET /carrinhos/${ID_CARRINHO}
    [Arguments]    ${ID_CARRINHO}
    ${response}    GET On Session    serverest    /carrinhos/${ID_CARRINHO}
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}
   