# (
#     export NVM_DIR="$HOME/.nvm" && (
#         if [ -d $NVM_DIR ]; then
#             cd "$NVM_DIR"
#             git fetch --tags origin
#             git checkout $(git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1))
#         else
#             git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
#             cd "$NVM_DIR"
#             git checkout $(git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1))
#         fi
#     ) && \. "$NVM_DIR/nvm.sh"

#     nvm alias default node &&
#         (
#             # If there's already a "node" (latest) version set, update it
#             nvm install "lts/*" --reinstall-packages-from=default --latest-npm |
#                 nvm install-latest-npm # When latest Node version is already installed, it doesn't seem to update npm
#             npm i -g npm@latest        # Works around an issue where npm7 does not get
#         ) ||
#         (
#             # If there's no version, install latest and set as default
#             nvm install "lts/*"
#             nvm alias default node
#         )
# )

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs latest
asdf global nodejs latest

brew install -q pnpm

brew install -q eslint --ignore-dependencies

brew install -q deno

curl -fsSL https://bun.sh/install | bash