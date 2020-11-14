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

# Zsh fzf autocompletions
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# Case-insensitive autocomplete
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

export EDITOR="nvim"

# Paths
export GOPATH=${HOME}/code/go
export PATH=$PATH:$GOPATH/bin
export PATH="$HOME/.cargo/bin:$PATH"
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.dotnet
export PATH=$PATH:$HOME/.emacs.d/bin

source $HOME/.aliases

eval $(keychain --quiet --agents ssh --eval $HOME/.ssh/id_store_srv)

eval "$(starship init zsh)"
