#"Showing all filename extensions in Finder by default"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Autohide menu bar
# ** Needs to change as on M1x machines it's not a good idea **
# defaults write NSGlobalDomain _HIHideMenuBar -bool true

# Do not work in latest macOS
# defaults write com.apple.menuextra.battery ShowPercent -string "NO"
# defaults write com.apple.menuextra.battery ShowTime -string "YES"

# I'm using battery health 3 instead, to see estimated battery time
# defaults write com.apple.systemuiserver menuExtras -array-remove "/System/Library/CoreServices/Menu Extras/Battery.menu"

# batteryItem=$(
#     /usr/libexec/PlistBuddy -c Print:menuExtras ~/Library/Preferences/com.apple.systemuiserver.plist | 
#     /usr/bin/grep -n "Battery4" | 
#     /usr/bin/awk -F ":" '{print $1}'
# ) && echo $batteryItem

# if [ ! -z "$batteryItem" ]; then
# # Item to delete is the number minus two
# itemToDelete=$(($batteryItem-2))

# /usr/libexec/PlistBuddy -c "Delete :managed_installs:$itemToDelete" /Library/Managed\ Installs/manifests/SelfServeManifest



# /usr/libexec/PlistBuddy -c Print:menuExtras ~/Library/Preferences/com.apple.systemuiserver.plist


# Menu bar: hide the useless Time Machine and Volume icons
# defaults read com.apple.systemuiserver menuExtras -array 
# "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" 
# "/System/Library/CoreServices/Menu Extras/AirPort.menu" 
# "/System/Library/CoreServices/Menu Extras/Battery.menu" 
# "/System/Library/CoreServices/Menu Extras/Clock.menu"
