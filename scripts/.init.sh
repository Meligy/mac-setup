# Install Xcode Command-Line Tools
# Inspired by https://github.com/jon-van/Setup_macOS/blob/master/setup.sh
if ! xcode-select -p; then
  sudo xcode-select --install

  # This seems to break on latest macOS, although it's recommended in Flutter setup page
  # sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
  #
  # When brew broke, it wrote the following:
  # Please update your CLT or delete it if no updates are available.
  # Update them from Software Update in System Preferences or run:
  #   softwareupdate --all --install --force
  # If that doesn't show you any updates, run:
  #   sudo rm -rf /Library/Developer/CommandLineTools
  #   sudo xcode-select --install

  xcodebuild -runFirstLaunch
fi

softwareupdate --all --install --force

# Homebrew
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" \
    </dev/null # avoid prompt to press enter
  export PATH="/usr/local/bin:$PATH"
fi

brew install -q zsh && brew link --overwrite zsh

brew upgrade
brew upgrade --cask

brew install -q mas
sudo mas account
if sudo test $? -ne 0; then
  echo "Press Enter/Return after signing in to App Store"
  open "/System/Applications/App Store.app"
  read
fi

# After a macOS upgrade, you may not find XCode
(
  echo "before xcode"
  sudo mas lucky xcode
  echo "after xcode"
  sudo xcodebuild -runFirstLaunch
  sudo xcodebuild -license accept
)

echo "The following steps do not require interaction..."

brew install -q cask
brew tap homebrew/cask-versions

brew cask upgrade

brew install -q coreutils
brew install -q openssl
brew install -q curl
brew install -q wget
brew install -q jq
brew install -q pup # jq but for HTML

# This looks like it's broken in Big Sur, probably Xcode needs a new 12.3 version
#
# Allows modifying macOS accessibility options, from https://github.com/jacobsalmela/tccutil
brew install -q tccutil

# ohmyzsh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

brew install --cask -q jetbrains-toolbox

mkdir -p $TEMP_Apps