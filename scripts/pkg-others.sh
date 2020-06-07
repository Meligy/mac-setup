echo "Git Credential Manager Core:"
(
    cd $TEMP_Apps && \
    git_credential_manager=$( \
    curl https://github.com/Microsoft/Git-Credential-Manager-Core/releases \
            | pup '.release-entry:first-child details a[href$="pkg"] attr{href}' \
    ) && \
    git_credential_manager_url="https://github.com$git_credential_manager" && \
    git_credential_manager_file=$(basename $git_credential_manager) && \
    echo "Downloading and installing $git_credential_manager_url" && \
    curl -L -J -C - $git_credential_manager_url -o $git_credential_manager_file && \
    sudo installer -pkg $git_credential_manager_file -target / \
)


echo "FinderPath:"
(
    cd $TEMP_Apps;
    home_url="https://bahoom.com/finderpath" && \
    download_path=$( \
        curl $home_url \
                | pup 'a[href$="FinderPath.zip"] attr{href}' \
        ) && \
    full_download_url="$home_url/$download_path" && \
    zipped_filename=$(basename $full_download_url) && \
    echo "Downloading and installing $full_download_url" && \
    curl -L -J -C - $full_download_url -o $zipped_filename && \
    unzip -u -o $zipped_filename &&
        (
            appName="FinderPath";
            sudo killall $appName;
            sudo rm -rf "$HOME/Applications/$appName.app";
            sudo cp -f -r "$appName.app" ~/Applications &&
                # Fails now as it needs setting up in Accessibility settings
                # Plan is to use tccutil.py to set it up (see init.sh), but that's also broken in Big Sur
                sudo open "$HOME/Applications/$appName.app"
        )
)

# Audacity people really do not want their apps to be scripted. It's by design
#
# echo "Audacity:"
# (
#     cd $TEMP_Apps && \
#     audacity_page=$( \
#     curl "https://www.audacityteam.org/download/mac/" \
#             | pup 'a[href^="https://www.fosshub.com/Audacity.html/audacity-macos-"] attr{href}' \
#     ) && \
#     echo $audacity_page && \
#     audacity_list_part="/audacity-macos-" && \
#     audacity_download_part="?dwl=audacity-macos-" && \
#     audacity_url=${audacity_page/$audacity_list_part/$audacity_download_part} && \
#     echo $audacity_url && \
#     curl -L -J -C - $audacity_url -o audacity-macos.dmg  #&& \
#     # sudo installer -pkg Git-Credential-Manager-Core.pkg -target / \
# )

echo "Company Portal:"
# URL linked from https://docs.microsoft.com/en-us/mem/intune/user-help/enroll-your-device-in-intune-macos-cp
(
    cd $TEMP_Apps && \
    curl -L -J -C - "https://go.microsoft.com/fwlink/?linkid=853070" -o CompanyPortal.pkg && \
    sudo installer -pkg CompanyPortal.pkg -target / \
)

echo "Battery Health 3:"
echo "(This requires a license key entered manually)"
(
    cd $TEMP_Apps;
    curl -J -C - "https://fiplab.com/app-download/Battery_Health_3.zip" -o Battery_Health_3.zip &&
        unzip -u -o Battery_Health_3.zip &&
        (
            sudo killall "Battery Health 3";
            sudo rm -rf "$HOME/Applications/Battery Health 3.app";
            sudo cp -f -r Battery\ Health\ 3.app ~/Applications &&
                sudo open "$HOME/Applications/Battery Health 3.app"
        )
)

echo "KDiff3:"
(
    sudo hdiutil detach /Volumes/kdiff3;
    sudo killall "kdiff3";
    cd $TEMP_Apps;
    # Kdiff is almost never updated, so it's OK to have it like this
    curl -J -C - "https://nchc.dl.sourceforge.net/project/kdiff3/kdiff3/0.9.98/kdiff3-0.9.98-MacOSX-64Bit.dmg" -o kdiff3.dmg &&
        sudo hdiutil attach kdiff3.dmg &&
        cp -f -r /Volumes/kdiff3/kdiff3.app ~/Applications;
    sudo hdiutil detach /Volumes/kdiff3;
)
