# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
#
#
export VISUAL="${EDITOR}"
export EDITOR='nvim'
export BROWSER='firefox'
export HISTORY_IGNORE="(ls|pwd|exit|sudo reboot|history)"
export SUDO_PROMPT="Implementando acceso root para %u. Contraseña, por favor: "
# ----- Bat (better cat) -----
export BAT_THEME=tokyonight_night

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi
# composer path
if [ -d "$HOME/.config/composer/vendor/bin" ] ;
  then PATH="$HOME/.config/composer/vendor/bin:$PATH"
fi
# INSTALACION DE ZINIT
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load powerlevel10k theme
zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

# PLUGINS
zinit light marlonrichert/zsh-autocomplete
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light Aloxaf/fzf-tab

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# OPTIONS
HISTFILE=~/.config/zsh/zhistory
HISTSIZE=1000
SAVEHIST=1000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu yes
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:*' fzf-flags --style=full --height=90% --pointer '>' \
                --color 'pointer:green:bold,bg+:-1:,fg+:green:bold,info:blue:bold,marker:yellow:bold,hl:gray:bold,hl+:yellow:bold' \
                --input-label ' Search ' --color 'input-border:blue,input-label:blue:bold' \
                --list-label ' Results ' --color 'list-border:green,list-label:green:bold' \
                --preview-label ' Preview ' --color 'preview-border:magenta,preview-label:magenta:bold'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons=always --color=always -a $realpath'
zstyle ':fzf-tab:complete:eza:*' fzf-preview 'eza -1 --icons=always --color=always -a $realpath'
zstyle ':fzf-tab:complete:bat:*' fzf-preview 'bat --color=always --theme=base16 $realpath'
zstyle ':fzf-tab:*' fzf-bindings 'space:accept'
zstyle ':fzf-tab:*' accept-line enter

# ALIAS
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
## ---- GIT -----
alias gitu=gitpush
alias gst='git status -s -b && git log --oneline --decorate -n 5'
## Alias
alias mirrors="sudo reflector --verbose --latest 5 --country 'United States' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"
alias update="paru -Syu --nocombinedupgrade"
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias music="ncmpcpp"
alias cat="bat"
alias ls='exa --long --color=auto --icons --git --no-time --no-filesize --no-permissions --no-user --grid --sort=type'
alias la='exa --long --color=auto --icons --all --git --no-time --no-filesize --no-permissions --no-user --grid --sort=type'
alias ll='eza --icons=always --color=always -la'
alias v='nvim'
alias cl='clear'
# PACMAN
alias update="paru -Syu --skipreview --nocombinedupgrade"
alias instalar='sudo pacman -Sy'
# pacman-optimize
alias desbloquearpacman='sudo rm /var/lib/pacman/db.lck'
# 

# KUBERNETES
alias k='kubectl'
alias kc='kubectl'
alias kga='kubectl get --all-namespaces'
alias klf='kubectl logs -f'
alias kds='kubectl describe service'
alias kgi='kubectl get ingress'
alias kgiy='kubectl get ingress -o yaml'
alias kgsc='kubectl get secrets'
alias kgscy='kubectl get secrets -o yaml'
alias kgs='kubectl get services'
alias kgsy='kubectl get services -o yaml'
alias kgp='kubectl get pods'
alias kgpy='kubectl get pods -o yaml'
alias ktp='kubectl top pods'
# Deployments
alias kdd='kubectl delete deployment'
alias ked='kubectl edit deployments'
alias kgd='kubectl get deployments'
# endpoints
alias kgep='kubectl get endpoints'
# events
alias kgev='kubectl get events'
############# from file ################
alias kaf='kubectl apply -f'
alias kcf='kubectl create -f'
alias kdf='kubectl delete -f'
alias kef='kubectl edit -f'
alias kdsf='kubectl describe -f'
alias kgf='kubectl get -f'
########################################
alias kgns='kubectl get namespaces'
alias kgnsy='kubectl get namespaces -o yaml'
# Nodes
alias kgn='kubectl get nodes'
alias kgny='kubectl get nodes -o yaml'
alias ktn='kubectl top nodes'
########################################
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
#########################
# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

