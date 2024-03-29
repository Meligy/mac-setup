# Install Rosetta to run Intel-based apps on ARM
# Detection is based on https://stackoverflow.com/a/65259353
# Install command is copied from https://osxdaily.com/2020/12/04/how-install-rosetta-2-apple-silicon-mac/
if [[ $(uname -p) == 'arm' ]]; then
  /usr/sbin/softwareupdate --install-rosetta --agree-to-license
fi
  
# Fiex an error:
#   xcode-select: error: unable to get active developer directory, use `sudo xcode-select --switch path/to/Xcode.app` to set one (or see `man xcode-select`)
#   xcode-select: note: install requested for command line developer tools
#   xcode-select: note: no developer tools were found at '/Applications/Xcode.app', requesting install. Choose an option in the dialog to download the command line developer tools.
# Found via https://stackoverflow.com/questions/17980759/xcode-select-active-developer-directory-error
sudo -E xcode-select --reset

# Install Xcode Command-Line Tools
# Inspired by https://github.com/jon-van/Setup_macOS/blob/master/setup.sh
if ! xcode-select -p; then

  sudo -E xcode-select --install

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
  
  echo "Press Enter/Return after XCode commandline tools are fully installed"
  read
fi

softwareupdate --all --install --force

# Via https://github.com/nodejs/node-gyp/issues/569
sudo -E xcode-select -s /Applications/Xcode-Beta.app/Contents/Developer || sudo -E xcode-select -s /Applications/Xcode.app/Contents/Developer

# Homebrew becomes available after this
brew update --force --quiet || {
  # echo bypasses prompt for pressing Enter/Return, as per https://github.com/Homebrew/legacy-homebrew/issues/46779#issuecomment-162819088
  echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# if [[ $(uname -p) == 'arm' ]]
#   then
#     export HOMEBREW_PREFIX="/opt/homebrew"
#   else
#     export HOMEBREW_PREFIX="/usr/local"
# fi
export HOMEBREW_PREFIX=$(brew --prefix)
export PATH="$HOMEBREW_PREFIX/bin:$PATH"

brew install -q zsh && brew link --overwrite zsh

brew upgrade

# Reset bad app store login / data if any
sudo -E rm -rf ~/Library/Containers/com.apple.appstore/Data/Library/Caches/com.apple.appstore

brew install -q mas

# After a macOS upgrade, you may not find XCode
if ! test -d /Applications/Xcode.app/; then
  mas lucky xcode
  echo "Press sign in to App Store then quit it to continue..."
  open -W "/System/Applications/App Store.app"
  sudo -E mas lucky xcode || ( \
    echo "Press Enter/Return after XCode has finished installing. If you get an error, install it manually before continuing"  && \
    open "/System/Applications/App Store.app" && \
    read \
  )
fi
sudo -E xcodebuild -runFirstLaunch
sudo -E xcodebuild -license accept

# echo "The following steps do not require interaction..."

brew install -q cask
brew tap homebrew/cask-versions

brew upgrade --cask

brew install -q ruby
brew link --force ruby

brew install -q coreutils
brew install -q openssl
brew install -q curl
brew install -q wget
brew install -q jq
brew install -q pup # jq but for HTML

brew install -q git

# This looks like it's broken in Big Sur, probably Xcode needs a new 12.3 version
#
# Allows modifying macOS accessibility options, from https://github.com/jacobsalmela/tccutil
brew install -q tccutil

# ohmyzsh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

brew install --cask -q jetbrains-toolbox

# asdf
brew install -q coreutils curl git asdf

mkdir -p $TEMP_Apps