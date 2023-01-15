autoload -Uz compinit promptinit
compinit 
promptinit

####################
# Zsh preferences

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

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

# direnv
[[ $(which direnv) ]] && eval "$(direnv hook zsh)"

export PATH=$PATH:$HOME/.local/bin
export MOZ_ENABLE_WAYLAND=1

export QT_QPA_PLATFORM=wayland
export EDITOR="emacsclient"
export CARGO_TARGET_DIR=$HOME/.cache/cargo/target/

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

eval $(keychain --quiet --eval id_ed25519 --noask)

export NIXPKGS_ALLOW_UNFREE=1

# Starship prompt
eval "$(starship init zsh)"

[[ -f "/tmp/emacs-share-path" ]] && [[ -d "$(cat /tmp/emacs-share-path)" ]] && \
  cd "$(/bin/cat /tmp/emacs-share-path)"
