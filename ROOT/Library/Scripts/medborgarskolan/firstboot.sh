###
# First Boot script that is used along with a launchd item.  Delets both itself and the launchd item after completion.
###
 
# Define 'kickstart' and 'systemsetup' variables, built in OS X script that activates and sets options for ARD.
 
kickstart="/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart"
systemsetup="/usr/sbin/systemsetup"
genericppd="/System/Library/Frameworks/ApplicationServices.framework/Versions/A/Frameworks/PrintCore.framework/Versions/A/Resources/Generic.ppd"
 
# Delete iMovie (Previous Version) Directory if it exists, because we don't need it. 
#Use when installing iLife using the original installers with InstaDMG.
#rm -R /Applications/iMovie\ \(previous\ version\).localized/
 
# ARD Configuration
#Enable ARD for admin
$kickstart -configure -allowAccessFor -specifiedUsers
$kickstart -activate -configure -access -on -users "admin" -privs -all -restart -agent
 
# Set time zone and time server.
$systemsetup -setusingnetworktime on
$systemsetup -settimezone Europe/Stockholm -setnetworktimeserver time.euro.apple.com
 
#Removes Time Machine from the menu
#defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup 1
 
#disable ipv6
#$networksetup -setv6off Ethernet


# Activate WakeOnLAN.
#$systemsetup -setwakeonnetworkaccess on 

#Sets HostName
#scutil --set HostName $(scutil --get LocalHostName)
base=""
tld="admbs.mbs08.se"
serial=`/usr/sbin/system_profiler SPHardwareDataType | /usr/bin/awk '/Serial\ Number\ \(system\)/ {print $NF}'`
scutil --set ComputerName $base$serial
scutil --set LocalHostName $base$serial
scutil --set HostName "${base}${serial}.${tld}"



defaults write /Library/Preferences/.GlobalPreferences AppleLocale = sv_SE
defaults write /Library/Preferences/.GlobalPreferences Country SE

 
#Sets computer to never sleep while plugged in to a power source
#pmset -c sleep 0
 
#Adds Printers
#lpadmin -p "Printer Name" -L "Printer Location" -D "Printer Description" -E -v lpd://server/printqueue -P $genericppd -o printer-is-shared=false
 
#Securely removes the launchd item and script.
srm /Library/LaunchDaemons/edu.medborgarskolan.firstboot.plist
srm "$0"
