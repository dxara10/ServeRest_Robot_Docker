*** Settings ***
Documentation     Keywords e Variables para ações produtos_keyword
Resource          ../support/base.robot



*** Keywords ***
POST /produtos
    &{header}=    Create Dictionary
    ...    Authorization=${token}        #tornar o token dinâmico
    &{payload}=    Create Dictionary    
    ...    nome=Notebook Gamer Super    
    ...    preco=2000
    ...    descricao=Notebook Gamer com 16GB de RAM e 512GB SSD
    ...    quantidade=100
    ${response}    POST On Session    serverest    /produtos    data=${payload}    headers=${header}
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}

DELETE /produtos
    &{header}=    Create Dictionary
    ...    Authorization=${token}
    ${response}    DELETE On Session    serverest    /produtos/18W2cWZt7UPdiBx2    headers=${header}   # Substitua '18W2cWZt7UPdiBx2' por um ID dinâmico
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}

PUT /produtos
    &{header}=    Create Dictionary
    ...    Authorization=${token}
    &{payload}=    Create Dictionary    
    ...    nome=Notebook Gamer DELL Atualizado    
    ...    preco=2500
    ...    descricao=Notebook Gamer com 16GB de RAM e 1TB SSD
    ...    quantidade=5
    ${response}    PUT On Session    serverest    /produtos/18W2cWZt7UPdiBx2    data=${payload}    headers=${header}   # Substitua '18W2cWZt7UPdiBx2' por um ID dinâmico
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}

GET /produtos
    &{header}=    Create Dictionary
    ...    Authorization=${token}
    ${response}    GET On Session    serverest    /produtos    headers=${header}
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}

GET /produtosEspecificos   
    [Arguments]    ${id}
    &{header}=    Create Dictionary
    ...    Authorization=${token}
    ${response}    GET On Session    serverest    /produtos/${id}    headers=${header}
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}

POST /produtosSemToken
    &{payload}=    Create Dictionary    
    ...    nome=Notebook Gamer HP Sem Token    
    ...    preco=2000
    ...    descricao=Notebook Gamer com 16GB de RAM e 512GB SSD
    ...    quantidade=10
    ${response}    POST On Session    serverest    /produtos    data=${payload}
    Log To Console    Response: ${response.content}
    Set Global Variable    ${response}