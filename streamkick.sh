### BEGIN INIT INFO
# Provides:          dovecot
# Required-Start:    $local_fs $network
# Required-Stop:     $local_fs
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: dovecot
# Description:       dovecot pop & imap daemon
### END INIT INFO

#! /bin/sh
# /etc/init.d/mjpg_streamkick

# Carry out specific functions when asked to by the system
case "$1" in
  start)
    echo "Starting mjpg_streamkick script"
    export LD_LIBRARY_PATH=/usr/local/lib/mjpg-streamer
   uvcdynctrl -d video0 --set="Focus, Auto" 0
    mjpg_streamer -i "input_uvc.so -d /dev/video0 -r 1280x720 -n -q 98" -o "output_http.so -p 8080-c user:pass" &
    ;;
  stop)
    echo "Stopping webcam script"
    killall mjpg_streamer
    ;;
  *)
    echo "Usage: /etc/init.d/mjpg_streamkick {start|stop}"
    exit 1
    ;;
esac

exit 0