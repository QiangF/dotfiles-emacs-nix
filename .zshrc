autoload -Uz compinit promptinit
compinit 
promptinit

set -o vi

# Case-insensitive autocomplete
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Cool inline autocomplete preview
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(starship init zsh)"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

export EDITOR="nvim"
export GOPATH=${HOME}/code/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/.local/bin
source $HOME/.aliases

export PATH=$PATH:$HOME/.dotnet
export PATH=$PATH:$HOME/.emacs.d/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

alias gns3env="cd $HOME/code/gns3 && source env"
