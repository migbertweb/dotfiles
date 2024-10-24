# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#  ╔═╗╔═╗╦ ╦╦═╗╔═╗  ╔═╗╔═╗╔╗╔╔═╗╦╔═╗	- z0mbi3
#  ╔═╝╚═╗╠═╣╠╦╝║    ║  ║ ║║║║╠╣ ║║ ╦	- https://github.com/gh0stzk/dotfiles
#  ╚═╝╚═╝╩ ╩╩╚═╚═╝  ╚═╝╚═╝╝╚╝╚  ╩╚═╝	- My zsh conf

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#  ┬  ┬┌─┐┬─┐┌─┐
#  └┐┌┘├─┤├┬┘└─┐
#   └┘ ┴ ┴┴└─└─┘
export VISUAL="${EDITOR}"
export EDITOR='nvim'
export BROWSER='google-chrome-stable'
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export SUDO_PROMPT="Acceso Root para %u. por favor su Contraseña: "
export BAT_THEME="base16"

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

#  ┬  ┌─┐┌─┐┌┬┐  ┌─┐┌┐┌┌─┐┬┌┐┌┌─┐
#  │  │ │├─┤ ││  ├┤ ││││ ┬││││├┤
#  ┴─┘└─┘┴ ┴─┴┘  └─┘┘└┘└─┘┴┘└┘└─┘
autoload -Uz compinit

for dump in ~/.config/zsh/zcompdump(N.mh+24); do
  compinit -d ~/.config/zsh/zcompdump
done

compinit -C -d ~/.config/zsh/zcompdump

autoload -Uz add-zsh-hook
autoload -Uz vcs_info
precmd () { vcs_info }
_comp_options+=(globdots)

zstyle ':completion:*' verbose true
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=48;5;197;1'
zstyle ':completion:*' matcher-list \
		'm:{a-zA-Z}={A-Za-z}' \
		'+r:|[._-]=* r:|=*' \
		'+l:|=*'
zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d%b"
zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'
zstyle ':vcs_info:*' formats ' %B%s-[%F{magenta}%f %F{yellow}%b%f]-'

#  ┬ ┬┌─┐┬┌┬┐┬┌┐┌┌─┐  ┌┬┐┌─┐┌┬┐┌─┐
#  │││├─┤│ │ │││││ ┬   │││ │ │ └─┐
#  └┴┘┴ ┴┴ ┴ ┴┘└┘└─┘  ─┴┘└─┘ ┴ └─┘
expand-or-complete-with-dots() {
  echo -n "\e[31m…\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

#  ┬ ┬┬┌─┐┌┬┐┌─┐┬─┐┬ ┬
#  ├─┤│└─┐ │ │ │├┬┘└┬┘
#  ┴ ┴┴└─┘ ┴ └─┘┴└─ ┴
HISTFILE=~/.config/zsh/zhistory
HISTSIZE=999
SAVEHIST=5000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

#  ┌─┐┌─┐┬ ┬  ┌─┐┌─┐┌─┐┬    ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌┌─┐
#  ┌─┘└─┐├─┤  │  │ ││ ││    │ │├─┘ │ ││ ││││└─┐
#  └─┘└─┘┴ ┴  └─┘└─┘└─┘┴─┘  └─┘┴   ┴ ┴└─┘┘└┘└─┘
setopt AUTOCD              # change directory just by typing its name
setopt PROMPT_SUBST        # enable command substitution in prompt
setopt MENU_COMPLETE       # Automatically highlight first element of completion menu
setopt LIST_PACKED		   # The completion menu takes less space.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.

#  ┌┬┐┬ ┬┌─┐  ┌─┐┬─┐┌─┐┌┬┐┌─┐┌┬┐
#   │ ├─┤├┤   ├─┘├┬┘│ ││││├─┘ │
#   ┴ ┴ ┴└─┘  ┴  ┴└─└─┘┴ ┴┴   ┴

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# function dir_icon {
#   if [[ "$PWD" == "$HOME" ]]; then
#     echo "%B%F{cyan}%f%b"
#   else
#     echo "%B%F{cyan}%f%b"
#   fi
# }
#
# PS1='%B%F{blue}%f%b  %B%F{magenta}%n%f%b $(dir_icon)  %B%F{red}%~%f%b${vcs_info_msg_0_} %(?.%B%F{green}.%F{red})%f%b '

# command not found
command_not_found_handler() {
	printf "%s%s? No se que es eso\n" "$acc" "$0" >&2
    return 127
}

#  ┌─┐┬  ┬ ┬┌─┐┬┌┐┌┌─┐
#  ├─┘│  │ ││ ┬││││└─┐
#  ┴  ┴─┘└─┘└─┘┴┘└┘└─┘
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[[3~' delete-char


#  ┌─┐┬  ┬┌─┐┌─┐
#  ├─┤│  │├─┤└─┐
#  ┴ ┴┴─┘┴┴ ┴└─┘
#####################################
############ Tmux ###################
# Iniciar o adjuntar a una sesión de tmux
alias ta='tmux attach -t'
alias tn='tmux new -s'
# Listar sesiones
alias tls='tmux ls'
# Desconectar de una sesión
alias td='tmux detach'
# Terminar una sesión
alias tk='tmux kill-session -t'
# Crear una nueva ventana en la sesión actual
alias tnew='tmux new-window'
# Cerrar un panel
alias tkillp='tmux kill-pane'
# Sincronizar paneles (para que todos reciban los mismos comandos)
alias tsync-on='tmux set-window-option synchronize-panes on'
alias tsync-off='tmux set-window-option synchronize-panes off'
# Renombrar sesión
alias tname='tmux rename-session -t'
############ GIT ####################
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
alias mirrors="sudo reflector --verbose --latest 5 --country 'United States' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"

alias update="paru -Syu --nocombinedupgrade"

alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"

alias music="ncmpcpp"

## ---- Eza (better ls) -----
alias ls="eza --long --color=auto --icons --all --git --no-time --no-filesize --no-permissions --no-user --grid --sort=type"
alias ll='eza --icons=always --color=always -la'

alias gitu=gitpush

alias cl='clear'

#####################################################
# PACMAN
alias instalar='sudo pacman -Sy'
alias quitar='sudo pacman -Rs'
alias quitartodo='sudo pacman -Rns'
# Actualizar sistema actualizando la base de datos de paquetes previamente (Uso recomendado).
alias upgrade='sudo pacman -Syyu --noconfirm'
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
###################
# Alias Laravel
alias pas="php artisan serve"

#################################
#  ┌─┐┬ ┬┌┬┐┌─┐  ┌─┐┌┬┐┌─┐┬─┐┌┬┐
#  ├─┤│ │ │ │ │  └─┐ │ ├─┤├┬┘ │
#  ┴ ┴└─┘ ┴ └─┘  └─┘ ┴ ┴ ┴┴└─ ┴
# $HOME/.local/bin/colorscript -r

#################################
############# FZF ###############
#################################

source <(fzf --zsh)


# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"


# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

###############
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# ----- Bat (better cat) -----

export BAT_THEME=tokyonight_night

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd="z"
