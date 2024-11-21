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

########## ---------- Añadir repositorio CHAOTIC-AUR a pacman.conf ---------- ##########

logo "Añadiendo el repositorio de chaotic-aur"

# Importar la clave del repositorio
sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key 3056513887B78AEB

# Instalar el paquete de llaves y la lista de espejos
sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
sudo pacman -U --noconfirm 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'

# Contenido del repositorio a añadir al archivo pacman.conf
REPO_CONTENT="[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist"

# Comprobar si el repositorio ya está en pacman.conf
if ! grep -q "\[chaotic-aur\]" /etc/pacman.conf; then
    if echo -e "\n$REPO_CONTENT" | sudo tee -a /etc/pacman.conf >/dev/null 2>> RiceError.log; then
        printf "%sRepositorio %schaotic-aur%s añadido con éxito.%s\n" "${BLD}" "${CYE}" "${CGR}" "${CNC}"
        sudo pacman -Syy
        sleep 1
    else
        printf "%sError al añadir el repositorio personalizado. Consulta %sRiceError.log %spara más detalles.%s\n" "${BLD}" "${CYE}" "${CBL}" "${CYE}" "${CNC}"
        sleep 1
    fi
else
    printf "El repositorio %schaotic-aur%s ya está en tu pacman.conf.\n" "${CGR}" "${CNC}"
    sleep 1
fi

# Esperar 5 segundos y limpiar la pantalla
sleep 5
clear

########## ---------- Install packages ---------- ##########


# Lista de dependencias
dependencias=(btop google-chrome gimp inkscape thunderbird docker docker-compose php keepassxc nextcloud-client
 plank vlc syncthing obs-studio telegram-desktop signal-desktop)

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

##################### configurar zsh ############################
logo "Configurar ZSH"

# Crear la carpeta .zsh y clonar los plugins
printf "\n%s%sConfigurando ZSH%s\n" "${BLD}" "${CYE}" "${CNC}"
mkdir -p ~/.zsh

# Clonar los repositorios
for repo in "zsh-autosuggestions" "zsh-history-substring-search" "zsh-syntax-highlighting"; do
  printf "\n%s%sClonando %s%s%s\n" "${BLD}" "${CYE}" "$repo" "${CNC}" "${CYE}"
  git clone "https://github.com/zsh-users/$repo" ~/.zsh/$repo
  sleep 1
done

# Instalar oh-my-posh
printf "\n%s%sInstalando oh-my-posh%s\n" "${BLD}" "${CYE}" "${CNC}"
paru -S oh-my-posh --skipreview --noconfirm
sleep 2

# Finalizar configuración
printf "\n%s%sZSH configurado%s\n" "${BLD}" "${CYE}" "${CNC}"
sleep 2
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

########## --------- Configurando Docker ---------- ##########
# Nombre del servicio
SERVICE="docker"

# Verificar si el servicio está habilitado
if systemctl is-enabled --quiet "$SERVICE"; then
  printf "El servicio %s ya está habilitado.\n" "$SERVICE"
else
  printf "El servicio %s no está habilitado. Habilitándolo e iniciándolo ahora...\n" "$SERVICE"
  sudo systemctl enable --now "$SERVICE"
  
  # Verificar si el comando anterior tuvo éxito
  if [ $? -eq 0 ]; then
    printf "El servicio %s se habilitó e inició correctamente.\n" "$SERVICE"
  else
    printf "Hubo un problema al intentar habilitar e iniciar el servicio %s.\n" "$SERVICE"
    exit 1
  fi
fi

# Verificar si el usuario actual pertenece al grupo docker
if groups "$USER" | grep -qw "docker"; then
  printf "El usuario %s ya pertenece al grupo docker.\n" "$USER"
else
  printf "El usuario %s no pertenece al grupo docker. Agregándolo ahora...\n" "$USER"
  sudo usermod -aG docker "$USER"
  
  # Verificar si el comando anterior tuvo éxito
  if [ $? -eq 0 ]; then
    printf "El usuario %s fue agregado al grupo docker correctamente.\n" "$USER"
    printf "Actualizando la sesión para aplicar los cambios al grupo docker...\n"
    newgrp docker
  else
    printf "Hubo un problema al intentar agregar al usuario %s al grupo docker.\n" "$USER"
  fi
fi
sleep 2
clear
########## --------- Cambiando shell to zsh ---------- ##########

logo "Cambiando la shell predeterminada a zsh"

# Comprobar si la shell actual no es zsh
if [[ $SHELL != "/usr/bin/zsh" ]]; then
  # Mostrar mensaje informativo
  printf "\n%s%sCambiando tu shell a zsh. Se requiere la contraseña de root.%s\n\n" "${BLD}" "${CYE}" "${CNC}"
  
  # Cambiar la shell a zsh
  chsh -s /usr/bin/zsh
  
  # Confirmación de cambio de shell
  printf "%s%sShell cambiada a zsh. Por favor, reinicia el sistema.%s\n\n" "${BLD}" "${CGR}" "${CNC}"
else
  # Si la shell ya es zsh, informar al usuario
  printf "%s%sTu shell ya es zsh\n¡Adiós! La instalación ha terminado, ahora reinicia el sistema.%s\n" "${BLD}" "${CGR}" "${CNC}"
fi

# Iniciar zsh
zsh