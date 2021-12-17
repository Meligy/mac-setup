echo "FinderPath:"
(
    cd $TEMP_Apps;
    appName="FinderPath";
    sudo -E killall -q "$appName" || $null;
    sudo -E rm -rf "$HOME/Applications/$appName.app";
    home_url="https://bahoom.com/finderpath" && \
        download_path=$( \
            curl $home_url \
                    | pup 'a[href$="FinderPath.zip"] attr{href}' \
            ) && \
        full_download_url="$home_url/$download_path" && \
        zipped_filename=$(basename $full_download_url) && \
        echo "Downloading and installing $full_download_url" && \
        curl -L -J -C - $full_download_url -o $zipped_filename && \
        unzip -u -o "$zipped_filename" -d "$HOME/Applications/";
    # Fails now as it needs setting up in Accessibility settings
    # Plan is to use tccutil.py to set it up (see init.sh), but that's also broken in Big Sur
    open "$HOME/Applications/$appName.app";
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

# echo "Company Portal:"
# # URL linked from https://docs.microsoft.com/en-us/mem/intune/user-help/enroll-your-device-in-intune-macos-cp
# (
#     cd $TEMP_Apps && \
#     curl -L -J -C - "https://go.microsoft.com/fwlink/?linkid=853070" -o CompanyPortal.pkg && \
#     sudo installer -pkg CompanyPortal.pkg -target / \
# )

echo "Battery Health 3:"
echo "(This requires a license key entered manually)"
(
    cd $TEMP_Apps;
    appName="Battery Health 3";

    sudo -E killall -q "$appName" || $null;
    sudo -E rm -rf "$HOME/Applications/$appName.app";
    full_download_url="https://fiplab.com/app-download/Battery_Health_3.zip" && \
        zipped_filename=$(basename $full_download_url) && \
        echo "Downloading and installing $full_download_url" && \
        curl -L -J -C - $full_download_url -o $zipped_filename && \
        unzip -u -o "$zipped_filename" -d "$HOME/Applications/";
    # Fails now as it needs setting up in Accessibility settings
    # Plan is to use tccutil.py to set it up (see init.sh), but that's also broken in Big Sur
    open "$HOME/Applications/$appName.app";
)
