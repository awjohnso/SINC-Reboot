#!/bin/zsh

if [ -e "/Library/LaunchDaemons/edu.stonybrook.sinc.reboot.plist" ]; then
	/bin/launchctl unload -w /Library/LaunchDaemons/edu.stonybrook.sinc.reboot.plist
fi

exit 0

