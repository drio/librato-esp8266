#!/bin/bash
#sudo ./luatool.py --port /dev/ttyUSB0 --src init.lua --dest init.lua --restart
# kill $(lsof | grep usbserial | awk '{print $2}')
# sleep 1
#sudo ./luatool.py -w
sudo ./luatool.py \
  --port /dev/tty.usbserial \
  --src src/librato-statsd.lua \
  --restart \
  --dest init.lua
