if test ! $(which docker); then
  brew install --cask -q docker-edge && \
    open /Applications/Docker.app
fi