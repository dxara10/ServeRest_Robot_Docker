*** Settings ***
Documentation     Arquivo de testes para endpoint de carrinhos
Resource          ../Keywords/carrinho_keyword.robot

*** Variables ***


#Suite Setup       Criar Sessao

*** Test Cases ***
Criar carrinho
    Criar Sessão
    POST /carrinhos    
    # Validar status code 201

Adicionar produto ao carrinho
    Criar Sessão
    POST /carrinhos
    adição de produto ID_PRODUTO ao carrinho ID_CARRINHO
#    Validar status code 201

Finalizar compra
    Criar Sessão
    DELETE /carrinhos
    #Validar status code 200

Cancelar compra
    Criar Sessão
    DELETE /carrinhos sem produtos
    #Validar status code 400

Listar carrinhos
    Criar Sessão
    GET /carrinhos
    #Validar status code 200

Listar carrinho especifico
    Criar Sessão
    GET /carrinhos/qbMqntef4iTOwWfg
    #Validar status code 200

