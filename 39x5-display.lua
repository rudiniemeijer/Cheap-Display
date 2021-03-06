-- 39x5-display.lua
-- Main program for a cheap-and-easy RGB led display
-- Copyright (c) 2017 Rudi Niemeijer
-- MIT License

dofile("ws2812display.lua")
dofile("tomthumbfont.lua")

brightness=10 -- Can be 1..255. Note that brightnesses over 10 use too much current to be powered by a NodeMCU
clear()
task = "time"
msgStr = "hi, world"
msgHue = 0.1
cycle = 1
maxCycle = 5

-- Plot a character c on address x, y in color hue
-- x, y starts (1,1) in the lower-left corner
function plotchar3x5(c, x, y, hue) -- Plot character c 3x5 bits at x, y in hue
  for i = 1, 5 do
    for j = 1, 3 do
      if bit.isset(c[i], 3 - j) then
        plot(x + j - 1, y + (5 - i +1) - 1, hue)
      else
        unplot(x + j - 1, y + (5 - i +1) - 1)
      end
    end
    tmr.wdclr()
  end
end

-- Print a string of characters s starting at x, y in color hue
-- Repeatedly calls plotchar3x5 for each character in s
function plotstring3x5(s, x, y, hue) -- Plot a string of characters at x, y in hue
  if s ~= nil then
    for i = 1, #s do
      plotchar3x5(getCharData3x5(string.sub(s, i, i)), x + ((i - 1) * 4), y, hue) 
    end
  end
end

-- Get a text from somewhere, to show intermittedly
-- Round-robin cycles through maxCycle messages
function getMessage()
  if wifi.sta.status() == 5 then
    http.get("http://api.thingspeak.com/channels/370942/feeds.json?api_key=0S6ANV2R089MVOZH&results="..maxCycle, nil, function(code, data)
      if (code > 0) then
        local tab = sjson.decode(data)
        msgStr = tab["feeds"][cycle]["field1"]
        msgHue = tonumber(tab["feeds"][cycle]["field2"])
        if msgHue == nil then
          msgHue = 0.8
        end
        cycle = cycle + 1
        if cycle > maxCycle then
          cycle = 1
        end
      end
    end)
  end
end

-- Main routine for displaying time and other goodies
function display()
  if task == "time" then
    local tm = rtctime.epoch2cal(rtctime.get())
    -- print(string.format("%02d-%02d-%04d %02d:%02d:%02d", tm["day"], tm["mon"], tm["year"], tm["hour"], tm["min"], tm["sec"]))
    local dstHour = tm["hour"] + 1
    if dstHour > 23 then
      dstHour = 0
    end
    local timeStr = dstHour .. ":" .. string.format("%02d", tm["min"])
    print(timeStr)
    clear()
    -- plotstring3x5("Tijd", 1, 1, 0.1)
    plotstring3x5("T", 1, 1, node.random())
    plotstring3x5("I", 5, 1, node.random())
    plotstring3x5("M", 9, 1, node.random())
    plotstring3x5("E", 13, 1, node.random())
    plotstring3x5(timeStr, 20, 1, 1)
    task = "text"
  elseif task == "text" then
    print(msgStr)
    clear()
    plotstring3x5(msgStr, 1, 1, msgHue)
    task = "time"
  end
  repaint()
end

function resync()
  sntp.sync(nil, nil, nil, 1)
end

-- Three timers are used to get thing running
-- One for switching between time and other info
-- One for getting new messages from somewhere
-- One (onetime) for re-syncing
tmr.alarm(1, 10000, tmr.ALARM_AUTO, display)
tmr.alarm(2, 30000, tmr.ALARM_AUTO, getMessage)
tmr.alarm(3, 60000, tmr.ALARM_SINGLE, resync)
