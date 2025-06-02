# Imagem base com Python
FROM python:3.10-slim

# Diretório de trabalho dentro do container
WORKDIR /app

# Copia os arquivos de dependência
COPY requirements.txt .

# Instala as dependências
RUN pip install --no-cache-dir -r requirements.txt

# Copia todo o conteúdo do projeto para o container
COPY . .

# Define o comando padrão para executar os testes
CMD ["robot", "-d", "results", "tests"]
