# zsh-completions
brew install -q zsh-completions
autoload -Uz compinit
rm -f ~/.zcompdump; compinit

chmod go-w "$(brew --prefix)/share"

brew install -q tkdiff

brew install -q jmeter

# DigitalOcean CLI
# https://github.com/digitalocean/doctl#macos
brew install -q doctl

brew install -q terraform

brew install -q graphviz

# Hugo static site generator
brew install -q hugo

brew install -q pre-commit

# ZSH prompt
brew install -q spaceship

brew install -q p7zip

brew install -q pulumi

# Used for running x64 docker images
brew uninstall -q lima
brew uninstall -q colima
# https://github.com/lima-vm/lima/blob/873a39c6652fe5fcb07ee08418f39ccaeeea6979/docs/multi-arch.md#fast-mode
lima sudo nerdctl run --privileged --rm tonistiigi/binfmt --install all

# dependents shown from `brew doctor`
brew install -q c-ares libuv