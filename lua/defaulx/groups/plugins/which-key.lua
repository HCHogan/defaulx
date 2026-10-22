---folke/which-key.nvim
---@param c defaulx.Theme
return function(c)
  return {
    WhichKey = { fg = c.cyan },
    WhichKeyGroup = { fg = c.blue },
    WhichKeyDesc = { fg = c.text },
    WhichKeySeparator = { fg = c.overlay0 },
    WhichKeyValue = { fg = c.overlay1 },
    WhichKeyIcon = { fg = c.blue },
    WhichKeyNormal = { link = "NormalFloat" },
    WhichKeyBorder = { link = "FloatBorder" },
    WhichKeyTitle = { link = "FloatTitle" },
  }
end
