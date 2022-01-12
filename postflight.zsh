#!/bin/zsh

typeset -l myname
myname=$( /usr/sbin/networksetup -getcomputername | /usr/bin/cut -c 1-3 )

/bin/echo ${myname}

if [ "${myname}" = "fam" ] || [ "${myname}" = "hyb" ]; then
	myTime=4
else
	myTime=2
fi

/bin/echo ${myTime}
/bin/cat /private/tmp/edu.stonybrook.sinc.reboot.plist | /usr/bin/sed "s/<integer>H<\/integer>/<integer>${myTime}<\/integer>/" > /Library/LaunchDaemons/edu.stonybrook.sinc.reboot.plist
/bin/chmod -v 644 /Library/LaunchDaemons/edu.stonybrook.sinc.reboot.plist
/usr/sbin/chown -v root:wheel /Library/LaunchDaemons/edu.stonybrook.sinc.reboot.plist
/bin/launchctl load -w /Library/LaunchDaemons/edu.stonybrook.sinc.reboot.plist
/bin/rm -Rf /private/tmp/edu.stonybrook.sinc.reboot.plist

exit 0

