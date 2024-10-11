# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
#####################################################
##### PATH
#####################################################
export PATH="$HOME/.local/bin:$PATH"
# export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export DENO_INSTALL="/home/migbert/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="$HOME/.config/composer/vendor/bin/:$PATH"
export PATH="$PATH:/snap/bin"
#####################################################
##### ENV
#####################################################
export VISUAL=nvim;
export EDITOR=nvim;
export SUDO_PROMPT="Su contraseña Sr: "
#####################################################
##### VirtualEnv de Python
####################################################
export PATH="/usr/bin/python:$PATH"
# export PROJECT_HOME=$HOME/proyectos/python
# source /bin/virtualenvwrapper.sh
fpath+=~/.zfunc
###################################################
setopt autocd              # change directory just by typing its name
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
#setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
#setopt promptsubst         # enable command substitution in prompt
setopt MENU_COMPLETE       # Automatically highlight first element of completion menu
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
####################################################
# enable completion features
autoload -Uz compinit
compinit -i

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive tab completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.config/zsh/.zcompcache"
####################################################
# Define completers
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
####################################################
# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
####################################################
# History configurations
HISTFILE="$HOME/.cache/.zsh_history"
HISTSIZE=1000
SAVEHIST=2000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
#####################################################
##### SOURCE PLUGINS
#####################################################
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
#source /usr/share/fzf/key-bindings.zsh
#source /usr/share/fzf/completion.zsh
# source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#484E5B,underline"
####################################################
##### FUNCIONES BASH
#####################################################
# Git command
# Commit
gitcommit(){
    echo "########## Añadiendo cambios a Stage ##########"
    git add -v .
    sleep 1
    echo "########## Commit ##########"
    git commit -m "$*"
    sleep 1
}
# Subir cambios a git
gitpush() {
    echo "########## Añadiendo cambios a Stage ##########"
    git add -v .
    sleep 1
    echo "########## Estado del Commit ##########"
    git commit -m "$*"
    sleep 1
    echo "########## Subiendo cambios a Origin ##########"
    git push
    sleep 1
    echo "\n ########## Mostrando Log del repositorio ########## \n"
    git log -5 --graph --oneline --abbrev-commit --pretty=format:"%h - %an, %ar : %s"
    echo "Fin \n"
}
# borrar una rama Remota
gitdelete() {
    echo "\n ##### borrar rama remota ##### \n"
    git push origin --delete "$*"
    sleep 2
    echo "\n ##### Mostrando Log del repositorio ##### \n"
    git log --all --graph --decorate --oneline --abbrev-commit
}
# fusionar ramas de git
gitmerge() {
    echo "\n ##### Fusionar ramas de git ##### \n"
    git merge --no-ff "$*"
    sleep 2
    echo "\n ##### Mostrando Log del repositorio ##### \n"
    git log --all --graph --decorate --oneline --abbrev-commit
}
# eliminar commit
gitdeletecommit() {
    echo "\n ##### borrar rama remota ##### \n"
    git push origin --delete "$*"
    echo "\n ##### Mostrando Log del repositorio ##### \n"
    git log --all --graph --decorate --oneline --abbrev-commit
}
# mostrar el log de git
gitlog() {
    echo "\n ##### Mostrando el Log Graph ##### \n"
    sleep 2
    git log --all --graph --decorate --oneline --abbrev-commit
}
#####################################################
##### ALIAS
#####################################################
# alias bat='batcat'
alias cl='clear'
# APT
#instalar='sudo nala install'
#alias desintalar='sudo nala remove'
#alias upgrade='sudo nala update && sudo nala upgrade -y --purge && sudo nala autoremove -y'
#####################################################  
# PACMAN	
alias instalar='sudo pacman -Sy'
alias quitar='sudo pacman -Rs'
alias quitartodo='sudo pacman -Rns'
# Actualizar sistema actualizando la base de datos de paquetes previamente (Uso recomendado).
alias upgrade='sudo pacman -Syyu --noconfirm && sudo pacman-optimize'
# Paquetes huérfanos (Ya no son dependencia de ningún paquete).
#alias p-huerfanos='sudo pacman -Qtdq'                # Lista paquetes huérfanos.
alias phuerfanos='sudo pacman -Rs $(pacman -Qtdq)'  # Elimina paquetes huérfanos.
# Elimina de la cache todos los paquetes menos los actualmente instalados. (Impide un Rollback).
# Permite también quitar repositorios no utilizados.
alias pclean='sudo pacman -Sc'
alias plimp='sudo pacman -Scc'  # Solo en casos de necesidad (Ej. Disco duro lleno).
# Optimizar base de datos de pacman (fragmentación).
# pacman-optimize
alias desbloquearpacman='sudo rm /var/lib/pacman/db.lck'
#####################################################
alias v='nvim'
alias ,,='cd ~'
###########
## Alias Git
###########
alias gi='git init'
alias ga='git add .'
alias gc=gitcommit
alias gp=gitpush
alias glog='git log --all --graph --decorate --oneline --abbrev-commit'
alias gitu=gitpush
alias glog=gitlog
alias gbranch='git branch'
alias gcheck='git checkout'
alias gs='git status -s'
alias gitd=gitdelete
alias gitm=gitmerge
alias gitdc=gitdeletecommit

alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias mtar='tar -zcvf' # mtar <archive_compress>
alias utar='tar -zxvf' # utar <archive_decompress> <file_list>
alias z='zip -r' # z <archive_compress> <file_list>
alias uz='unzip' # uz <archive_decompress> -d <dir>
alias sr='source ~/.zshrc'
alias ..="cd .."
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias mkdir="mkdir -p"
alias fm='ranger'
alias ls="exa --long --color=auto --icons --all --git --no-permissions --no-user --grid --sort=type"
alias l="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias lt="ls --tree"
alias cat="bat --color always --plain"
alias grep='grep --color=auto'
alias v='nvim'
alias mv='mv -v'
alias cp='cp -vr'
alias rm='rm -vr'
###################
# Alias Laravel
alias pas="php artisan serve"
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'
#####################################################
# Alias DOCKER
alias dk='docker'
alias dki='docker images'
alias dkls='docker ps'
alias dkps='docker ps'
alias dkpsa='docker ps -a'
alias dkv='docker version'
alias dkw='docker wait'
alias dkx='docker stop'
## Container (C)
alias dkC='docker container'
alias dkCa='docker container attach'
alias dkCcp='docker container cp'
## Image (I)
alias dkI='docker image'
alias dkIb='docker image build'
## Network (N)
alias dkN='docker network'
alias dkNs='docker network connect'
alias dkNx='docker network disconnect'
alias dkNin='docker network inspect'
alias dkNls='docker network ls'
alias dkNpr='docker network prune'
alias dkNrm='docker network rm'
# Docker Compose (c)
alias docker-compose='docker compose'
alias dkc='docker-compose'
alias dkcb='docker-compose build'
alias dkcB='docker-compose build --no-cache'
alias dkccf='docker-compose config'
alias dkccr='docker-compose create'
alias dkcd='docker-compose down'
alias dkci='docker-compose images'
alias dkck='docker-compose kill'
alias dkcl='docker-compose logs'
alias dkcL='docker-compose logs -f'
alias dkcls='docker-compose ps'
alias dkcp='docker-compose pause'
alias dkcP='docker-compose unpause'
alias dkcpo='docker-compose port'
alias dkcps='docker-compose ps'
alias dkcS='docker-compose restart'
alias dkct='docker-compose top'
alias dkcu='docker-compose up'
alias dkcU='docker-compose up -d'
alias dkcx='docker-compose stop'


#####################################################
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
#####################################################
# Buscador FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#####################################################
# arreglo de las teclas Supr y para recorrer la linea
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
#source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
#####################################################
# pyenv
######################################################
# export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
# source /usr/share/nvm/init-nvm.sh
# eval "$(pyenv virtualenv-init -)"

# #############################
# Flutter config
# ####################
#android home
# export ANDROID_HOME=/usr/lib/Android
# export PATH=$ANDROID_HOME/cmdline-tools:$PATH
# export PATH=$ANDROID_HOME/cmdline-tools/tools/:$PATH
# export PATH=$ANDROID_HOME/cmdline-tools/tools/bin:$PATH
# export PATH=$ANDROID_HOME/emulator/:$PATH
# export PATH=$ANDROID_HOME/platform-tools:$PATH

#android sdk root
# export ANDROID_SDK_ROOT=/usr/lib/Android
# export PATH=$ANDROID_SDK_ROOT:$PATH

#flutter
# export FLUTTER_HOME=/usr/lib/flutter
# export PATH=$FLUTTER_HOME/bin:$PATH

#gradle
# export GRADLE_HOME=/opt/gradle/gradle-8.1.1
# export PATH=$GRADLE_HOME/bin:$PATH

# #############################
# Add .NET Core SDK tools
# export PATH="$PATH:/home/migbert/.dotnet/tools"

# zsh parameter completion for the dotnet COMPLETE_IN_WORD
# _dotnet_zsh_complete(){
#     local completions=("$(dotnet complete "$words")")
#     # If the completion list is empty, just continue with filename selection
#     if [ -z "$completions" ]
#     then
#         _arguments '*::arguments: _normal'
#         return
#     fi
#     # This is not a variable assignment, don't remove spaces!
#     _values = "${(ps:\n:)completions}"
# }
# compdef _dotnet_zsh_complete dotnet
################################################
#### NVIMS
#################################################
# git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/AstroNvim
# git clone git@github.com:nvim-lua/kickstart.nvim.git ~/.config/kickstart
# git clone https://github.com/NvChad/NvChad ~/.config/NvChad --depth 1
# git clone https://github.com/LazyVim/starter ~/.config/LazyVim
#alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
#alias nvim-kick="NVIM_APPNAME=kickstart nvim"
#alias nvim-chad="NVIM_APPNAME=NvChad nvim"
#alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
#function nvims() {
#    items=("default" "kickstart" "LazyVim" "NvChad" "AstroNvim")
#    config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
#    if [[ -z $config ]]; then
#        echo "Nothing selected"
#        return 0
#    elif [[ $config == "default" ]]; then
#        config=""
#    fi
#    NVIM_APPNAME=$config nvim $@
#}
#bindkey -s ^a "nvims\n"

#. ~/.dotnet-suggest-shim.zsh

