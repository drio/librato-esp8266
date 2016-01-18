-- vim: set ts=2 et:
wifiUp = function()
  wifi.setmode(wifi.STATION)
  wifi.sta.config(conf.wifi.ssid, conf.wifi.pwd)
  wifi.sta.connect()
end

check = function()
  gpio.mode(3, gpio.OUTPUT)
  ip = wifi.sta.getip()
  if ip ~= nil then
    print(ip)
    blink()
  end
end

blink = function()
  gpio.write(3, gpio.HIGH)
  tmr.delay(500000)
  gpio.write(3, gpio.LOW)
  tmr.delay(500000)
  gpio.write(3, gpio.HIGH)
  tmr.delay(500000)
end

tempStatusSD = function()
  status,temp,humi,temp_decimial,humi_decimial = dht.read11(conf.pins.temp)
  return 'drd_temp_iot:' .. temp .. '|g' .. "\n" ..
         'drd_humi_iot:' .. humi .. '|g' .. "\n"
end

payload = function()
  return tempStatusSD() .. "\n"
end

sendData = function()
  sk = net.createConnection(net.TCP, 0)

  sk:on("connection", function()
    sk:send(payload())
  end)

  sk:on("sent", function()
    blink()
    sk:close()
  end)

  sk:connect(conf.server.port, conf.server.ip)

  goToSleep()
end

goToSleep = function()
  tmr.alarm(5, 2000, 0, function()
    node.dsleep(conf.sleepMS, 4)
  end)
end

conf = {
  period = 5,
  sleepMS = 60*1000000,
  wifi   = { ssid='xxxx', pwd='yyy' },
  pins   = { board=3, temp=6 },
  -- server = { port=5000, ip='192.168.1.212' },
  server = { port=8125, ip='192.168.1.194' },
  secret = "secret",
}

wifiUp()
tmr.alarm(0, 4000, 0, sendData)
