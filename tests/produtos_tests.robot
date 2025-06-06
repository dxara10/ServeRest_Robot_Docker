*** Settings ***
Documentation     Arquivo de testes para endpoint de produtos
Resource          ../Keywords/produtos_keyword.robot
Resource          ../Keywords/login_keyword.robot

*** Variables ***
${PRODUTO_ID}     ${EMPTY}    # Variável para armazenar ID do produto criado dinamicamente

*** Settings ***
Suite Setup       Setup Test Suite
Suite Teardown    Teardown Test Suite

*** Test Cases ***
Criar produto dinâmico
    Verificar Token Valido
    Criar Produto Dinamico
    Validar Status Code "201"
    Armazenar ID Produto

Atualizar produto
    Verificar Token Valido
    PUT /produtos    ${PRODUTO_ID}
    Validar Status Code "200"
    Validar Se Mensagem Contem "Registro alterado com sucesso"

Listar produtos
    GET /produtos
    Validar Status Code "200"

Listar produto específico
    GET /produtosEspecificos    ${PRODUTO_ID}
    Validar Status Code "200"

Tentar criar produto sem token
    POST /produtosSemToken
    Validar Status Code "401"
    Validar Se Mensagem Contem "Token de acesso ausente"

Deletar produto
    Verificar Token Valido
    DELETE /produtos    ${PRODUTO_ID}
    Validar Status Code "200"
    Validar Se Mensagem Contem "Registro excluído com sucesso"

*** Keywords ***
Setup Test Suite
    Create Session    serverest    ${BASE_URL}    verify=${FALSE}
    Set Global Variable    ${BASE_URL}
    Executar login
    ${token_auth}=    Set Variable    ${response.json()["authorization"]}
    Set Global Variable    ${token_auth}

Teardown Test Suite
    Delete All Sessions
    Log    Finalizando suite de testes de produtos

Armazenar ID Produto
    ${PRODUTO_ID}=    Set Variable    ${response.json()["_id"]}
    Set Global Variable    ${PRODUTO_ID}
    Log To Console    ID do Produto Criado: ${PRODUTO_ID}
