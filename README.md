# SINC-Reboot
Lab scripts to reboot the computers in the dead of night.
- Author: Andrew W. Johnson
- 2021.09.15
- Version: 1.00
- Organization: Stony Brook University/DoIT
---
This script will initiate a computer reboot. It is intended for computer labs. Relies on the Jamf binary to reboot the computer. Any messages will be sent to */var/log/jamf.log*.

On installation, the preflight script will:
1. Try to unload the following LaunchDaemon: */Library/LaunchDaemons/edu.stonybrook.sinc.reboot.plist*
On Installation, the installer will:
1. It will put down sinc-reboot.zsh in */usr/local/bin/*
2. It will then put down *edu.stonybrook.sinc.reboot.plist* in */private/tmp*.
On installation the postflight script will:
1. Edit the *edu.stonybrook.sinc.reboot.plist* file and place the appropriate start time for execution based on computer lab criteria.
2. Copy the LaunchDaemon file to */Library/LaunchDaemons*
3. Set the proper ownership and permissions on the LaunchDaemon file.
4. Load the job and delete the plist from tmp.

### Version 1.00
- Checks to see if a user is logged in.
- If someone is logged in, then have the Jamf binary initiate a reboot in five minutes with a message to the user.
- If no user is logged in then reboot immediately.