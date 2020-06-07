
export TEMP_Apps=${0:a:h}/temp/apps/

if [[ -z "${CI}" ]]; then
  sudo -v # Ask for the administrator password upfront
  # Keep-alive: update existing `sudo` time stamp until script has finished
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
fi

# When you start a child shell, ensure it's clean
rm -f ~/.zprofile;
rm -f ~/.zshrc;
rm -f ~/.zcompdump;

(
  files=( '.init.sh' );
  files+=( $(ls ${0:a:h}/scripts) );
  files+='.finish.sh';
  for file in $files; do 
    echo "\n<<<<<<";
    echo "Started running scripts/$file ...\n";
    zsh ${0:a:h}/scripts/$file;
    echo "\n... Finished running scripts/$file";
    echo ">>>>>>\n";
  done;
)
