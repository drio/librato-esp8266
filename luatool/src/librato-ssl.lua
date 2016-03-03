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
    gpio.write(3, gpio.LOW)
  end
end

tempStatus = function()
  status,temp,humi,temp_decimial,humi_decimial = dht.read11(conf.pins.temp)
  t = {
    plain = temp,
    hash  = crypto.toHex(crypto.hmac("md5", tostring(temp), conf.secret))
  }
  return cjson.encode(t)
end

payload = function()
  local t = tempStatus()
  local token = "cG9ydGFY...FAKE...mJhNDY2Zjhm"
  return "POST /metrics-api/v1/metrics/ HTTP/1.1\r\n"
    .. "Host: metrics.librato.com\r\n"
    .. "Authorization: Basic " .. token .. "\r\n"
    .. "User-Agent: foo/7.43.0\r\n"
    .. "Accept: */*\r\n"
    .. "Content-Type: application/json\r\n"
    .. "Content-Length: " .. string.len(t) .. "\r\n\r\n"
    .. t
end

sendData = function()
  sk = net.createConnection(net.TCP, 1)

  sk:on("connection", function()
    print("Conection! Sending.\n")
    sk:send(payload())
  end)

  sk:on("sent", function()
    print("sent!\n")
    sk:close()
  end)

  sk:connect(conf.server.port, conf.server.ip)
end

conf = {
  period = 5,
  wifi   = { ssid='xxx', pwd='yyy' },
  pins   = { board=3, temp=6 },
  -- server = { port=5000, ip='192.168.1.212' },
  server = { port=443, ip='54.83.59.208' },
  secret = "secret",
}

wifiUp()
tmr.alarm(0, 4000, 0, check)
tmr.alarm(1, conf.period*1000, 1, sendData)
