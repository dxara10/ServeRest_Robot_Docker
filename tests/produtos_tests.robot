*** Settings ***
Documentation     Arquivo de testes para endpoint de produtos
Resource          ../Keywords/produtos_keyword.robot

*** Variables ***

Suite Setup       Criar Sessao

*** Test Cases ***
Criar produto autenticado
    Adicionar token de autenticação
    Executar criação de produto
    Validar status code 201
    Armazenar ID do produto criado

Atualizar produto
    Executar atualização de produto
    Validar status code 200  

Deletar produto
    Executar deleção de produto
    Validar status code 200

Tentar criar produto sem token
    Remover token de autenticação
    Executar criação de produto
    Validar status code 401
