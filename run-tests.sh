#!/bin/bash

# Verifica se o container ServeRest está rodando
if ! docker ps | grep -q serverest; then
  echo "Iniciando ServeRest API..."
  docker run -d -p 3000:3000 --name serverest paulogoncalvesbh/serverest:latest
  # Aguarda a API iniciar
  sleep 5
fi

# Constrói a imagem de testes
docker build -t serverest-robot-tests .

# Executa os testes
docker run --rm --network=host -v "$(pwd)/results:/app/results" serverest-robot-tests