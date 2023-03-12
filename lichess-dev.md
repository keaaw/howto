# MacOS installation (March 2023)
Got it to work, but it was a hassle, because I'm running Mojave (10.14.6), which is considered old, and brew has issues and is unsupported.  Had to add and 
upgrade many packages.    ui/build didn't work because Mojave's readlink didn't support the "-f" parameter, fixed this with help from the lichess dev 
team on discord: https://github.com/lichess-org/lila/pull/12477

# Linux Installation (March 2023)
Ubuntu is a good distribution, it has most packages.  For this current effort I used Ubuntu 22.04.2 LTS

Followed directions in https://github.com/lichess-org/lila/wiki/Lichess-Development-Onboarding

Detailed system package setup and lichess dev installation: https://github.com/keaaw/howto/blob/main/lichess-dev-install-history

You *definitely* need websockets for pretty much everything (if you don't set up websockets, no games will work, nor play against the computer, 
and you'll always have a red "Reconnecting" in the lower left of the screen)

# Running
all user passwords are "password" by default

You can tweak user passwords in spamdb by editing lila-db-seed/spamdb/data/uids.txt

## Accessing server from outside system
The default domain needs to be changed from "localhost" to the IP address of the system running lichess-dev: e.g., "192.168.1.18", otherwords the lichess http handler will redirect to "localhost".


