if [[ -v DOTFILES_CUSTOM_VARIABLES_SET ]]; then
    return
fi

# Homebrew
if [[ $(uname -p) == 'arm' ]]
  then
    export HOMEBREW_PREFIX="/opt/homebrew"
  else
    export HOMEBREW_PREFIX="/usr/local"
fi

# jenv
# Docs suggest you put this in .zshrc but here is faster, see https://developer.bring.com/blog/configuring-jenv-the-right-way/
#export PATH="$HOME/.jenv/bin:$PATH"

# Android
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
# Via https://stackoverflow.com/a/61176718/146656
export PATH=$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/cmdline-tools/tools/bin

# Some apps, like JavaScript debugging extension for VS Code, require node to be in PATH
# We override the node executables later so they refer to current nvm version not latest
# NVM_DIR="$HOME/.nvm" // Do not make it available
export PATH="$(ls -td $HOME/.nvm/versions/node/* | head -n 1)/bin:$PATH"

# GO
export GOPATH=$HOME/go
export GOROOT=$HOMEBREW_PREFIX/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# coreutils
#
# If we do this:
# PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
# it replaces `mv` with a version that cannot handle renaming files
# So we do this instead:
# export PATH="$PATH:$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
#
# Update: above seems fixed, so trying proper way:
export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"

# dotnet
# Based on https://docs.microsoft.com/en-us/dotnet/core/install/macos
# ** do NOT change `/usr/local` to $HOMEBREW_PREFIX here. For dotnet, it's not **
export DOTNET_ROOT="/usr/local/share/dotnet"
export PATH="$DOTNET_ROOT:$PATH:$DOTNET_ROOT/x64/dotnet"

# Homebrew
export PATH="$HOMEBREW_PREFIX/bin:$PATH"

### ### ###
# Always keep this as last line
export DOTFILES_CUSTOM_VARIABLES_SET=1
### ### ###
