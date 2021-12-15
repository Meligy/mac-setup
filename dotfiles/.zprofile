[[ ! -v DOTFILES_CUSTOM_VARIABLES_SET ]] && source $(dirname $(readlink $HOME/.zprofile))/../common/custom-variables.sh

# export PATH="/usr/local/bin:$PATH"

# brew install -q coreutils
# export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
# # jenv
# # Docs suggest you put this in .zshrc but here is faster, see https://developer.bring.com/blog/configuring-jenv-the-right-way/
# export PATH="$HOME/.jenv/bin:$PATH"

if [[ $(which jenv &> /dev/null) ]] ; then
    # eval "$(jenv init -)"
    # Faster jenv init via https://github.com/jenv/jenv/issues/148#issuecomment-230259636
    eval "$(jenv init - --no-rehash)"
    (jenv rehash &) 2>/dev/null
fi


alias code="code-insiders "

# Java tools Shortcuts
alias jmeter="jenv exec jmeter "

# alias nuget="mono /usr/local/bin/nuget.exe"

# Oh My ZSH
# Not sure yet if I want to add it
# source ${0:a:h}/.ohmyzsh.zshrc

# # Some apps, like JavaScript debugging extension for VS Code, require node to be in PATH
# # We override the node executables later so they refer to current nvm version not latest
# # NVM_DIR="$HOME/.nvm" // Do not make it available
# export PATH="$(ls -td $HOME/.nvm/versions/node/* | head -n 1)/bin:$PATH"
# if [ ! -s "$NVM_DIR/nvm.sh" ]; then
#     export NVM_DIR="$HOME/.nvm"
#     \. "$NVM_DIR/nvm.sh"
# fi
