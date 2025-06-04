*** Settings ***
Documentation     Arquivo de testes para endpoint de produtos
Resource          ../Keywords/produtos_keyword.robot

*** Variables ***

#Suite Setup       Criar Sessao

*** Test Cases ***
Criar produto
    Criar Sessão
    POST /produtos
    #Validar status code 201

Atualizar produto
    Criar Sessão
    PUT /produtos
    #Validar status code 200

Deletar produto
    Criar Sessão
    DELETE /produtos

Tentar criar produto sem token
    Criar Sessão
    POST /produtosSemToken
    #Validar status code 401

Listar produtos
    Criar Sessão
    GET /produtos
    #Validar status code 200

Listar produtos específico
    Criar Sessão
    GET /produtosEspecificos   ejj4xzPR50K6gIlp
    #Validar status code 200
