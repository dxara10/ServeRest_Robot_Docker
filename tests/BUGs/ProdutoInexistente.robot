*** Settings ***
Documentation     Teste para verificar comportamento com produtos inexistentes
Resource          ../../Keywords/login_keyword.robot
Resource          ../../Keywords/usuarios_keyword.robot
Resource          ../../Keywords/produtos_keyword.robot
Resource          ../../Keywords/carrinho_keyword.robot

*** Test Cases ***
Tentar adicionar produto inexistente ao carrinho
    [Documentation]    Este teste verifica o comportamento ao tentar adicionar um produto inexistente ao carrinho
    [Tags]    bug    produto_inexistente
    
    # Criar usuário e carrinho
    Criar Sessão
    Configurar Usuario e Login
    Criar Produto Dinamico
    Criar Carrinho e Armazenar ID
    
    # Tentar adicionar produto com ID inexistente
    ${id_inexistente}=    Set Variable    qualquercoisa
    adição de produto ID_PRODUTO ao carrinho ID_CARRINHO    ${id_inexistente}    ${CARRINHO_ID}
    Validar Status Code "400"
    Validar Se Mensagem Contem "Produto não encontrado"