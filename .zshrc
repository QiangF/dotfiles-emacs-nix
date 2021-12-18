autoload -Uz compinit promptinit
compinit 
promptinit

####################
# Zsh preferences

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# fzf autocompletions
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Case-insensitive autocomplete
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

export EDITOR="nvim"
export TERM=xterm

####################
# Environment

export PATH=$PATH:$HOME/.local/bin
export MOZ_ENABLE_WAYLAND=1

# Haskell
#[ -f "/home/purplg/.ghcup/env" ] && source "/home/purplg/.ghcup/env" # ghcup-env

export GOPATH=${HOME}/code/go
export PATH=$PATH:$GOPATH/bin

export PATH=$PATH:$HOME/.cargo/bin

export PATH=$PATH:$HOME/.dotnet

export PATH=$PATH:$HOME/.emacs.d/bin
export PATH=$PATH:$HOME/.emacs.profiles.d/doom/bin

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH=$PATH:$PYENV_ROOT/bin

# Aliases
source $HOME/.aliases

# Starship prompt
eval "$(starship init zsh)"
