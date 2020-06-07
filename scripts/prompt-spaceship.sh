(
    mkdir -p $HOME/code/git/denysdovhan;
    cd $HOME/code/git/denysdovhan;
    if [ -d "${0:a:h}/spaceship-prompt/.git" ]; then
        cd spaceship-prompt;
        git pull
    else
        git clone --depth 1 https://github.com/denysdovhan/spaceship-prompt.git spaceship-prompt;
        cd spaceship-prompt;
    fi
    mkdir -p $HOME/.zfunctions;
    ln -sf "$PWD/spaceship.zsh" "$HOME/.zfunctions/prompt_spaceship_setup"
)

