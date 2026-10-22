---saghen/blink.cmp
---@param c defaulx.Theme
---@param o defaulx.Options
return function(c, o)
  local float = o.transparent and "NONE" or c.mantle

  local ret = {
    BlinkCmpMenu = { fg = c.subtext1, bg = float },
    BlinkCmpMenuBorder = { fg = c.border, bg = float },
    BlinkCmpMenuSelection = { link = "PmenuSel" },
    BlinkCmpScrollBarThumb = { bg = c.surface2 },
    BlinkCmpScrollBarGutter = { bg = float },
    BlinkCmpLabel = { fg = c.text },
    BlinkCmpLabelMatch = { fg = c.cyan, bold = true },
    BlinkCmpLabelDeprecated = { fg = c.overlay1, strikethrough = true },
    BlinkCmpLabelDetail = { fg = c.overlay1 },
    BlinkCmpLabelDescription = { fg = c.overlay1 },
    BlinkCmpSource = { fg = c.overlay0 },
    BlinkCmpGhostText = { fg = c.overlay1 },
    BlinkCmpKind = { fg = c.cyan },

    BlinkCmpDoc = { fg = c.text, bg = float },
    BlinkCmpDocBorder = { fg = c.border, bg = float },
    BlinkCmpDocSeparator = { fg = c.surface2, bg = float },
    BlinkCmpDocCursorLine = { bg = c.surface1 },
    BlinkCmpSignatureHelp = { link = "BlinkCmpDoc" },
    BlinkCmpSignatureHelpBorder = { link = "BlinkCmpDocBorder" },
    BlinkCmpSignatureHelpActiveParameter = { link = "LspSignatureActiveParameter" },
  }

  return vim.tbl_extend("force", ret, require("defaulx.groups.kinds").groups("BlinkCmpKind"))
end
