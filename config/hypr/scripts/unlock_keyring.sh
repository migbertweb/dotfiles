#!/bin/bash

# Reemplaza TU_CONTRASEÑA_AQUÍ con tu contraseña real. 
# ADVERTENCIA: Esto es inseguro, tu contraseña será visible en este archivo.
PASSWORD="gpiro2178"

# Desbloquear el llavero y exportar las variables de entorno necesarias
eval $(echo -n "$PASSWORD" | gnome-keyring-daemon --replace --daemonize --login --components=secrets,pkcs11,ssh)
