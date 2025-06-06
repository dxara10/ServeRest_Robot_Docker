*** Settings ***
Documentation     Teste para verificar comportamento de concorrência em carrinhos
Resource          ../../Keywords/login_keyword.robot
Resource          ../../Keywords/produtos_keyword.robot
Resource          ../../Keywords/carrinho_keyword.robot

*** Test Cases ***
Tentar criar dois carrinhos com mesmo usuário
    [Documentation]    Este teste verifica o comportamento quando se tenta criar dois carrinhos para o mesmo usuário
    [Tags]    bug    concorrencia
    
    # Primeiro carrinho
    Criar Sessão
    Configurar Usuario e Login
    Criar Produto Dinamico
    Criar Carrinho e Armazenar ID
    Validar Status Code "201"
    
    # Tentar criar segundo carrinho com mesmo usuário
    Criar Produto Dinamico
    POST /carrinhos
    Validar Status Code "400"
    Validar Se Mensagem Contem "Não é permitido ter mais de 1 carrinho"