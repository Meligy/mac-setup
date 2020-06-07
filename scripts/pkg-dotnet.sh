# Do not install `mono` or `nuget` from home-brew. These packages have the correct folders.
# Update: Do not install `mono-mdk` if you want to use Visual Studio for Mac
# brew install --cask -q mono-mdk
brew uninstall --cask mono-mdk

# NuGet, via https://docs.microsoft.com/en-us/nuget/install-nuget-client-tools#macoslinux
# Download the latest stable `nuget.exe` to `/usr/local/bin`
sudo curl -o /usr/local/bin/nuget.exe https://dist.nuget.org/win-x86-commandline/latest/nuget.exe
chmod +x /usr/local/bin/nuget.exe

# Latest dotnet
brew install --cask -q dotnet-sdk

sudo dotnet dev-certs https --clean
sudo dotnet dev-certs https --trust

# Older packages that I still use for certin projects
# Older dotnet packages have to be reinstalled when a newer dotnet is installed
# # From https://dotnet.microsoft.com/download/dotnet-core/2.2
echo ".NET SDK sdk-2.2.401"
(
    cd $TEMP_Apps &&
        direct_link=$(
            curl -L https://dotnet.microsoft.com/download/dotnet-core/thank-you/sdk-2.2.401-macos-x64-installer |
                pup 'a#directLink attr{href}'
        ) &&
        curl -L -J -C - $direct_link -o dotnetcore-sdk-2_2_401.pkg &&
        sudo installer -pkg dotnetcore-sdk-2_2_401.pkg -target /
)
# # From https://dotnet.microsoft.com/download/dotnet-core/3.1
echo ".NET SDK sdk-3.1.101"
(
    cd $TEMP_Apps &&
        direct_link=$(
            curl -L https://dotnet.microsoft.com/download/dotnet-core/thank-you/sdk-3.1.101-macos-x64-installer |
                pup 'a#directLink attr{href}'
        ) &&
        curl -L -J -C - $direct_link -o dotnetcore-sdk-3_1_101.pkg &&
        sudo installer -pkg dotnetcore-sdk-3_1_101.pkg -target /
)
# # From https://dotnet.microsoft.com/download/dotnet/5.0
echo ".NET SDK sdk-3.1.101"
(
    cd $TEMP_Apps &&
        direct_link=$(
            curl -L https://dotnet.microsoft.com/download/dotnet/thank-you/sdk-5.0.403-macos-x64-installer |
                pup 'a#directLink attr{href}'
        ) &&
        curl -L -J -C - $direct_link -o dotnet-sdk-5.0.403-osx-x64.pkg &&
        sudo installer -pkg dotnet-sdk-5.0.403-osx-x64.pkg -target /
)

# Maybe this should be earlier, but the above was really trying to be independnet from VS
# So, it's good to keep the above working as-is
brew install --cask -q visual-studio

dotnet tool install -g JetBrains.ReSharper.GlobalTools
