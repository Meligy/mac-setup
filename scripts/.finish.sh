sudo -E chmod -R g-w "$(brew --prefix)/share/zsh/"
sudo -E chmod -R g-w "$(brew --prefix)/share/zsh/site-functions/"
for file in $(ls -A ${0:a:h}/../dotfiles); do
  rm -f ~/$file && ln -f -s ${0:a:h}/../dotfiles/$file ~/$file
done

brew upgrade
brew upgrade --cask
brew cleanup

killall -q Finder

export fpath=(/usr/share/zsh/$ZSH_VERSION/functions/ $fpath)
for fdir in $fpath; do
  if [ -d $fdir ]; then
    sudo -E chmod -R g-w $fdir
  fi
done
# source /usr/share/zsh/$ZSH_VERSION/functions/compaudit
# source /usr/share/zsh/$ZSH_VERSION/functions/compinit
autoload -U +X compinit && compinit
compaudit | sudo -E xargs chmod g-w
compinit
# chmod g-w /usr/share/zsh/$ZSH_VERSION/functions/compaudit
# eval "compaudit | xargs chmod g-w"
# Required so the prev files are not marked as insecure
# But it cannot be called from this file, needs to be in terminal
# compaudit | xargs chmod g-w;

# There's what seems to be false error about this at installation.
# So running this, but since it's UI based, running it at the end
# open /System/Library/CoreServices/Rosetta\ 2\ Updater.app

echo "!!! DONE !!!"
echo "Please run the following to update your terminal, if not in the command already:"
echo "exec zsh -l"
