#!/bin/bash

# Configuración
INTERFACE="wlan0"            # Cambia por tu interfaz Wi-Fi (ej: wlp2s0)
INTERVALO=2                  # Segundos entre actualizaciones

# Función para obtener el ESSID (usando iw)
obtener_essid() {
    iw dev "$INTERFACE" link 2>/dev/null | grep -oP 'SSID:\s*\K.*' || echo "Desconectado"
}

# Función para obtener bytes recibidos
obtener_rx_bytes() {
    cat "/sys/class/net/$INTERFACE/statistics/rx_bytes" 2>/dev/null || echo 0
}

# Bucle principal
bytes_ant=$(obtener_rx_bytes)
essid_ant=""

while true; do
    sleep "$INTERVALO"
    
    bytes_act=$(obtener_rx_bytes)
    essid_act=$(obtener_essid)
    
    # Calcular velocidad en bytes/segundo
    diff_bytes=$((bytes_act - bytes_ant))
    velocidad_bytes=$((diff_bytes / INTERVALO))
    
    # Formatear velocidad con unidad apropiada (B/s, KB/s, MB/s)
    if [ $velocidad_bytes -ge 1048576 ]; then
        velocidad=$(echo "scale=2; $velocidad_bytes / 1048576" | bc)
        unidad="MB/s"
    elif [ $velocidad_bytes -ge 1024 ]; then
        velocidad=$(echo "scale=2; $velocidad_bytes / 1024" | bc)
        unidad="KB/s"
    else
        velocidad="$velocidad_bytes"
        unidad="B/s"
    fi
    
    # Mostrar solo ESSID y velocidad
    echo "$essid_act ↓ ${velocidad} ${unidad}"
    
    # Actualizar variables
    bytes_ant=$bytes_act
    essid_ant=$essid_act
done
