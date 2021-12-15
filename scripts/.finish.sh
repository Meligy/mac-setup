brew upgrade
brew upgrade --cask
brew cleanup

killall Finder
sudo chmod g-w "$(brew --prefix)/share/zsh/"
sudo chmod g-w "$(brew --prefix)/share/zsh/site-functions/"
for file in $(ls -A ${0:a:h}/../dotfiles); do
  rm -f ~/$file && ln -f -s ${0:a:h}/../dotfiles/$file ~/$file
done
export fpath=(/usr/share/zsh/$ZSH_VERSION/functions/ $fpath)
for fdir in $fpath; do
  sudo chmod g-w $fdir
done
# source /usr/share/zsh/$ZSH_VERSION/functions/compaudit
# source /usr/share/zsh/$ZSH_VERSION/functions/compinit
autoload -U +X compinit && compinit
compaudit | sudo xargs chmod g-w
compinit
# chmod g-w /usr/share/zsh/$ZSH_VERSION/functions/compaudit
# eval "compaudit | xargs chmod g-w"
# Required so the prev files are not marked as insecure
# But it cannot be called from this file, needs to be in terminal
# compaudit | xargs chmod g-w;

echo "!!! DONE !!!"
echo "Please run the following to update your terminal, if not in the command already:"
echo "exec zsh -l"
