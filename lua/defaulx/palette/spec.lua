---Source of truth for the palettes. `scripts/build.lua` resolves this into
---`lua/defaulx/palette/<variant>.lua`; nothing reads it at runtime.
---
---A value is one of:
---  "#rrggbb"                      fixed color (the Nvim* defaults are kept verbatim)
---  { L, C, H }                    Oklch, out-of-gamut chroma is reduced
---  { mix = { a, b, alpha } }      Oklab blend; a and b are hex or other keys
---  "key"                          alias of another key

local function grey(L, C)
  return { L, C or 0.011, 268 }
end

local function mix(a, b, alpha)
  return { mix = { a, b, alpha } }
end

-- Diagnostic and diff tints: dark variants blend the accent itself into the
-- background, the light one blends the pastel Nvim light colors instead,
-- since a dark accent at low alpha only greys the paper.
local function dark_tints()
  return {
    tint_red = mix("red", "base", 0.12),
    tint_yellow = mix("yellow", "base", 0.12),
    tint_green = mix("green", "base", 0.12),
    tint_cyan = mix("cyan", "base", 0.12),
    tint_blue = mix("blue", "base", 0.12),
    diff_add = mix("green", "base", 0.16),
    diff_delete = mix("red", "base", 0.16),
    diff_change = mix("blue", "base", 0.08),
    diff_text = mix("blue", "base", 0.24),
    diff_text_add = mix("green", "base", 0.28),
  }
end

local M = {}

M.order = { "encre", "lavis", "velin" }

M.variants = {
  -- Same fg/bg/comment/line-number values as the built-in default dark.
  encre = {
    background = "dark",
    colors = {
      crust = "#07080d",
      mantle = grey(0.168),
      base = "#14161b",
      surface0 = grey(0.250),
      surface1 = "#2c2e33",
      surface2 = grey(0.365),
      overlay0 = "#4f5258",
      overlay1 = grey(0.58),
      comment = "#9b9ea4",
      subtext0 = grey(0.76),
      subtext1 = "#c4c6cd",
      text = "#e0e2ea",
      bright = "#eef1f8",

      red = "#ffc0b9",
      yellow = "#fce094",
      green = "#b3f6c0",
      cyan = "#8cf8f7",
      blue = "#a6dbff",
      orange = { 0.885, 0.10, 55 },
      magenta = { 0.88, 0.095, 335 },
      violet = { 0.87, 0.065, 290 },
      azure = { 0.89, 0.07, 222 },

      escape = { 0.90, 0.10, 78 },
      parameter = { 0.91, 0.035, 60 },
      member = { 0.90, 0.045, 215 },
      module = { 0.86, 0.03, 260 },
      doc = { 0.72, 0.035, 175 },
      lifetime = { 0.86, 0.065, 55 },

      visual = { 0.38, 0.05, 250 },
      search = "#6b5300",
      inlay = grey(0.235),
      border = grey(0.45, 0.02),
    },
    tints = dark_tints(),
    terminal = {
      "surface1",
      { 0.85, 0.11, 22 },
      { 0.85, 0.11, 150 },
      { 0.87, 0.11, 90 },
      { 0.85, 0.11, 245 },
      { 0.85, 0.11, 335 },
      { 0.85, 0.11, 195 },
      "subtext1",
      "overlay0",
      "#ffc0b9",
      "#b3f6c0",
      "#fce094",
      "#a6dbff",
      { 0.91, 0.09, 330 },
      "#8cf8f7",
      "bright",
    },
  },

  -- encre with text and accents one step down.
  lavis = {
    background = "dark",
    colors = {
      crust = grey(0.150, 0.013),
      mantle = grey(0.178, 0.013),
      base = grey(0.205, 0.013),
      surface0 = grey(0.245, 0.013),
      surface1 = grey(0.290, 0.013),
      surface2 = grey(0.345, 0.013),
      overlay0 = grey(0.450, 0.013),
      overlay1 = grey(0.550, 0.013),
      comment = grey(0.650, 0.013),
      subtext0 = grey(0.650, 0.013),
      subtext1 = grey(0.740, 0.013),
      text = grey(0.890, 0.010),
      bright = "text",

      red = { 0.82, 0.10, 22 },
      yellow = { 0.82, 0.10, 90 },
      green = { 0.84, 0.10, 150 },
      cyan = { 0.85, 0.10, 195 },
      blue = { 0.82, 0.10, 245 },
      orange = { 0.82, 0.10, 55 },
      magenta = { 0.80, 0.09, 335 },
      violet = { 0.80, 0.06, 290 },
      azure = { 0.82, 0.07, 225 },

      escape = { 0.84, 0.10, 75 },
      parameter = { 0.86, 0.035, 60 },
      member = { 0.84, 0.045, 215 },
      module = { 0.80, 0.03, 260 },
      doc = { 0.70, 0.03, 175 },
      lifetime = { 0.80, 0.06, 55 },

      visual = { 0.34, 0.05, 250 },
      search = { 0.42, 0.08, 88 },
      inlay = grey(0.235, 0.013),
      border = { 0.40, 0.02, 268 },
    },
    tints = dark_tints(),
    terminal = {
      "surface1",
      { 0.80, 0.11, 22 },
      { 0.80, 0.11, 150 },
      { 0.82, 0.11, 90 },
      { 0.80, 0.11, 245 },
      { 0.80, 0.11, 335 },
      { 0.80, 0.11, 195 },
      "subtext1",
      "overlay0",
      { 0.89, 0.085, 22 },
      { 0.89, 0.085, 150 },
      { 0.89, 0.085, 90 },
      { 0.89, 0.085, 245 },
      { 0.89, 0.085, 335 },
      { 0.89, 0.085, 195 },
      "text",
    },
  },

  -- Mirror of the built-in default light. Cyan is the one deliberate change:
  -- NvimDarkCyan (#007373) only reaches 4.4:1 on the light background.
  velin = {
    background = "light",
    colors = {
      crust = "#eef1f8",
      mantle = grey(0.940),
      base = "#e0e2ea",
      surface0 = grey(0.872),
      surface1 = "#c4c6cd",
      surface2 = grey(0.76),
      overlay0 = "#9b9ea4",
      overlay1 = grey(0.56),
      comment = "#4f5258",
      subtext0 = grey(0.37),
      subtext1 = "#2c2e33",
      text = "#14161b",
      bright = "#07080d",

      red = "#590008",
      yellow = "#6b5300",
      green = "#005523",
      cyan = { 0.45, 0.086, 195 },
      blue = "#004c73",
      orange = { 0.47, 0.12, 55 },
      magenta = { 0.45, 0.14, 335 },
      violet = { 0.38, 0.10, 290 },
      azure = { 0.43, 0.08, 222 },

      escape = { 0.48, 0.10, 78 },
      parameter = { 0.34, 0.045, 60 },
      member = { 0.37, 0.055, 215 },
      module = { 0.39, 0.035, 260 },
      doc = { 0.46, 0.045, 175 },
      lifetime = { 0.46, 0.09, 55 },

      visual = { 0.835, 0.045, 250 },
      search = "#fce094",
      inlay = grey(0.89),
      border = grey(0.70, 0.02),
    },
    tints = {
      tint_red = mix("#ffc0b9", "base", 0.45),
      tint_yellow = mix("#fce094", "base", 0.45),
      tint_green = mix("#b3f6c0", "base", 0.45),
      tint_cyan = mix("#8cf8f7", "base", 0.40),
      tint_blue = mix("#a6dbff", "base", 0.45),
      diff_add = mix("#b3f6c0", "base", 0.60),
      diff_delete = mix("#ffc0b9", "base", 0.60),
      diff_change = mix("#a6dbff", "base", 0.30),
      diff_text = mix("#a6dbff", "base", 0.75),
      diff_text_add = mix("#b3f6c0", "base", 0.95),
    },
    terminal = {
      "surface1",
      { 0.48, 0.14, 22 },
      { 0.48, 0.12, 150 },
      { 0.50, 0.11, 85 },
      { 0.48, 0.12, 245 },
      { 0.48, 0.13, 335 },
      { 0.50, 0.10, 195 },
      "subtext1",
      "overlay0",
      "#590008",
      "#005523",
      "#6b5300",
      "#004c73",
      { 0.38, 0.13, 330 },
      "#007373",
      "bright",
    },
  },
}

return M
