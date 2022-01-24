# zsh-completions
brew install -q zsh-completions
autoload -Uz compinit
rm -f ~/.zcompdump; compinit

chmod go-w "$(brew --prefix)/share"

brew install -q tkdiff

brew install -q jmeter

brew install -q kubectl

brew install -q deno

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
