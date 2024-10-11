#!/bin/bash
# Alternar el estado de la interfaz wg0
if sudo wg show wg0 &> /dev/null; then
    sudo wg-quick down wg0
else
    sudo wg-quick up wg0
fi
