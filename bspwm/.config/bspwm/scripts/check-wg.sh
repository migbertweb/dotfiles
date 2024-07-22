#!/bin/bash
# Verifica si la interfaz wg0 está activa
if sudo wg show wg0 &>/dev/null; then
  echo "VPN  "
else
  echo "VPN  "
fi
