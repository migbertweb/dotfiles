#!/bin/bash

logo() {

  local text="${1:?}"
  echo -en "


███╗   ███╗██╗ ██████╗ ██████╗ ███████╗██████╗ ████████╗
████╗ ████║██║██╔════╝ ██╔══██╗██╔════╝██╔══██╗╚══██╔══╝
██╔████╔██║██║██║  ███╗██████╔╝█████╗  ██████╔╝   ██║
██║╚██╔╝██║██║██║   ██║██╔══██╗██╔══╝  ██╔══██╗   ██║
██║ ╚═╝ ██║██║╚██████╔╝██████╔╝███████╗██║  ██║   ██║
╚═╝     ╚═╝╚═╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝   ╚═╝

    Mis Dotfiles\n\n"
  printf ' %s [%s%s %s%s %s]%s\n\n' "${CRE}" "${CNC}" "${CYE}" "${text}" "${CNC}" "${CRE}" "${CNC}"
}

########## ---------- Install packages ---------- ##########


# Lista de dependencias
dependencias=(btop conky microsoft-edge-stable-bin google-chrome gimp inkscape thunderbird auto-cpufreq tlp acpi acpid xprintidle docker docker-compose php keepassxc nextcloud-client plank vlc syncthing obs-studio telegram-desktop signal-desktop shotcut visual-studio-code-bin wireguird stow ripgrep fastfetch udiskie ffmpegthumbnailer unrar p7zip zip unzip lrzip sed curl lazygit dex eza bluez bluez-utils polkit-gnome gnome-keyring ranger tldr zoxide fd xclip lxappearance jq dg-desktop-portal ffmpeg xdg-desktop-portal-gtk xorg-xwininfo bat brightnessctl zram-generator gparted)

# Función para verificar si un paquete ya está instalado
is_installed() {
  pacman -Q "$1" &>/dev/null
}

# Mostrar menú de selección
selected_packages=()
echo "Selecciona los paquetes que deseas instalar (usa números separados por espacios, por ejemplo: 1 3 5):"
for i in "${!dependencias[@]}"; do
  printf "%d) %s\n" "$((i + 1))" "${dependencias[i]}"
done

read -rp "Paquetes seleccionados: " choices

# Filtrar los paquetes seleccionados
for choice in $choices; do
  if [[ $choice -gt 0 && $choice -le ${#dependencias[@]} ]]; then
    selected_packages+=("${dependencias[$((choice - 1))]}")
  fi
done

if [[ ${#selected_packages[@]} -eq 0 ]]; then
  echo "No seleccionaste ningún paquete. Saliendo..."
  sleep 3
  clear
  exit 1
fi

# Instalar los paquetes seleccionados
printf "%s%sInstalando paquetes seleccionados...%s\n" "${BLD}" "${CBL}" "${CNC}"
for paquete in "${selected_packages[@]}"; do
  if ! is_installed "$paquete"; then
    if sudo pacman -S "$paquete" --noconfirm >/dev/null 2>>RiceError.log; then
      printf "%s%s%s %sinstalado correctamente.%s\n" "${BLD}" "${CYE}" "$paquete" "${CBL}" "${CNC}"
      sleep 1
    else
      printf "%s%s%s %sfalló en su instalación. Verifica %sRiceError.log%s para más detalles.%s\n" "${BLD}" "${CYE}" "$paquete" "${CRE}" "${CBL}" "${CRE}" "${CNC}"
      sleep 1
    fi
  else
    printf '%s%s%s %sya está instalado en el sistema.%s\n' "${BLD}" "${CYE}" "$paquete" "${CGR}" "${CNC}"
    sleep 1
  fi
done

# Finalizar con espera y limpieza
echo "Proceso completado."
sleep 5
clear

################################################################
logo "configurar Docker:"
sleep 1
echo "habilitando servicio Docker"
sudo systemctl enable docker.service && sudo systemctl start docker.service
##-----
sleep 2
echo "añadir mi usuario a Docker Group"
sudo usermod -aG docker migbert && newgrp docker
sleep 2
clear

########## ---------- Enabling SYNCTHING service ---------- ##########

logo "Habilitando el servicio de SYNCTHING"

# Mostrar mensaje informativo
printf "\n%s%sHabilitando e iniciando el servicio syncthing a nivel de usuario%s\n" "${BLD}" "${CYE}" "${CNC}"

# Habilitar e iniciar el servicio
systemctl --user enable --now syncthing.service

# Confirmación de la acción realizada
printf "%s%s¡Listo!%s\n\n" "${BLD}" "${CGR}" "${CNC}"

# Pausar durante 2 segundos y limpiar la pantalla
sleep 2
clear

########## ---------- Enabling auto-cpufreq y tlp service ---------- ##########

logo "Habilitando los servicios auto-cpufreq y tlp"

# Habilitar e iniciar el servicio
sudo systemctl enable --now auto-cpufreq.service
sudo systemctl enable --now tlp.service

# Confirmación de la acción realizada
printf "%s%s¡Listo!%s\n\n" "${BLD}" "${CGR}" "${CNC}"

# Pausar durante 2 segundos y limpiar la pantalla
sleep 2
clear

########## ---------- Enabling zram ---------- ##########

logo "Habilitando ZRAM"

# Nombre del archivo de configuración
CONFIG_FILE="/etc/systemd/zram-generator.conf"

# Verificar si el script se ejecuta como root
if [ "$(id -u)" -ne 0 ]; then
    echo "Este script debe ejecutarse como root. Usa 'sudo'." >&2
    exit 1
fi

# Crear el archivo de configuración con el contenido requerido
echo "Creando configuración ZRAM en $CONFIG_FILE..."
sudo cat > "$CONFIG_FILE" <<EOF
[zram0]
zram-size = ram * 0.25
compression-algorithm = zstd
swap-priority = 100
EOF

# Recargar demonios de systemd y reiniciar el servicio
echo "Recargando configuración y activando ZRAM..."
sudo systemctl daemon-reload
sudo systemctl start systemd-zram-setup@zram0

# Verificar el estado
echo ""
echo "Estado del servicio ZRAM:"
sudo systemctl status systemd-zram-setup@zram0 --no-pager

echo ""
echo "Resumen ZRAM:"
zramctl

echo ""
echo "Configuración aplicada correctamente. Revisa los detalles arriba."
