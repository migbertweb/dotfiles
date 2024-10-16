#!/bin/bash

# Directorio base de los dotfiles
DOTFILES_DIR=~/dotfiles

# Directorio donde están los archivos de configuración
CONFIG_DIR=$DOTFILES_DIR/bspwm/config

# Fecha y hora actual para el nombre de la carpeta de backup
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Directorio de backup
BACKUP_DIR=$DOTFILES_DIR/dotfiles-backup-$TIMESTAMP

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

# Listar todas las carpetas y archivos en .config de los dotfiles
for item in "$CONFIG_DIR"/*; do
  # Solo el nombre del archivo o carpeta
  basename_item=$(basename "$item")

  # Verificar si ya existe en ~/.config y mover a backup
  move_if_exists "$basename_item"
done
sleep 1 && echo 'backup realizado'
# Ejecutar stow para crear los symlinks desde bspwm/config
echo 'stow a mis configuraciones'
sleep 1
stow -t ~/.config -d "$CONFIG_DIR" .
sleep 1
echo 'configuraciones realizadas'
sleep 1
###############################################
echo 'copiar archivos al home'
# Copiar el contenido de 'home' a tu directorio home personal
cp -r ~/dotfiles/bspwm/home/* ~/
sleep 1 && echo 'copia terminada'
sleep 1 && copiar archivos al Local/share
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
echo "Proceso completado. Los archivos han sido linkeados y el backup está en $BACKUP_DIR."
