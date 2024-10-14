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

# Ejecutar stow para crear los symlinks desde bspwm/config
stow -t ~/.config -d "$CONFIG_DIR" .

echo "Proceso completado. Los archivos han sido linkeados y el backup está en $BACKUP_DIR."
