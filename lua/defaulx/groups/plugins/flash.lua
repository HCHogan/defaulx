---folke/flash.nvim
---@param c defaulx.Theme
return function(c)
  return {
    FlashBackdrop = { fg = c.overlay0 },
    FlashMatch = { fg = c.bright, bg = c.visual },
    FlashCurrent = { fg = c.crust, bg = c.orange },
    -- Magenta is rare elsewhere, so jump labels never blend into the code.
    FlashLabel = { fg = c.crust, bg = c.magenta, bold = true },
    FlashPrompt = { link = "MsgArea" },
    FlashPromptIcon = { fg = c.cyan },
    FlashCursor = { reverse = true },
  }
end
