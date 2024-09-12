#!/bin/bash

# Verificar el estado de Bloq Mayús
if xset q | grep "Caps Lock:   on" >/dev/null; then
  echo " " # Icono cuando Bloq Mayús está activado
else
  echo " " # Icono cuando Bloq Mayús está desactivado
fi
