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

########## ---------- You must not run this as root ---------- ##########

if [ "$(id -u)" = 0 ]; then
  echo "This script MUST NOT be run as root user."
  exit 1
fi

home_dir=$HOME
current_dir=$(pwd)

if [ "$current_dir" != "$home_dir" ]; then
  printf "%s%sThe script must be executed from the HOME directory.%s\n" "${BLD}" "${CYE}" "${CNC}"
  exit 1
fi

########## ---------- Welcome ---------- ##########

logo "Welcome!"
printf '%s%sThis script will check if you have the necessary dependencies, and if not, it will install them. Then, it will clone my repository in your HOME directory.\nAfter that, it will create a backup of your files, and then copy the new files to your computer.\n\nMy dotfiles DO NOT modify any of your system configurations.\nYou will be prompted for your root password to install missing dependencies and/or to switch to zsh shell if its not your default.\n\nThis script doesnt have the potential power to break your system, it only copies files from my repository to your HOME directory.%s\n\n' "${BLD}" "${CRE}" "${CNC}"

while true; do
  read -rp " Do you wish to continue? [y/N]: " yn
  case $yn in
  [Yy]*) break ;;
  [Nn]*) exit ;;
  *) printf " Error: just write 'y' or 'n'\n\n" ;;
  esac
done
clear

########## ---------- Install packages ---------- ##########

logo "Instalando paquetes necesarios.."

dependencias=(alacritty base-devel bat brightnessctl bspwm dunst eza feh fzf gvfs-mtp firefox geany git kitty imagemagick jq
  jgmenu libwebp maim mpc mpd neovim ncmpcpp npm pamixer pacman-contrib bluez bluez-utils
  papirus-icon-theme picom playerctl polybar polkit-gnome python-gobject ranger tldr zoxide fd
  redshift rofi rustup sxhkd tmux ttf-inconsolata ttf-jetbrains-mono ttf-jetbrains-mono-nerd
  ttf-joypixels ttf-terminus-nerd ttf-ubuntu-mono-nerd ueberzug webp-pixbuf-loader xclip xdg-user-dirs
  xdo xdotool xsettingsd xorg-xdpyinfo xorg-xkill xorg-xprop xorg-xrandr xorg-xsetroot
  xorg-xwininfo zsh google-chrome gimp inkscape thunderbird docker php fastfetch
  fastfetch exa bat ffmpegthumbnailer plank vlc unrar p7zip lrzip sed curl git lazygit dex)

is_installed() {
  pacman -Q "$1" &>/dev/null
}

printf "%s%sChecking for required packages...%s\n" "${BLD}" "${CBL}" "${CNC}"
for paquete in "${dependencias[@]}"; do
  if ! is_installed "$paquete"; then
    if sudo pacman -S "$paquete" --noconfirm >/dev/null 2>>RiceError.log; then
      printf "%s%s%s %shas been installed succesfully.%s\n" "${BLD}" "${CYE}" "$paquete" "${CBL}" "${CNC}"
      sleep 1
    else
      printf "%s%s%s %shas not been installed correctly. See %sRiceError.log %sfor more details.%s\n" "${BLD}" "${CYE}" "$paquete" "${CRE}" "${CBL}" "${CRE}" "${CNC}"
      sleep 1
    fi
  else
    printf '%s%s%s %sis already installed on your system!%s\n' "${BLD}" "${CYE}" "$paquete" "${CGR}" "${CNC}"
    sleep 1
  fi
done
sleep 5
clear

########## ---------- Cloning the Rice! ---------- ##########

logo "Downloading dotfiles"

repo_url="https://github.com/gh0stzk/dotfiles"
repo_dir="$HOME/dotfiles"

# Verifies if the folder of the repository exists, and if it does, deletes it
if [ -d "$repo_dir" ]; then
  printf "Removing existing dotfiles repository\n"
  mv "$repo_dir" "$repo_dir-backup"
fi

# Clone the repository
printf "Cloning dotfiles from %s\n" "$repo_url"
git clone --depth=1 "$repo_url" "$repo_dir"
sleep 2
clear

##################### Prepare directories ############################
printf 'Preparando directorios!\n'
# Directorio base de los dotfiles
DOTFILES_DIR=~/dotfiles

# Directorio donde están los archivos de configuración
CONFIG_DIR=$DOTFILES_DIR/bspwm/config

# Fecha y hora actual para el nombre de la carpeta de backup
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Directorio de backup
BACKUP_DIR=~/dotfiles-backup-$TIMESTAMP

# Crear el directorio de backup
mkdir -p "$BACKUP_DIR"
sleep 1 && echo 'carpeta de backup creada'
# Función para mover el archivo o carpeta si ya existe
move_if_exists() {
  if [ -e "$HOME/.config/$1" ]; then
    echo "Moviendo $1 a la carpeta de backup..."
    mv "$HOME/.config/$1" "$BACKUP_DIR/"
  fi
}
sleep 2 && echo 'preconfigurando backup'
# Listar todas las carpetas y archivos en .config de los dotfiles
for item in "$CONFIG_DIR"/*; do
  # Solo el nombre del archivo o carpeta
  basename_item=$(basename "$item")

  # Verificar si ya existe en ~/.config y mover a backup
  move_if_exists "$basename_item"
done
sleep 1 && echo 'backup realizado'
sleep 5
clear

############################## Enlaces simbolicos ############################
# Ejecutar stow para crear los symlinks desde bspwm/config
echo 'stow a mis configuraciones'
sleep 1
stow -t ~/.config -d "$CONFIG_DIR" .
sleep 1
echo 'enlaces simbolicos realizados en .config/'
sleep 1
###############################################
echo 'copiar archivos necesarios al home'
# Copiar el contenido de 'home' a tu directorio home personal
cp -r ~/dotfiles/bspwm/home/* ~/
sleep 1 && echo 'copia terminada'
sleep 2 && echo 'copiar archivos al /.local/share'
# Si quieres copiar específicamente solo algunos archivos a ~/.local/share
# Puedes añadir un paso específico para ~/.local/share
cp -r ~/dotfiles/bspwm/misc/share/* ~/.local/share/
sleep 1
# Copiar el contenido de la carpeta 'bin' a ~/.local/bin
echo 'copiar los bin'
mkdir -p ~/.local/bin
sleep 1
cp -r ~/dotfiles/bspwm/misc/bin ~/.local/bin/
sleep 1

##################### configurar zsh ############################
# crear carpeta .zsh y clonar los plugins y powerlevel10k
echo 'Configurando ZSH'
mkdir -p ~/.zsh
echo 'powerlevel10k'
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
sleep 1
echo 'clonando zsh-autosuggestions'
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
sleep 1
echo 'clonando zsh-history-substring-search'
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.zsh/zsh-history-substring-search
sleep 1
echo 'clonando zsh-syntax-highlighting'
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
sleep 1
echo 'zsh configurado'
sleep 1
################################
echo "Proceso completado. Los archivos han sido linkeados y el backup está en $BACKUP_DIR."
sleep 5
clear

########## ---------- Installing Paru & others ---------- ##########

logo "installing Paru, Eww, tdrop & xqp"

# Installing Paru
if command -v paru >/dev/null 2>&1; then
  printf "%s%sParu is already installed%s\n" "${BLD}" "${CGR}" "${CNC}"
else
  printf "%s%sInstalling paru%s\n" "${BLD}" "${CBL}" "${CNC}"
  {
    cd "$HOME" || exit
    git clone https://aur.archlinux.org/paru-bin.git
    cd paru-bin || exit
    makepkg -si --noconfirm
  } || {
    printf "\n%s%sFailed to install Paru. You may need to install it manually%s\n" "${BLD}" "${CRE}" "${CNC}"
  }
fi

# Installing tdrop for scratchpads
if command -v tdrop >/dev/null 2>&1; then
  printf "\n%s%sTdrop is already installed%s\n" "${BLD}" "${CGR}" "${CNC}"
else
  printf "\n%s%sInstalling tdrop, this should be fast!%s\n" "${BLD}" "${CBL}" "${CNC}"
  paru -S tdrop-git --skipreview --noconfirm
fi

# Installing xqp
if command -v xqp >/dev/null 2>&1; then
  printf "\n%s%sxqp is already installed%s\n" "${BLD}" "${CGR}" "${CNC}"
else
  printf "\n%s%sInstalling xqp, this should be fast!%s\n" "${BLD}" "${CBL}" "${CNC}"
  paru -S xqp --skipreview --noconfirm
fi

# Installing rofi-greenclip
if pacman -Qq rofi-greenclip >/dev/null 2>&1; then
  printf "\n%s%srofi-greenclip is already installed%s\n" "${BLD}" "${CGR}" "${CNC}"
else
  printf "\n%s%sInstalling rofi-greenclip, this should be fast!%s\n" "${BLD}" "${CBL}" "${CNC}"
  paru -S rofi-greenclip --skipreview --noconfirm
fi

# Installing ttf-maple
if pacman -Qq ttf-maple >/dev/null 2>&1; then
  printf "\n%s%sttf-maple is already installed%s\n" "${BLD}" "${CGR}" "${CNC}"
else
  printf "\n%s%sInstalling ttf-maple, this should be fast!%s\n" "${BLD}" "${CBL}" "${CNC}"
  paru -S ttf-maple --skipreview --noconfirm
fi

# Installing i3lock-color
if pacman -Qq i3lock-color >/dev/null 2>&1; then
  printf "\n%s%si3lock-color is already installed%s\n" "${BLD}" "${CGR}" "${CNC}"
else
  printf "\n%s%sInstalling i3lock-color, this should be fast!%s\n" "${BLD}" "${CBL}" "${CNC}"
  paru -S i3lock-color --skipreview --noconfirm
fi

# Installing simple-mtpfs
if pacman -Qq simple-mtpfs >/dev/null 2>&1; then
  printf "\n%s%ssimple-mtpfs is already installed%s\n" "${BLD}" "${CGR}" "${CNC}"
else
  printf "\n%s%sInstalling simple-mtpfs, this should be fast!%s\n" "${BLD}" "${CBL}" "${CNC}"
  paru -S simple-mtpfs --skipreview --noconfirm
fi

# Installing Eww
if pacman -Qq eww-git >/dev/null 2>&1; then
  printf "\n%s%sEww is already installed%s\n" "${BLD}" "${CGR}" "${CNC}"
else
  printf "\n%s%sInstalling Eww, this will take some time.. !%s\n" "${BLD}" "${CBL}" "${CNC}"
  paru -S eww-git --skipreview --noconfirm
fi

########## ---------- Enabling MPD service ---------- ##########

logo "Enabling mpd service"

# Verifica si el servicio mpd está habilitado a nivel global (sistema)
if systemctl is-enabled --quiet mpd.service; then
  printf "\n%s%sDisabling and stopping the global mpd service%s\n" "${BLD}" "${CBL}" "${CNC}"
  sudo systemctl stop mpd.service
  sudo systemctl disable mpd.service
fi

printf "\n%s%sEnabling and starting the user-level mpd service%s\n" "${BLD}" "${CYE}" "${CNC}"
systemctl --user enable --now mpd.service

printf "%s%sDone!!%s\n\n" "${BLD}" "${CGR}" "${CNC}"
sleep 2

########## --------- Changing shell to zsh ---------- ##########

logo "Changing default shell to zsh"

if [[ $SHELL != "/usr/bin/zsh" ]]; then
  printf "\n%s%sChanging your shell to zsh. Your root password is needed.%s\n\n" "${BLD}" "${CYE}" "${CNC}"
  # Cambia la shell a zsh
  chsh -s /usr/bin/zsh
  printf "%s%sShell changed to zsh. Please reboot.%s\n\n" "${BLD}" "${CGR}" "${CNC}"
else
  printf "%s%sYour shell is already zsh\nGood bye! installation finished, now reboot%s\n" "${BLD}" "${CGR}" "${CNC}"
fi
zsh
