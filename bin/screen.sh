#!/bin/sh

if [ -d $HOME/Desktop/mute ]
then
  echo "Muted... exiting"
  exit
fi

# brew install imagesnap

DATE_FULL=`date "+%Y-%m-%d-%H.%M-%Z"`
DATE=`date "+%Y-%m-%d"`

APP_PATH=$HOME/Pictures/DailyLog
SAVE_PATH=$APP_PATH/$DATE

WIFI_NAME=`/usr/sbin/ioreg -w0 -l | grep "IO80211SSID" | awk '{print $8}' | tr -d '"'`

WIFI_NAME_CONV=`/usr/sbin/ioreg -w0 -l | grep "IO80211SSID" | awk '{print $8}' | tr -d '"' | hexdump -n 3 -d | head -1 | awk '{ print $2 }'`

if [ $WIFI_NAME_CONV == '35661' ]
then
  WIFI_NAME='HOME'
fi

mkdir -p $SAVE_PATH

IDLE_TIME=$((`/usr/sbin/ioreg -c IOHIDSystem | sed -e '/HIDIdleTime/!{ d' -e 't' -e '}' -e 's/.* = //g' -e 'q'` / 1000000000))

# skip if idle for more than 10 minutes
if [ $IDLE_TIME -lt 600 ]
then
  /usr/sbin/screencapture -x -t "jpg" -C $SAVE_PATH/$DATE_FULL-$WIFI_NAME-screen.jpg
  /usr/bin/SetFile -a e $SAVE_PATH/$DATE_FULL-$WIFI_NAME-screen.jpg
  /usr/local/bin/jpegoptim $SAVE_PATH/$DATE_FULL-$WIFI_NAME-screen.jpg
  /usr/local/bin/imagesnap -q $SAVE_PATH/$DATE_FULL-$WIFI_NAME-camera.jpg
  /usr/local/bin/jpegoptim $SAVE_PATH/$DATE_FULL-$WIFI_NAME-camera.jpg
else 
  echo "Idle for $IDLE_TIME seconds... skipping."
fi

