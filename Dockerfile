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
RUN pip install --no-cache-dir \
    robotframework \
    robotframework-requests \
    robotframework-faker \
    robotframework-seleniumlibrary

# Instala o Browser library e seus drivers
RUN pip install --no-cache-dir robotframework-browser && \
    rfbrowser init

# Instala Playwright (usado pelo robotframework-browser)
RUN npm install -g playwright && \
    playwright install

# Copia os arquivos do projeto para dentro do container
COPY . .

# Define o comando padrão: executa os testes e salva na pasta de resultados
CMD ["robot", "--outputdir", "results", "."]
