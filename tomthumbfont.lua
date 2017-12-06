-- Lua Tom Thumb font
-- A very small 3 bits wide, 5 bits high bitmap font
-- Tom Thumb font is copyright (c) 2010 Robey Pointer (https://robey.lag.net/2010/01/23/tiny-monospace-font.html)
-- Conversion to Lua is copyright (c) 2017 Rudi Niemeijer
-- CC0 or CC-BY 3.0 license, whichever suits your needs

-- Usage: link this file to your Lua program with 'dofile("tomthumbfont.lua")'
--        Then call getCharData3x5(c) with the character which needs converting
--        A table type is returned, with in it 5 bytes that each contain 3 bits of character data

charSet3x5 = {
  { 0x0, 0x0, 0x0, 0x0, 0x0}, -- ' '
  { 0x2, 0x2, 0x2, 0x0, 0x2}, -- '!'
  { 0x5, 0x5, 0x0, 0x0, 0x0}, -- '"'
  { 0x5, 0x7, 0x5, 0x7, 0x5}, -- '#'
  { 0x3, 0x6, 0x3, 0x6, 0x2}, -- ' '
  { 0x4, 0x1, 0x2, 0x4, 0x1}, -- '%'
  { 0x6, 0x6, 0x7, 0x5, 0x3}, -- ''
  { 0x2, 0x2, 0x0, 0x0, 0x0}, -- '''
  { 0x1, 0x2, 0x2, 0x2, 0x1}, -- '('
  { 0x4, 0x2, 0x2, 0x2, 0x4}, -- ')'
  { 0x5, 0x2, 0x5, 0x0, 0x0}, -- ''
  { 0x0, 0x2, 0x7, 0x2, 0x0}, -- '+'
  { 0x0, 0x0, 0x0, 0x2, 0x4}, -- ','
  { 0x0, 0x0, 0x7, 0x0, 0x0}, -- '-'
  { 0x0, 0x0, 0x0, 0x0, 0x2}, -- '.'
  { 0x1, 0x1, 0x2, 0x3, 0x3}, -- '/'
  { 0x7, 0x5, 0x5, 0x5, 0x7}, -- '0'
  { 0x6, 0x2, 0x2, 0x2, 0x7}, -- '1'
  { 0x7, 0x1, 0x7, 0x4, 0x7}, -- '2'
  { 0x7, 0x1, 0x7, 0x1, 0x7}, -- '3'
  { 0x1, 0x3, 0x5, 0x7, 0x1}, -- '4'
  { 0x7, 0x4, 0x7, 0x1, 0x7}, -- '5'
  { 0x7, 0x4, 0x7, 0x5, 0x7}, -- '6'
  { 0x7, 0x1, 0x2, 0x4, 0x4}, -- '7'
  { 0x7, 0x5, 0x7, 0x5, 0x7}, -- '8'
  { 0x7, 0x5, 0x7, 0x1, 0x7}, -- '9'
  { 0x0, 0x2, 0x0, 0x2, 0x0}, -- ':'
  { 0x0, 0x2, 0x0, 0x6, 0x2}, -- ';'
  { 0x0, 0x0, 0x1, 0x2, 0x1}, -- '<'
  { 0x0, 0x7, 0x0, 0x7, 0x0}, -- '='
  { 0x0, 0x0, 0x2, 0x1, 0x2}, -- '>'
  { 0x7, 0x1, 0x3, 0x0, 0x2}, -- '?'
  { 0x2, 0x5, 0x7, 0x5, 0x3}, -- '@'
  { 0x2, 0x5, 0x7, 0x5, 0x5}, -- 'A'
  { 0x6, 0x5, 0x6, 0x5, 0x6}, -- 'B'
  { 0x3, 0x4, 0x4, 0x4, 0x3}, -- 'C'
  { 0x6, 0x5, 0x5, 0x5, 0x6}, -- 'D'
  { 0x7, 0x4, 0x7, 0x4, 0x7}, -- 'E'
  { 0x7, 0x4, 0x7, 0x4, 0x4}, -- 'F'
  { 0x3, 0x4, 0x7, 0x5, 0x3}, -- 'G'
  { 0x5, 0x5, 0x7, 0x5, 0x5}, -- 'H'
  { 0x7, 0x2, 0x2, 0x2, 0x7}, -- 'I'
  { 0x1, 0x1, 0x1, 0x5, 0x2}, -- 'J'
  { 0x5, 0x5, 0x6, 0x5, 0x5}, -- 'K'
  { 0x4, 0x4, 0x4, 0x4, 0x7}, -- 'L'
  { 0x5, 0x7, 0x7, 0x5, 0x5}, -- 'M'
  { 0x5, 0x7, 0x7, 0x7, 0x5}, -- 'N'
  { 0x2, 0x5, 0x5, 0x5, 0x2}, -- 'O'
  { 0x6, 0x5, 0x6, 0x4, 0x4}, -- 'P'
  { 0x2, 0x5, 0x5, 0x7, 0x3}, -- 'Q'
  { 0x6, 0x5, 0x6, 0x5, 0x5}, -- 'R'
  { 0x3, 0x4, 0x2, 0x1, 0x6}, -- 'S'
  { 0x7, 0x2, 0x2, 0x2, 0x2}, -- 'T'
  { 0x5, 0x5, 0x5, 0x5, 0x3}, -- 'U'
  { 0x5, 0x5, 0x5, 0x2, 0x2}, -- 'V'
  { 0x5, 0x5, 0x7, 0x7, 0x5}, -- 'W'
  { 0x5, 0x5, 0x2, 0x5, 0x5}, -- 'X'
  { 0x5, 0x5, 0x2, 0x2, 0x2}, -- 'Y'
  { 0x7, 0x1, 0x2, 0x4, 0x7}, -- 'Z'
  { 0x7, 0x4, 0x4, 0x4, 0x7}, -- '['
  { 0x0, 0x4, 0x2, 0x1, 0x0}, -- '\'
  { 0x7, 0x1, 0x1, 0x1, 0x7}, -- ']'
  { 0x2, 0x5, 0x0, 0x0, 0x0}, -- '^'
  { 0x0, 0x0, 0x0, 0x0, 0x7}, -- '_'
  { 0x4, 0x2, 0x0, 0x0, 0x0}, -- '`'
  { 0x0, 0x6, 0x3, 0x5, 0x7}, -- 'a'
  { 0x4, 0x6, 0x5, 0x5, 0x6}, -- 'b'
  { 0x0, 0x3, 0x4, 0x4, 0x3}, -- 'c'
  { 0x1, 0x1, 0x3, 0x5, 0x3}, -- 'd'
  { 0x0, 0x3, 0x5, 0x6, 0x3}, -- 'e'
  { 0x1, 0x2, 0x7, 0x2, 0x2}, -- 'f'
  { 0x0, 0x3, 0x7, 0x1, 0x6}, -- 'g'
  { 0x4, 0x6, 0x5, 0x5, 0x5}, -- 'h'
    { 0x2, 0x0, 0x2, 0x2, 0x2}, -- 'i'
    { 0x1, 0x0, 0x1, 0x5, 0x2}, -- 'j'
    { 0x4, 0x5, 0x6, 0x6, 0x5}, -- 'k'
    { 0x6, 0x2, 0x2, 0x2, 0x7}, -- 'l'
    { 0x0, 0x7, 0x7, 0x7, 0x5}, -- 'm'
    { 0x0, 0x6, 0x5, 0x5, 0x5}, -- 'n'
    { 0x0, 0x2, 0x5, 0x5, 0x2}, -- 'o'
    { 0x0, 0x6, 0x5, 0x6, 0x4}, -- 'p'
    { 0x0, 0x3, 0x5, 0x3, 0x1}, -- 'q'
    { 0x0, 0x3, 0x4, 0x4, 0x4}, -- 'r'
    { 0x0, 0x3, 0x6, 0x3, 0x6}, -- 's'
    { 0x2, 0x7, 0x2, 0x2, 0x3}, -- 't'
    { 0x0, 0x5, 0x5, 0x5, 0x3}, -- 'u'
    { 0x0, 0x5, 0x5, 0x7, 0x2}, -- 'v'
    { 0x0, 0x5, 0x7, 0x7, 0x7}, -- 'w'
    { 0x0, 0x5, 0x2, 0x2, 0x5}, -- 'x'
    { 0x0, 0x5, 0x3, 0x1, 0x2}, -- 'y'
    { 0x0, 0x7, 0x3, 0x6, 0x7}, -- 'z'
    { 0x3, 0x2, 0x4, 0x2, 0x3}, -- '{'
    { 0x2, 0x2, 0x0, 0x2, 0x2}, -- '|'
    { 0x6, 0x2, 0x1, 0x2, 0x6}, -- '}'
    { 0x3, 0x6, 0x0, 0x0, 0x0}, -- '~'
    { 0x7, 0x7, 0x7, 0x7, 0x7} -- ' '    
  }

function getCharData3x5(c) -- Return a table containing 5 bytes of 3 set bits 0b111
  local b = string.byte(c) - string.byte(' ') + 1
  if b >= 1 and b <= #charSet3x5 then
    return charSet3x5[b]
  else
    return charSet3x5[1]
  end
end
