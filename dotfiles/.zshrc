[[ ! -v DOTFILES_CUSTOM_VARIABLES_SET ]] && source $(dirname $(readlink $HOME/.zprofile))/../common/custom-variables.sh

# brew install -q zsh-completions
# if type brew &>/dev/null; then
# FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
export FPATH=/usr/local/share/zsh-completions:$FPATH
# # Thw following is run once at the end anyway
# autoload -Uz compinit
# compinit
# fi

# # GO
# export GOPATH=$HOME/go
# export GOROOT=/usr/local/opt/go/libexec
# export PATH=$PATH:$GOPATH/bin
# export PATH=$PATH:$GOROOT/bin

# # coreutils
# # If we do this, it replaces `mv` with a version that cannot handle renaming files
# #
# # PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
# #
# # So we do this instead:
# PATH="$PATH:/usr/local/opt/coreutils/libexec/gnubin"

# NVM
# Thw following is slow:
# # export NVM_DIR="$HOME/.nvm"
# # [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# So instead, lazy loading node utils, based on http://broken-by.me/lazy-load-nvm/

function nvm() {
  unset -f nvm
  if [ ! -s "$NVM_DIR/nvm.sh" ]; then
    export NVM_DIR="$HOME/.nvm"
    \. "$NVM_DIR/nvm.sh"
  fi
  nvm "$@"
}
function npm() {
  unset -f npm
  if [ ! -s "$NVM_DIR/nvm.sh" ]; then
    export NVM_DIR="$HOME/.nvm"
    \. "$NVM_DIR/nvm.sh"
  fi
  npm "$@"
}
function npx() {
  unset -f npx
  if [ ! -s "$NVM_DIR/nvm.sh" ]; then
    export NVM_DIR="$HOME/.nvm"
    \. "$NVM_DIR/nvm.sh"
  fi
  npx "$@"
}
function node() {
  unset -f node
  if [ ! -s "$NVM_DIR/nvm.sh" ]; then
    export NVM_DIR="$HOME/.nvm"
    \. "$NVM_DIR/nvm.sh"
  fi
  node "$@"
}

autoload -Uz compinit
compinit

# spaceship prompt
export FPATH=$HOME/.zfunctions:$FPATH
autoload -Uz promptinit
promptinit
# autoload -U promptinit; promptinit
prompt spaceship
