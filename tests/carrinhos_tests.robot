*** Settings ***
Documentation     Arquivo de testes para endpoint de carrinhos
Resource          ../Keywords/carrinho_keyword.robot
Resource          ../Keywords/produtos_keyword.robot
Resource          ../Keywords/login_keyword.robot
Resource          ../Keywords/usuarios_keyword.robot

*** Variables ***
${CARRINHO_ID}    ${EMPTY}    # Variável para armazenar ID do carrinho criado dinamicamente

*** Settings ***
Suite Setup       Setup Test Suite
Suite Teardown    Teardown Test Suite

*** Test Cases ***
Criar carrinho com produto dinâmico
    Configurar Usuario e Login
    Criar Produto Dinamico
    Criar Carrinho e Armazenar ID
    Validar Status Code "201"
    Validar Se Mensagem Contem "Cadastro realizado com sucesso"

Adicionar produto ao carrinho
    Configurar Usuario e Login
    # Criar primeiro produto
    Criar Produto Dinamico
    ${produto_id1}=    Set Variable    ${id_produto}
    
    # Criar segundo produto
    Criar Produto Dinamico
    ${produto_id2}=    Set Variable    ${id_produto}
    
    # Adicionar ambos produtos ao carrinho
    ${headers}=    Create Dictionary    Authorization=${token_auth}
    
    # Criar entradas de produtos
    ${produto1}=    Create Dictionary    idProduto=${produto_id1}    quantidade=1
    ${produto2}=    Create Dictionary    idProduto=${produto_id2}    quantidade=2
    
    # Criar lista de produtos
    @{produtos}=    Create List    ${produto1}    ${produto2}
    
    # Criar payload
    ${payload}=    Create Dictionary    produtos=${produtos}
    
    # Criar carrinho com múltiplos produtos
    ${response}=    POST On Session    serverest    /carrinhos    json=${payload}    headers=${headers}
    Set Global Variable    ${response}
    
    Validar Status Code "201"
    Validar Se Mensagem Contem "Cadastro realizado com sucesso"

Listar carrinhos
    GET /carrinhos
    Validar Status Code "200"

Listar carrinho específico
    GET /carrinhos    ${CARRINHO_ID}
    Validar Status Code "200"

Concluir compra
    Configurar Usuario e Login
    Criar Produto Dinamico
    Criar Carrinho e Armazenar ID
    Concluir Compra e Validar

Cancelar compra
    Configurar Usuario e Login
    Criar Produto Dinamico
    Criar Carrinho e Armazenar ID
    Cancelar Compra e Validar

*** Keywords ***
Setup Test Suite
    Create Session    serverest    ${BASE_URL}    verify=${FALSE}
    Set Global Variable    ${BASE_URL}

Teardown Test Suite
    Delete All Sessions
    Log    Finalizando suite de testes de carrinhos

Cancelar Compra e Validar
    DELETE /carrinhos sem produtos
    Validar Status Code "200"
    Validar Se Mensagem Contem "Registro excluído com sucesso"

