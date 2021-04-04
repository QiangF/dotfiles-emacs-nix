autoload -Uz compinit promptinit
compinit 
promptinit

####################
# Zsh preferences

# Vi-mode
set -o vi
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# fzf autocompletions
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
#source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Case-insensitive autocomplete
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

export EDITOR="nvim"

####################
# Environment

export PATH=$PATH:$HOME/.local/bin

# Haskell
#[ -f "/home/purplg/.ghcup/env" ] && source "/home/purplg/.ghcup/env" # ghcup-env

export GOPATH=${HOME}/code/go
export PATH=$PATH:$GOPATH/bin

export PATH=$PATH:$HOME/.cargo/bin

export PATH=$PATH:$HOME/.dotnet

export PATH=$PATH:$HOME/.emacs.d/bin

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH=$PATH:$PYENV_ROOT/bin

# Aliases
source $HOME/.aliases

# Init keychain
eval $(keychain --quiet --agents ssh --eval $HOME/.ssh/id_store_srv)

# Starship prompt
eval "$(starship init zsh)"
