# Do not install `mono` or `nuget` from home-brew. These packages have the correct folders.
# Update: Do not install `mono-mdk` if you want to use Visual Studio for Mac
# brew install --cask -q mono-mdk
# brew uninstall --cask mono-mdk

# A dependency for apps using the System.Drawing.Common assembly, 
#   as per https://docs.microsoft.com/en-us/dotnet/core/install/macos#libgdiplus
brew install -q mono-libgdiplus

# NuGet, via https://docs.microsoft.com/en-us/nuget/install-nuget-client-tools#macoslinux
# Download the latest stable `nuget.exe` to `/usr/local/bin`
# Remember: Do not install `mono-mdk` if you want to use Visual Studio for Mac
curl -o $(brew --prefix)/bin/nuget https://dist.nuget.org/win-x86-commandline/latest/nuget.exe
chmod +x $(brew --prefix)/bin/nuget

# Latest dotnet
brew uninstall --cask -q dotnet-sdk || $null
sudo rm -rf /usr/local/share/dotnet/
# seems like -q breaks it
# It's not working, so trying to see if interactive works
brew install --force --cask dotnet-sdk

# echo "Press Enter when dotnet finishes installing...."
# read

# echo ".NET SDK latest"
# (
#     cd $TEMP_Apps &&
#         curl -L -J -C - https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh &&
#         ./dotnet-install.sh
# )

if [[ $(uname -p) == 'arm' ]]
  then
    export DOTNET_ARCH="arm64"
  else
    export DOTNET_ARCH="x64"
fi

# Latest dotnet install is not working, see 
# So I'mmanually picking a latest
# # From https://dotnet.microsoft.com/download/dotnet-core/6.0
# echo ".NET SDK sdk-v6.0.101"
# (
#     cd $TEMP_Apps &&
#         direct_link=$(
#             curl -L https://dotnet.microsoft.com/download/dotnet-core/thank-you/sdk-6.0.101-macos-$DOTNET_ARCH-installer |
#                 pup 'a#directLink attr{href}'
#         ) &&
#         curl -L -J -C - $direct_link -o dotnet-sdk-6.0.101.pkg &&
#         sudo installer -pkg dotnet-sdk-6.0.101.pkg -target /
# )

# Based on https://docs.microsoft.com/en-us/dotnet/core/install/macos
export DOTNET_ROOT="/usr/local/share/dotnet"
export PATH="$DOTNET_ROOT:$PATH:$DOTNET_ROOT/x64/dotnet"

if ! test -f $DOTNET_ROOT/dotnet
then
  echo "dotnet not found, re-install manually to continue..."
  read
fi

# Potential improvements might be found at the related sections in https://docs.microsoft.com/en-us/aspnet/core/security/enforcing-ssl
sudo -E dotnet dev-certs https --clean
sudo -E dotnet dev-certs https --trust

# Older packages that I still use for certin projects
# Older dotnet packages have to be reinstalled when a newer dotnet is installed
# # From https://dotnet.microsoft.com/download/dotnet-core/2.2
# echo ".NET SDK sdk-2.2.401"
# (
#     cd $TEMP_Apps &&
#         direct_link=$(
#             curl -L https://dotnet.microsoft.com/download/dotnet-core/thank-you/sdk-2.2.401-macos-x64-installer |
#                 pup 'a#directLink attr{href}'
#         ) &&
#         curl -L -J -C - $direct_link -o dotnetcore-sdk-2_2_401.pkg &&
#         sudo installer -pkg dotnetcore-sdk-2_2_401.pkg -target /
# )
# # # From https://dotnet.microsoft.com/download/dotnet-core/3.1
# echo ".NET SDK sdk-3.1.101"
# (
#     cd $TEMP_Apps &&
#         direct_link=$(
#             curl -L https://dotnet.microsoft.com/download/dotnet-core/thank-you/sdk-3.1.101-macos-x64-installer |
#                 pup 'a#directLink attr{href}'
#         ) &&
#         curl -L -J -C - $direct_link -o dotnetcore-sdk-3_1_101.pkg &&
#         sudo installer -pkg dotnetcore-sdk-3_1_101.pkg -target /
# )
# # From https://dotnet.microsoft.com/download/dotnet/5.0
echo ".NET SDK 5.0.404"
(
    cd $TEMP_Apps &&
        direct_link=$(
            curl -L https://dotnet.microsoft.com/download/dotnet/thank-you/sdk-5.0.404-macos-x64-installer |
                pup 'a#directLink attr{href}'
        ) &&
        curl -L -J -C - $direct_link -o dotnet-sdk-5.0.404-osx-x64.pkg &&
        sudo installer -pkg dotnet-sdk-5.0.404-osx-x64.pkg -target /
)

# Maybe this should be earlier, but the above was really trying to be independnet from VS
# So, it's good to keep the above working as-is
brew install --cask -q visual-studio

# dotnet tool install -g JetBrains.ReSharper.GlobalTools
