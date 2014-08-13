#!/bin/bash

# Standard settings for images.
# Script is meant to be run as a postflight script in a .pkg file. 
# Also installs startup settings script as a Launchd item which is inside the package /Contents/Resources directory.
 
##### Begin Declare Variables Used by Script #####
 
# Declare 'defaults'and 'PlistBuddy'.
 
defaults="/usr/bin/defaults"
PlistBuddy="/usr/libexec/PlistBuddy"
 
# Declare directory variables.
 
PKG_DIR="$1/Contents/Resources"
SCRIPTS_DIR="$3/Library/Scripts/Purchase"
LAUNCHD_DIR="$3/Library/LaunchDaemons"
PRIVETC_DIR="$3/private/etc"
PREFS_DIR="$3/Library/Preferences"
USERPREFS_DIR="$3/System/Library/User Template/English.lproj/Library/Preferences"
ROOT="$3/"
# Set variable to location of update_dyld_shared_cache command on targetvolume.
UPDATE_DYLD="$3/usr/bin/update_dyld_shared_cache" 
 
##### End Declare Variables Used by Script #####
 
##### Begin Preference Setting #####
 
# These settings can be set on the target volume before startup.
 
#Enables SSH
$PlistBuddy -c "Delete Disabled" $3/System/Library/LaunchDaemons/ssh.plist
 
# Display login window as Name and Password.
$defaults write "${PREFS_DIR}/com.apple.loginwindow" SHOWFULLNAME -bool YES
 
# Set Safari Preferences.
$defaults write "${USERPREFS_DIR}/com.apple.Safari" HomePage http://www.google.com/
$defaults write "${USERPREFS_DIR}/com.apple.Safari" ShowStatusBar -bool YES
 
# Set Finder Prefereces.
$defaults write "${USERPREFS_DIR}/com.apple.finder" ShowMountedServersOnDesktop -bool YES
 
#Firewall Settings | 0 = Off | 1 = On For Specific Services | 2 = On For Essential Services
sudo defaults write "${PREFS_DIR}/com.apple.alf" globalstate -int 0
 
exit 0
