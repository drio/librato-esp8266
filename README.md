### Project

![](https://github.com/drio/librato-esp8266/raw/master/imgs/space.png)
![](https://github.com/drio/librato-esp8266/raw/master/imgs/hardware.jpg)


Here you should have everything you need to quickly prototype a
temperature and humidity sensor based on the
[esp8266](https://www.sparkfun.com/products/13678) and the
[nodemcu](https://github.com/nodemcu/nodemcu-firmware) firmware.
We will persist the measurements using [librato](http://librato.com)
as a backend.

### Hardware

- Adafruit's esp8266 [reakout](https://www.adafruit.com/products/2471)
- Bread board
- Jumper wires
- power adaptor or batteries
- dht11 temperature and humidity [sensor](http://www.amazon.com/uxcell-Sensitivity-Temperature-Humidity-20-90%25RH/dp/B00BXWUWRA/ref=sr_1_2?ie=UTF8&qid=1453130363&sr=8-2&keywords=dht11)

### Repo structure

```
.
├── README.md

├── esptool
├── firmware
│   └── nodemcu-master-10-modules-2016-01-12-15-28-14-integer.bin

This directory contains the necessary software to flash the chip
with nodemcu. If you want to build your own firmware you
can do it [locally](https://hub.docker.com/r/marcelstoer/nodemcu-build/)
or use this online [tool](http://nodemcu-build.com/).

├── luatool
│   ├── luatool.py
│   ├── run.sh
│   └── src
│       ├── librato-ssl.lua
│       └── librato-statsd.lua

We will use the luatool to send our lua scripts to the chip. One of
the scripts uses [statsd](https://github.com/etsy/statsd) to aggregate
and send data to librato. The other version uses a custom made proxy
in python that supports payload signing.

├── proxy-librato
│   ├── app.py
│   ├── curlit.sh
│   └── play.py

This is the python proxy I was referring to above.


└── statsd
    └── config.js

This is an example configuration for statsd.
```
