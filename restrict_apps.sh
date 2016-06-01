#!/bin/bash

user=$1
if [[ $# -ne 1 ]]               
  then echo "Username not provided"
  exit
fi
if id $user > /dev/null 2>&1
  then 
  sudo chmod 000 "/Applications/System Preferences.app/Contents/MacOS/System Preferences"
  sudo chmod 000 "/System/Library/CoreServices/NotificationCenter.app/Contents/MacOS/NotificationCenter"
  sudo defaults write /Users/$user/Library/Preferences/com.apple.dock contents-immutable -bool TRUE
  sudo defaults write /Users/$user/Library/Preferences/com.apple.finder InterfaceLevel simple
  sudo defaults write /Users/$user/Library/Preferences/com.apple.dock contents-immutable -bool FALSE
  sudo defaults write /Users/$user/Library/Preferences/com.apple.dock autohide -bool TRUE && \
    sudo defaults write /Users/$user/Library/Preferences/com.apple.dock autohide-delay -float 0 && \
     sudo defaults write /Users/$user/Library/Preferences/com.apple.dock autohide-time-modifier -float 0
  sudo plutil -convert xml1 /Users/$user/Library/Preferences/com.apple.dock.plist
  sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport en0 prefs RequireAdminPowerToggle=YES
  sudo networksetup -setairportpower airport off
  sudo python ./modify_user_dock.py $user
  sudo plutil -convert binary1 /Users/$user/Library/Preferences/com.apple.dock.plist
  sudo chown $user:staff /Users/$user/Library/Preferences/com.apple.dock.plist
  sudo chown $user:staff /Users/$user/Library/Preferences/com.apple.finder.plist
  sudo chmod 000 "/System/Library/CoreServices/Menu Extras/"*.menu 
  sudo chmod 755 "/System/Library/CoreServices/Menu Extras/Clock.menu"
  sudo chmod 755 "/System/Library/CoreServices/Menu Extras/Airport.menu"
  sudo killall NotificationCenter
  sudo killall Finder
  sudo killall -HUP Dock
  sudo killall -HUP SystemUIServer
else
  echo "User doesn't exist !"
fi
