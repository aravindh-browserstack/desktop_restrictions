#!/bin/bash

user=$1
if id $user > /dev/null 2>&1
  then 
  sudo chmod 000 "/Applications/System Preferences.app/Contents/MacOS/System Preferences"
  sudo defaults write /Users/$user/Library/Preferences/com.apple.dock contents-immutable -bool TRUE
  sudo defaults write /Users/$user/Library/Preferences/com.apple.finder InterfaceLevel simple
  sudo defaults write /Users/$user/Library/Preferences/com.apple.dock contents-immutable -bool FALSE
  sudo defaults write /Users/$user/Library/Preferences/com.apple.dock autohide -bool TRUE && \
    sudo defaults write /Users/$user/Library/Preferences/com.apple.dock autohide-delay -float 0 && \
     sudo defaults write /Users/$user/Library/Preferences/com.apple.dock autohide-time-modifier -float 0
  sudo plutil -convert xml1 /Users/$user/Library/Preferences/com.apple.dock.plist
  sudo python ./modify_user_dock.py $user
  sudo plutil -convert binary1 /Users/$user/Library/Preferences/com.apple.dock.plist
  sudo chown $user:staff /Users/$user/Library/Preferences/com.apple.dock.plist
  sudo chown $user:staff /Users/$user/Library/Preferences/com.apple.finder.plist
  sudo killall Finder
  sudo killall -HUP Dock
else
  echo "User doesn't exist !"
fi
