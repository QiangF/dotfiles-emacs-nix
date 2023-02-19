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
[ -f ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Case-insensitive autocomplete
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

####################
# Emacs

#   If you prefer to launch GUI Emacs from your terminal when editing files
#   replace the '-t' in the second line with '-c'
#   - https://www.emacswiki.org/emacs/EmacsClient

export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -tc"
export VISUAL="emacsclient -c -a emacs"

export TERM=xterm

####################
# Environment

export PATH=$PATH:$HOME/.local/bin

#   direnv
which direnv 2>&1 > /dev/null && eval "$(direnv hook zsh)"

#   firefox
export MOZ_ENABLE_WAYLAND=1

#   wayland
export QT_QPA_PLATFORM=wayland

#   go
export GOPATH=${HOME}/code/go
export PATH=$PATH:$GOPATH/bin

#   rust
export PATH=$PATH:$HOME/.cargo/bin
export CARGO_TARGET_DIR=$HOME/.cache/cargo/target/

#   dotnet
export PATH=$PATH:$HOME/.dotnet
export DOTNET_CLI_TELEMETRY_OPTOUT=1 # Opt-out of dotnet telemetry

#   Fixes freeze when dragging panels in Sway
# https://www.reddit.com/r/swaywm/comments/eua4cj/unity3d_doesnt_work_on_sway/
#export GDK_BACKEND=X11

#   python
export PYENV_ROOT="$HOME/.pyenv"
export PATH=$PATH:$PYENV_ROOT/bin

#   aliases
source $HOME/.aliases

#   gpg
eval $(keychain --quiet --noask)
# eval $(keychain --quiet --eval id_ed25519 --noask)

#   nix
export NIXPKGS_ALLOW_UNFREE=1

#   prompt
eval "$(starship init zsh)"

#   purplg/share-path.el
[[ -f "/tmp/emacs-share-path" ]] && [[ -d "$(cat /tmp/emacs-share-path)" ]] && \
  cd "$(/bin/cat /tmp/emacs-share-path)"
