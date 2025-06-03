*** Settings ***
Documentation     Arquivo de testes para endpoint de usuários
Resource          ../Keywords/usuarios_keyword.robot

*** Variables ***


Suite Setup       Criar Sessao

*** Test Cases ***
Criar usuário válido
    Executar criação
    Validar status code 201
    Validar mensagem "Cadastro realizado com sucesso"
    Armazenar ID do usuário criado

Atualizar usuário criado 
    Executar atualização de usuário
    Validar status code 200  

Listar usuários e validar atualização
    Executar listagem de usuários  
    Validar presença de usuário

Deletar usuário
    Executar deleção de usuário
    Validar status code 200 

Tentar criar usuário com e-mail inválido
    Executar criação de usuário com dados
    Validar status code 400
    Validar mensagem de erro apropriada 

Tentar criar usuário com senha inválida
    Executar criação de usuário
    Validar status code 400
    Validar mensagem de erro apropriada