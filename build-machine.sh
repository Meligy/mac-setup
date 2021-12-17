
export TEMP_Apps=${0:a:h}/temp/apps/

if [[ -z "${CI}" ]]; then
  sudo -v # Ask for the administrator password upfront
  # Keep-alive: update existing `sudo` time stamp until script has finished
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
fi

if test -f ~/.zprofile || test -f ~/.zshrc || test -f ~/.zshenv || test -f ~/.zcompdump; then
  echo Cleaning files affecting the shell execution...
  rm -f ~/.zprofile;
  rm -f ~/.zshrc;
  rm -f ~/.zshenv;
  rm -f ~/.zcompdump;
  ./$(basename $0) && exit
fi

echo Starting...

(
  files=( '.init.sh' );
  files+=( $(ls ${0:a:h}/scripts) );
  # For debugging a specific file, comment the line above, and add another line like: files+='<FILENAME IN SCRIPTS FOLDER>.sh';
  files+='.finish.sh';
  for file in $files; do 
    clear
    echo "\n<<<<<<";
    echo "Started running scripts/$file ...\n";
    source ${0:a:h}/scripts/$file;
    echo "\n... Finished running scripts/$file";
    echo ">>>>>>\n";
  done;
)
