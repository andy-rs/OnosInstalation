#!/bin/bash

set -e

echo "[*] Instalando wget y OpenJDK 8..."
sudo apt update &>/dev/null
sudo apt install -y wget openjdk-8-jdk &>/dev/null

echo "[*] Configurando variables de entorno Java en ~/.bashrc..."
JAVA_ENV='
# Java 8 Environment
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JRE_HOME=$JAVA_HOME/jre
export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib
export PATH=$JAVA_HOME/bin:$PATH
'

if ! grep -q "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" ~/.bashrc; then
    echo "$JAVA_ENV" >> ~/.bashrc
    source ~/.bashrc
fi

echo "[*] Descargando ONOS 2.0.0..."
wget -c https://repo1.maven.org/maven2/org/onosproject/onos-releases/2.0.0/onos-2.0.0.tar.gz &>/dev/null

echo "[*] Extrayendo ONOS..."
tar zxvf onos-2.0.0.tar.gz &>/dev/null

echo "[*] Moviendo ONOS a /opt/onos..."
sudo mkdir -p /opt/onos &>/dev/null
sudo cp -r onos-2.0.0/* /opt/onos &>/dev/null

echo "[*] Iniciando servicio ONOS..."
sudo /opt/onos/bin/onos-service start &>/dev/null & disown

echo "[*] Esperando 2 minutos para inicialización de ONOS..."
sleep 120 

echo "[*] Configurando ~/.ssh/config para soporte ssh-rsa..."
mkdir -p ~/.ssh &>/dev/null
touch ~/.ssh/config 

SSH_CONFIG='
Host *
    HostKeyAlgorithms +ssh-rsa
    PubkeyAcceptedKeyTypes +ssh-rsa
'

if ! grep -q "HostKeyAlgorithms +ssh-rsa" ~/.ssh/config; then
    echo "$SSH_CONFIG" >> ~/.ssh/config
fi

echo "[*] Conectando a la CLI de ONOS..."
/opt/onos/bin/onos -l onos