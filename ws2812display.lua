-- ws2812display.lua
-- Basic display functions for addressing a serial led string into orthogonal x,y
-- Copyright (c) 2017 Rudi Niemeijer
-- MIT License

displayWidth = 39
displayHeight = 5

ws2812.init(ws2812.MODE_SINGLE) -- D4/GPIO2
leds = displayWidth * displayHeight
disp = ws2812.newBuffer(leds, 3) -- Display buffer with 3 colors fixed

brightness = 1 -- 1..255, note that color depth decreases with brightness

function clear() -- Clear the display buffer
  disp:fill(0, 0, 0) -- clear buffer
end

function plot(x, y, hue) -- Set a led at x, y with color hue
  if (x >= 1) and (x <= displayWidth) and (y >= 1) and (y <= displayHeight) then
    plotPos = toLineair(x, y)
    disp:set(plotPos, hueToRGB(hue))
  end
end

function unplot(x, y) -- Un-set a led at x, y
  plot(x, y, -1)
end

function isset(x, y) -- Return true if pixel at x, y is set, otherwise false
  if (x >= 1) and (x <= displayWidth) and (y >= 1) and (y <= displayHeight) then
    local a, b, c = disp:get(toLineair(x, y))
  else
    local a, b, c = 0, 0, 0
  end
  if a + b + c > 0 then
    return true
  else
    return false
  end
end

function hueToRGB(h) -- Convert floating point hue to integer R, G, B
  if h <= 0 then
    r, g, b = 0, 0, 0
  elseif h >= 1 then
    r, g, b = 1, 1, 1
  else
    if h < 1 / 3 then
      r = 2 - h * 6
      g = h * 6
      b = 0
    elseif h < 2 / 3 then
      r = 0
      g = 4 - h * 6
      b = h * 6 - 2
    else
      r = h * 6 - 4
      g = 0
      b = (1 - h) * 6
    end
  end
  if r > 1 then
    r = 1
  end
  if g > 1 then
    g = 1
  end
  if b > 1 then
    b = 1
  end
  r = r * brightness
  g = g * brightness
  b = b * brightness
  return string.char(g, r, b) -- Note the order of RGB
end

function toLineair(x, y)
  linPos = (y - 1) * displayWidth + x
  return linPos
end

function initDisplay()
  disp:fill(0, 0, 0) -- clear buffer
  ws2812.write(disp) -- write buffer to display
end

function repaint()
  ws2812.write(disp) -- write buffer to display
end

initDisplay()
