#!/bin/zsh

# Author: Andrew W. Johnson
# 2021.09.15
# Version: 1.00
# Organization: Stony Brook University/DoIT

# This script will initiate a computer reboot. It is intended for computer labs. Relies on
# the Jamf binary to reboot the computer. Any messages will be sent to /var/log/jamf.log.
#
# On installation, the preflight script will:
# 1. Try to unload the following LaunchDaemon: /Library/LaunchDaemons/edu.stonybrook.sinc.reboot.plist
# 2. It will put down sinc-reboot.zsh in /usr/local/bin/
# 3. It will then put down edu.stonybrook.sinc.reboot.plist in /private/tmp.
# 4. the post flight script will then edit the edu.stonybrook.sinc.reboot.plist and place
#    the appropriate start time for execution based on computer lab criteria. Then copy
#    the LaunchDaemon file to /Library/LaunchDaemons, set proper ownership and permissions, 
#    and finally load the job and delete the plist from tmp.


/bin/echo "$( /bin/date | /usr/bin/awk '{print $1, $2, $3, $4}' ) $( /usr/sbin/scutil --get LocalHostName ) $( /usr/bin/basename ${0} )[$$]: Starting" >> /var/log/jamf.log

	# Check to see if a user is logged in.
userLoggedIn=$( /usr/bin/who | /usr/bin/egrep -ic console )

	# If someone is logged in, then have the Jamf binary initiate a reboot in five minutes 
	# with a message to the user. If no user is logged in then reboot immediately.
if [[ $userLoggedIn -ge 1 ]]; then
	/bin/echo "$( /bin/date | /usr/bin/awk '{print $1, $2, $3, $4}' ) $( /usr/sbin/scutil --get LocalHostName ) $( /usr/bin/basename ${0} )[$$]: Someone is logged in." >> /var/log/jamf.log
	/usr/local/bin/jamf reboot -minutes 5 -message 'This computer will restart in 5 minutes. Please save anything you are working on and log out by choosing Log Out from the bottom of the Apple menu.' -startTimerImmediately &
else
	/bin/echo "$( /bin/date | /usr/bin/awk '{print $1, $2, $3, $4}' ) $( /usr/sbin/scutil --get LocalHostName ) $( /usr/bin/basename ${0} )[$$]: No one is logged in." >> /var/log/jamf.log
	/usr/local/bin/jamf reboot -immediately
fi
/bin/echo "$( /bin/date | /usr/bin/awk '{print $1, $2, $3, $4}' ) $( /usr/sbin/scutil --get LocalHostName ) $( /usr/bin/basename ${0} )[$$]: Ending" >> /var/log/jamf.log

exit 0
