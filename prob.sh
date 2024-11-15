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

# Lista de dependencias
dependencias=(btop google-chrome gimp inkscape thunderbird docker docker-compose php keepassxc nextcloud-client plank vlc syncthing)

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