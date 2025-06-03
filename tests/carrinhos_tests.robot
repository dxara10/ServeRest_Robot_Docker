*** Settings ***
Documentation     Arquivo de testes para endpoint de carrinhos
Resource          ../Keywords/carrinho_keyword.robot

*** Variables ***


Suite Setup       Criar Sessao

*** Test Cases ***
Criar carrinho autenticado
    Adicionar token de autenticação TOKEN
    Executar criação de carrinho para usuário ID_USUARIO
    Validar status code 201
    Armazenar ID do carrinho criado como ID_CARRINHO

Adicionar produto ao carrinho
    Executar adição de produto ID_PRODUTO ao carrinho ID_CARRINHO
    Validar status code 201

Finalizar compra
    Executar finalização de compra para carrinho ID_CARRINHO
    Validar status code 200

Tentar finalizar carrinho vazio
    Executar criação de carrinho vazio para usuário ID_USUARIO
    Armazenar ID do carrinho criado como ID_CARRINHO_VAZIO
    Executar finalização de compra para carrinho ID_CARRINHO_VAZIO
    Validar status code 400

