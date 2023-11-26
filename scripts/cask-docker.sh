# useful for docker-like tools, see https://github.com/lima-vm/lima#qemu
brew install -q qemu

brew uninstall --cask -q docker || $null
brew install --cask -q docker && open /Applications/Docker.app

brew install -q docker-buildx

brew install -q kubectl

kubectl completion zsh > "${fpath[1]}/_kubectl"