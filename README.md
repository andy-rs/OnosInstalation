# ONOS Installation Script

Este repositorio contiene un script automatizado para instalar ONOS en sistemas basados en Linux.

## Pasos de instalación

Sigue estos pasos para instalar ONOS correctamente:

1. **Descarga el script en el escritorio (Desktop):**

Usa `curl` o `wget` para descargar el archivo directamente en tu escritorio:

```bash
# Usando curl descargar el archivo
cd ~/Desktop
wget https://raw.githubusercontent.com/andy-rs/OnosInstalation/refs/heads/main/onos_instalation.sh

# Para hacer el script ejecutable
chmod +x onos_instalation.sh

# Ejecutar el script como superusuario
sudo ./onos_instalation.sh
