# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
 if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
 fi

# path
export PATH="$HOME/.local/bin:$PATH"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
export DENO_INSTALL="/home/migbert/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
#env
export VISUAL=nvim;
export EDITOR=nvim;
export SUDO_PROMPT="passwd: "

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

# enable completion features
autoload -Uz compinit
compinit -i

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive tab completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.config/zsh/.zcompcache"

# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories

# History configurations
HISTFILE="$HOME/.cache/.zsh_history"
HISTSIZE=10000
SAVEHIST=20000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# source plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.fzf/shell/key-bindings.zsh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#484E5B,underline"

# Git command
# Subir cambios a git
gitpush() {
echo Añadiendo cambios a Stage
  git add .
  echo commit Stage
    git commit -m "$*"
    echo Subiendo cambios a Origin
    git push
    echo Mostrando Log del repositorio
    sleep 2
    echo "\n ##### Mostrando Log del repositorio ##### \n"
git log --all --graph --decorate --oneline --abbrev-commit
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

# alias
alias gp=gitpush
alias glog='git log --all --graph --decorate --oneline --abbrev-commit'
alias gitu=gitpush
alias glog=gitlog
alias gbranch='git branch'
alias gcheck='git checkout'
alias gs='git status'
alias gitd=gitdelete
alias gitm=gitmerge
alias gitdc=gitdeletecommit

alias instalar='sudo pacman -S'
alias grub-update='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias mtar='tar -zcvf' # mtar <archive_compress>
alias utar='tar -zxvf' # utar <archive_decompress> <file_list>
alias z='zip -r' # z <archive_compress> <file_list>
alias uz='unzip' # uz <archive_decompress> -d <dir>
alias sr='source ~/.zshrc'
alias ..="cd .."
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e" 
alias mkdir="mkdir -p"
alias fm='ranger'
alias ls="exa --color=auto --icons"
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
alias upgrade='paru -Syu'

# init starship
# eval "$(starship init zsh)"
# setup starship custom prompt
# export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# arreglo de las teclas Supr y para recorrer la linea
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
