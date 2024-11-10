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
customdeps=(gh0stzk-gtk-themes gh0stzk-cursor-qogirr \
			gh0stzk-icons-beautyline gh0stzk-icons-candy gh0stzk-icons-catppuccin-mocha gh0stzk-icons-dracula gh0stzk-icons-glassy \
			gh0stzk-icons-gruvbox-plus-dark gh0stzk-icons-hack gh0stzk-icons-luv gh0stzk-icons-sweet-rainbow gh0stzk-icons-tokyo-night \
			gh0stzk-icons-vimix-white gh0stzk-icons-zafiro gh0stzk-icons-zafiro-purple)

printf "%s%sChecking for required custom packages...%s\n" "${BLD}" "${CBL}" "${CNC}"
for cpaquete in "${customdeps[@]}"; do
    if ! is_installed "$cpaquete"; then
        if sudo pacman -S "$cpaquete" --noconfirm >/dev/null 2>> RiceError.log; then
            printf "%s%s%s %shas been installed succesfully.%s\n" "${BLD}" "${CYE}" "$cpaquete" "${CBL}" "${CNC}"
            sleep 1
        else
            printf "%s%s%s %shas not been installed correctly. See %sRiceError.log %sfor more details.%s\n" "${BLD}" "${CYE}" "$cpaquete" "${CRE}" "${CBL}" "${CRE}" "${CNC}"
            sleep 1
        fi
    else
        printf '%s%s%s %sis already installed on your system!%s\n' "${BLD}" "${CYE}" "$cpaquete" "${CGR}" "${CNC}"
        sleep 1
    fi
done
sleep 5
clear