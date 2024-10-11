#!/bin/bash 
# programa en bash para respaldar mis dotfiles
#############################################################

#neovim
function bk_neovim(){
  echo -e "\nRespaldando Configuracion de Neovim....";
  mkdir -p nvim/.config/nvim
	cp -rfT ~/.config/nvim/ nvim/.config/nvim
}

#Main function
function main(){
echo "Respaldando dotfiles";

 echo -e "[?] Respaldar mi configuracion de Neovim? (y/n)";
	read -n1 option
	if [ "$option" == "y" ]; then
		bk_neovim
	fi
}

#Call main function
main
#Call git 
git -v >& /dev/null
if [ $? -ne 0 ]; then
	#Git is installed 
	#Call git diff 
	echo -e "[?] Mostrar git diff (y/n)";
	read -n1 option
	if [ "$option" == "y" ]; then
		git diff	
	fi

fi

echo -e "\nFin del Script";
