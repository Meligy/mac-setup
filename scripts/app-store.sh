# This uses Mac App Store command-line interface, mas


(
    echo "Installing Microsoft Remote Desktop"
    # echo "From: https://apps.apple.com/au/app/microsoft-remote-desktop/id1295203466?mt=12"
    # # Searching for app name "Microsoft Remote Desktop" is not working
    # mas install 1295203466
    mas lucky microsoft-remote-desktop
)

mas lucky kindle

mas lucky lastpass

# (
#     mas search 'Microsoft Remote Desktop' | { 
#         read appId __; echo $appId;
#         mas install $appId;
#         open /Applications/Battery\ Health\ 2.app;
#     }
# )

mas upgrade


# for line in $(echo $(mas list)); do
#     test $line && [[ $line =~ ^[0-9]+$ ]] && mas upgrade $line
# done;

