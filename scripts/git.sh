# brew

brew install -q git
brew install -q git-lfs
brew install -q git-extras
brew install -q legit
brew install -q git-flow

# Git Cedential Manager https://github.com/GitCredentialManager/git-credential-manager
brew tap microsoft/git
brew install -q --cask git-credential-manager-core

# A git CLI alternative with Github specific features
brew install -q hub

# An outdated diff tool that I love for some reason
brew install -q --cask kdiff3

# cask s
brew install --cask -q fork

# config

git config --global user.name "Meligy"
git config --global user.email Eng.Meligy@gmail.com 