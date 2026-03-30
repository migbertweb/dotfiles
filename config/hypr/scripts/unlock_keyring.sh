#!/bin/bash

# Lee la contraseña desde el archivo .pass en el home
PASSWORD=$(cat ~/.pass)

# Desbloquear el llavero y exportar las variables de entorno necesarias
eval $(echo -n "$PASSWORD" | gnome-keyring-daemon --replace --daemonize --login --components=secrets,pkcs11,ssh)
