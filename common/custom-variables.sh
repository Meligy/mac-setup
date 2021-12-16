if [[ -v DOTFILES_CUSTOM_VARIABLES_SET ]]; then
    return
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
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# coreutils
# If we do this, it replaces `mv` with a version that cannot handle renaming files
#
# PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
#
# So we do this instead:
export PATH="$PATH:/usr/local/opt/coreutils/libexec/gnubin"

# Homebrew
export PATH="/usr/local/bin:$PATH"

### ### ###
# Always keep this as last line
export DOTFILES_CUSTOM_VARIABLES_SET=1
### ### ###
