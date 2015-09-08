#!/bin/bash
# RaspiCC daemon
# chkconfig: 345 20 80
# description: RaspiCC daemon
# processname: RaspiCC

NAME=RaspiCC
DESC="Enable cross-compiling for Raspberry Pi"
PIDFILE=/var/run/$NAME.pid
SCRIPTNAME=/etc/init.d/$NAME

case "$1" in
	start)
		printf "%-50s" "Starting $NAME..."
		echo "\nWhich architecture do you want to enable ? [32/64] "
		read ARCH
		echo "What is the ip range that you want to allow ? [192.168.1.0/24] "
		read IPRANGE
		export PATH=/usr/local/rpi-tools/x$ARCHbin:$PATH
		distccd --daemon --jobs 16 --allow $IPRANGE --verbose --log-stderr --no-detach
	;;

	stop)
		printf "%-50s" "Stopping $NAME"
		killall distccd
	;;

	*)
		echo "Usage: $0 {start|stop}"
		exit 1
esac
