#!/bin/bash

# Actualiza el sistema
sudo apt update && sudo apt upgrade -y

# Instala paquetes necesarios
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Agrega la clave GPG oficial de Docker
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null

# Agrega el repositorio de Docker
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Actualiza los paquetes
sudo apt update

# Instala Docker y Docker Compose
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Agrega el usuario actual al grupo docker para evitar usar sudo
sudo usermod -aG docker $USER

# Habilita e inicia Docker
sudo systemctl enable docker
sudo systemctl start docker

# Verifica la instalación
docker --version
docker compose version

echo "✅ Instalación de Docker completada. Reinicia la sesión para aplicar cambios."
