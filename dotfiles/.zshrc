[[ ! -v DOTFILES_CUSTOM_VARIABLES_SET ]] && source $(dirname $(readlink $HOME/.zprofile))/../common/custom-variables.zsh

# brew install -q zsh-completions
# if type brew &>/dev/null; then
# FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
export FPATH=$HOMEBREW_PREFIX/share/zsh-completions:$FPATH
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

# function nvm() {
#   unset -f nvm
#   if [ ! -s "$NVM_DIR/nvm.sh" ]; then
#     export NVM_DIR="$HOME/.nvm"
#     \. "$NVM_DIR/nvm.sh"
#   fi
#   nvm "$@"
# }
# function npm() {
#   unset -f npm
#   if [ ! -s "$NVM_DIR/nvm.sh" ]; then
#     export NVM_DIR="$HOME/.nvm"
#     \. "$NVM_DIR/nvm.sh"
#   fi
#   npm "$@"
# }
# function npx() {
#   unset -f npx
#   if [ ! -s "$NVM_DIR/nvm.sh" ]; then
#     export NVM_DIR="$HOME/.nvm"
#     \. "$NVM_DIR/nvm.sh"
#   fi
#   npx "$@"
# }
# function node() {
#   unset -f node
#   if [ ! -s "$NVM_DIR/nvm.sh" ]; then
#     export NVM_DIR="$HOME/.nvm"
#     \. "$NVM_DIR/nvm.sh"
#   fi
#   node "$@"
# }

# if type brew &>/dev/null
# then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
# fi

# autoload -Uz compinit
# compinit

# spaceship prompt
export FPATH=$HOME/.zfunctions:$FPATH
autoload -Uz promptinit
promptinit
# autoload -U promptinit; promptinit
prompt spaceship

# bash completions for ZSH
# Based on https://scriptingosx.com/2019/07/moving-to-zsh-part-5-completions/
autoload bashcompinit && bashcompinit

# Based on https://learn.microsoft.com/en-us/dotnet/core/tools/enable-tab-autocomplete#zsh
# zsh parameter completion for the dotnet CLI
_dotnet_zsh_complete() 
{
  local completions=("$(dotnet complete "$words")")

  # If the completion list is empty, just continue with filename selection
  if [ -z "$completions" ]
  then
    _arguments '*::arguments: _normal'
    return
  fi

  # This is not a variable assignment, don't remove spaces!
  _values = "${(ps:\n:)completions}"
}
compdef _dotnet_zsh_complete dotnet

conda config --set auto_activate_base false
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="$PATH:/opt/homebrew/anaconda3/bin"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export VOLTA_HOME="$HOME/.volta"
export PATH="$PATH:$VOLTA_HOME/bin"
. $(brew --prefix asdf)/libexec/asdf.sh

export PATH="$PATH:$HOME/.asdf/shims"

export PATH="$PATH:/Applications/Rider.app/Contents/MacOS"

# devtunnel
export PATH="$PATH:$HOME/bin"

# not sure what wrote that:
#
# export PATH=/Users/meligy/.asdf/shims:/opt/homebrew/opt/asdf/libexec/bin:/opt/homebrew/anaconda3/condabin:/Users/meligy/Library/Python/3.9/bin:/opt/homebrew/anaconda3/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/share/dotnet:~/.dotnet/tools:/Library/Apple/usr/bin:/Library/Frameworks/Mono.framework/Versions/Current/Commands:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/Users/meligy/Library/Android/sdk/cmdline-tools/latest/bin:/Users/meligy/Library/Android/sdk/cmdline-tools/tools/bin:/Users/meligy/go/bin:/opt/homebrew/opt/go/libexec/bin:/opt/homebrew/opt/coreutils/libexec/gnubin:/opt/homebrew/bin:/Users/meligy/.dotnet/tools:/Users/meligy/.docker/bin:/Users/meligy/.volta/bin:/Applications/Rider.app/Contents/MacOS:/Users/meligy/bin


# bun completions
[ -s "/Users/meligy/.bun/_bun" ] && source "/Users/meligy/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
