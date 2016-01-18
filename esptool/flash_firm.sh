#!/bin/bash
#
dev=/dev/tty.usbserial
python ./esptool.py \
  --port  $dev \
  --baud 115200 \
  write_flash 0x000000 \
  ../firmware/nodemcu-master-10-modules-2016-01-12-15-28-14-integer.bin
  #../nodemcu-firmware/bin/nodemcu_integer_works.bin
  #../firmware/old/nodemcu-master-8-modules-2015-10-17-16-02-28-integer.bin
  #../firmware/old/nodemcu-dev140-10-modules-2015-10-24-01-11-57-integer.bin
  #../firmware/nodemcu-dev-10-modules-2015-11-14-23-26-52-integer.bin
  #../firmware/nodemcu-dev140-7-modules-2015-10-20-22-56-36-integer.bin
  #../firmware/nodemcu-master-7-modules-2015-10-13-02-21-38-integer.bin
  #../nodemcu-flasher/Resources/Binaries/nodemcu_integer_0.9.5_20150318.bin
  # worked (send)
  #../firmware/old/nodemcu-master-8-modules-2015-10-17-16-02-28-integer.bin


