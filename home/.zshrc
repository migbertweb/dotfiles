# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
#
#
export VISUAL="${EDITOR}"
export EDITOR='vscodium --wait'
export BROWSER='brave'
export HISTORY_IGNORE="(ls|pwd|exit|sudo reboot|history)"
export SUDO_PROMPT="Implementando acceso root para %u. Contraseña, por favor: "
export GEMINI_API_KEY="AIzaSyB6waRuqI10PDklrAylhjjmSVz50jSdUlU"

# ----- Bat (better cat) -----
export BAT_THEME=Dracula

# ----- KUSTOMIZE -----
export KUSTOMIZE_PLUGIN_HOME=$HOME/.config/kustomize/plugins
export XDG_CONFIG_HOME=$HOME/.config
export KUSTOMIZE_ENABLE_ALPHA_PLUGINS=true

# ----- export sops -----
export SOPS_AGE_KEY_FILE="$HOME/.config/sops/age/keys.txt"
export IDF_PATH="$HOME/.esp-idf/v5.5.1/esp-idf"

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
zinit light dracula/zsh
zinit light dracula/zsh-syntax-highlighting


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
alias instalar='sudo pacman -Sy --needed'
# pacman-optimize
alias desbloquearpacman='sudo rm /var/lib/pacman/db.lck'
#

# KUBERNETES
alias kaf='kubectl apply -f'
alias kdf='kubectl delete -f'
alias kl='kubectl logs'
alias kga='kubectl get all --all-namespaces'
alias klf='kubectl logs -f'
alias kds='kubectl describe service'
alias kef='kubectl edit -f'
alias kcns='kubectl create namespace'
alias kgns='kubectl get namespaces'
alias kgan='kubectl get all --namespace'
alias kdn='kubectl delete namespace'
alias kgn='kubectl get nodes'
alias ktn='kubectl top nodes'
alias kgp='kubectl get pods'
alias kgpn='kubectl get pods --namespace'
alias kdp='kubectl describe pod'
alias kdpn='kubectl describe pod --namespace'
alias kgc='kubectl get certificates --all-namespaces'
alias kgcn='kubectl get certificates --namespace'
# HELM
alias hla='helm list --all-namespaces'
alias hu='helm uninstall'
alias hi='helm install'
alias hup='helm upgrade --install'
alias hga='helm get all'

################ SOPS PARA ENCRYPTAR ########################
sops_encrypt() {
    local input_file="$1"
    local encrypt_success=false

    # Verificar si el archivo ya está encriptado (extensión .enc.yaml)
    if [[ "$input_file" == *.enc.yaml ]]; then
        echo "❌ El archivo ya parece estar encriptado (.enc.yaml)"
        return 1
    fi

    # Encriptar el archivo IN-PLACE (sin crear copia)
    if sops --encrypt --age=$(cat ~/.config/sops/age/age-key.pub) -i "$input_file"; then
        # Renombrar a .enc.yaml (manteniendo in-place)
        mv "$input_file" "${input_file%.yaml}.enc.yaml"
        echo "✅ Archivo encriptado y renombrado: ${input_file%.yaml}.enc.yaml"
        return 0
    else
        echo "❌ Error al encriptar el archivo"
        return 1
    fi
}

sops_decrypt() {
    local input_file="$1"

    # Verificar formato de archivo encriptado
    if [[ "$input_file" != *.enc.yaml ]]; then
        echo "❌ El archivo no parece estar encriptado (debe terminar en .enc.yaml)"
        return 1
    fi

    local output_file="${input_file%.enc.yaml}.yaml"

    # Verificar si ya existe el archivo desencriptado
    if [[ -f "$output_file" ]]; then
        echo "⚠️  El archivo $output_file ya existe. ¿Sobrescribir? (y/n)"
        read response
        [[ "$response" != "y" ]] && echo "Operación cancelada." && return 1
    fi

    # Desencriptar (usando redirección para evitar modificar el original)
    if sops --decrypt "$input_file" > "$output_file"; then
        echo "✅ Archivo desencriptado: $output_file"
        return 0
    else
        echo "❌ Error al desencriptar"
        rm -f "$output_file"  # Limpiar archivo parcial si falla
        return 1
    fi
}

# Alias
alias encrypt='sops_encrypt'
alias decrypt='sops_decrypt'
alias edit-encrypted='sops'
alias ver-encrypted='sops --decrypt'
##### Alias para kustomize #####
alias kusto-b='kustomize build --enable-alpha-plugins --enable-exec'
alias kustomize='kustomize --enable-alpha-plugins --enable-exec'
alias kusfp='kustomize build --enable-alpha-plugins --enable-exec overlays/prod | kubectl apply -f -'
alias kusfs='kustomize build --enable-alpha-plugins --enable-exec overlays/staging | kubectl apply -f -'
alias kusfd='kustomize build --enable-alpha-plugins --enable-exec overlays/dev | kubectl apply -f -'
########################################
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
#########################
# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

if [ -e /home/migbert/.nix-profile/etc/profile.d/nix.sh ]; then . /home/migbert/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# opencode
export PATH=/home/migbert/.opencode/bin:$PATH

# . $HOME/.esp-idf/v5.5.1/esp-idf/export.sh