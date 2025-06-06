FROM python:3.10-slim

# Instala dependências de sistema
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    wget \
    unzip \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Define diretório de trabalho
WORKDIR /app

# Instala o Robot Framework e as bibliotecas necessárias
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Instala o Browser library e seus drivers
RUN pip install --no-cache-dir robotframework-browser && \
    rfbrowser init

# Instala Playwright (usado pelo robotframework-browser)
RUN npm install -g playwright && \
    playwright install chromium --with-deps

# Copia os arquivos do projeto para dentro do container
COPY . .

# Cria links simbólicos para os arquivos JSON no diretório raiz
RUN ln -sf /app/support/fixtures/static/json_usuario.json /app/json_usuario.json && \
    ln -sf /app/support/fixtures/static/json_login.json /app/json_login.json

# Define variáveis de ambiente
ENV PYTHONUNBUFFERED=1
ENV BASE_URL="http://localhost:3000"

# Define o comando padrão
CMD ["robot", "--outputdir", "results", "tests"]