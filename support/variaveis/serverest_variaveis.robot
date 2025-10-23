*** Settings ***
Documentation     Arquivo de variáveis globais para o projeto

*** Variables ***
# URLs e endpoints
${BASE_URL}          http://184.72.144.42:3000/


# Credenciais padrão
${EMAIL}             fulano@qa.com
${PASSWORD}          teste

# Variáveis dinâmicas (inicializadas vazias)
${DYNAMIC_EMAIL}     ${EMPTY}
${DYNAMIC_PASSWORD}  ${EMPTY}
${token_auth}        ${EMPTY}
${response}          ${EMPTY}

# IDs de recursos
${USUARIO_ID}        ${EMPTY}
${PRODUTO_ID}        ${EMPTY}
${CARRINHO_ID}       ${EMPTY}
${id_produto}        ${EMPTY}
${id_carrinho}       ${EMPTY}