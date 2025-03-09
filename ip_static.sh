#!/bin/bash
set -e  # Detener si ocurre un error

# Ajusta estos valores a tu gusto
IFACE="enp0s31f6"      # Nombre de tu interfaz
IP="192.168.1.133"     # IP estática deseada
NETMASK="255.255.255.0"
GATEWAY="192.168.1.1"
DNS="8.8.8.8 8.8.4.4"

echo "Configurando IP estática en $IFACE con la IP $IP..."

# 1. Crear el contenido de /etc/network/interfaces
sudo bash -c "cat > /etc/network/interfaces <<EOF
# Configuración de red estática para Debian (ifupdown)
auto lo
iface lo inet loopback

auto $IFACE
iface $IFACE inet static
    address $IP
    netmask $NETMASK
    gateway $GATEWAY
    dns-nameservers $DNS
EOF"

# 2. Reiniciar la red para aplicar cambios
echo "Reiniciando el servicio de red..."
sudo systemctl restart networking || sudo service networking restart

# 3. Mostrar la nueva configuración IP
echo "Nueva configuración aplicada. IP asignada:"
ip a show dev $IFACE
