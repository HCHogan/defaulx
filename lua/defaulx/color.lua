---Color math in Oklab / Oklch. Used by the palette generator and for blends.
local M = {}

local function to_linear(c)
  return c <= 0.04045 and c / 12.92 or ((c + 0.055) / 1.055) ^ 2.4
end

local function to_srgb(c)
  if c < 0 then
    return -to_srgb(-c)
  end
  return c <= 0.0031308 and 12.92 * c or 1.055 * c ^ (1 / 2.4) - 0.055
end

local function cbrt(x)
  return x < 0 and -((-x) ^ (1 / 3)) or x ^ (1 / 3)
end

---@param hex string "#rrggbb"
---@return number[] rgb in 0..1
function M.hex_to_rgb(hex)
  hex = hex:gsub("^#", "")
  return {
    tonumber(hex:sub(1, 2), 16) / 255,
    tonumber(hex:sub(3, 4), 16) / 255,
    tonumber(hex:sub(5, 6), 16) / 255,
  }
end

---@param rgb number[]
---@return string
function M.rgb_to_hex(rgb)
  local function byte(c)
    return math.floor(math.max(0, math.min(1, c)) * 255 + 0.5)
  end
  return string.format("#%02x%02x%02x", byte(rgb[1]), byte(rgb[2]), byte(rgb[3]))
end

---@param rgb number[]
---@return number[] lab
function M.rgb_to_oklab(rgb)
  local r, g, b = to_linear(rgb[1]), to_linear(rgb[2]), to_linear(rgb[3])
  local l = cbrt(0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b)
  local m = cbrt(0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b)
  local s = cbrt(0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b)
  return {
    0.2104542553 * l + 0.7936177850 * m - 0.0040720468 * s,
    1.9779984951 * l - 2.4285922050 * m + 0.4505937099 * s,
    0.0259040371 * l + 0.7827717662 * m - 0.8086757660 * s,
  }
end

---@param lab number[]
---@return number[] rgb may fall outside 0..1
function M.oklab_to_rgb(lab)
  local L, a, b = lab[1], lab[2], lab[3]
  local l = (L + 0.3963377774 * a + 0.2158037573 * b) ^ 3
  local m = (L - 0.1055613458 * a - 0.0638541728 * b) ^ 3
  local s = (L - 0.0894841775 * a - 1.2914855480 * b) ^ 3
  return {
    to_srgb(4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s),
    to_srgb(-1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s),
    to_srgb(-0.0041960863 * l - 0.7034186147 * m + 1.7076147010 * s),
  }
end

---@param hex string
---@return number L, number C, number H
function M.hex_to_oklch(hex)
  local lab = M.rgb_to_oklab(M.hex_to_rgb(hex))
  local h = math.deg(math.atan2(lab[3], lab[2])) % 360
  return lab[1], math.sqrt(lab[2] ^ 2 + lab[3] ^ 2), h
end

local function in_gamut(rgb)
  for _, c in ipairs(rgb) do
    if c < -1e-4 or c > 1 + 1e-4 then
      return false
    end
  end
  return true
end

---Oklch to hex. Out-of-gamut colors keep lightness and hue and lose chroma.
---@param L number
---@param C number
---@param H number degrees
---@return string
function M.oklch(L, C, H)
  local h = math.rad(H)
  local function at(chroma)
    return M.oklab_to_rgb({ L, chroma * math.cos(h), chroma * math.sin(h) })
  end
  local rgb = at(C)
  if in_gamut(rgb) then
    return M.rgb_to_hex(rgb)
  end
  local lo, hi = 0, C
  for _ = 1, 40 do
    local mid = (lo + hi) / 2
    if in_gamut(at(mid)) then
      lo = mid
    else
      hi = mid
    end
  end
  return M.rgb_to_hex(at(lo))
end

---Interpolate in Oklab.
---@param fg string
---@param bg string
---@param alpha number weight of `fg`, 0..1
---@return string
function M.blend(fg, bg, alpha)
  local a, b = M.rgb_to_oklab(M.hex_to_rgb(fg)), M.rgb_to_oklab(M.hex_to_rgb(bg))
  local lab = {}
  for i = 1, 3 do
    lab[i] = a[i] * alpha + b[i] * (1 - alpha)
  end
  return M.rgb_to_hex(M.oklab_to_rgb(lab))
end

---@param hex string
---@return number
function M.luminance(hex)
  local rgb = M.hex_to_rgb(hex)
  local v = {}
  for i = 1, 3 do
    v[i] = to_linear(rgb[i])
  end
  return 0.2126 * v[1] + 0.7152 * v[2] + 0.0722 * v[3]
end

---WCAG 2 contrast ratio.
---@param a string
---@param b string
---@return number
function M.contrast(a, b)
  local x, y = M.luminance(a), M.luminance(b)
  if x < y then
    x, y = y, x
  end
  return (x + 0.05) / (y + 0.05)
end

return M
