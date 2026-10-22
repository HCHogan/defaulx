---folke/noice.nvim
---@param c defaulx.Theme
---@param o defaulx.Options
return function(c, o)
  local float = o.transparent and "NONE" or c.mantle

  local ret = {
    NoiceCmdline = { link = "MsgArea" },
    NoiceCmdlinePrompt = { link = "Title" },
    NoiceCmdlinePopup = { fg = c.text, bg = float },
    NoiceCmdlinePopupBorder = { fg = c.cyan, bg = float },
    NoiceCmdlinePopupTitle = { fg = c.cyan, bg = float, bold = true },
    NoiceCmdlineIcon = { fg = c.cyan },
    NoiceCmdlinePopupBorderSearch = { fg = c.yellow, bg = float },
    NoiceCmdlinePopupTitleSearch = { fg = c.yellow, bg = float, bold = true },
    NoiceCmdlineIconSearch = { fg = c.yellow },
    NoiceConfirm = { link = "NormalFloat" },
    NoiceConfirmBorder = { fg = c.cyan, bg = float },

    NoiceMini = { fg = c.subtext1, bg = float },
    NoicePopup = { link = "NormalFloat" },
    NoicePopupBorder = { link = "FloatBorder" },
    NoiceSplit = { link = "NormalFloat" },
    NoiceSplitBorder = { link = "FloatBorder" },
    NoicePopupmenu = { link = "Pmenu" },
    NoicePopupmenuBorder = { link = "PmenuBorder" },
    NoicePopupmenuMatch = { fg = c.cyan, bold = true },
    NoicePopupmenuSelected = { link = "PmenuSel" },
    NoiceScrollbar = { link = "PmenuSbar" },
    NoiceScrollbarThumb = { link = "PmenuThumb" },
    NoiceVirtualText = { link = "DiagnosticVirtualTextInfo" },

    NoiceFormatTitle = { fg = c.cyan, bold = true },
    NoiceFormatEvent = { fg = c.overlay1 },
    NoiceFormatKind = { fg = c.overlay1 },
    NoiceFormatDate = { fg = c.overlay1 },
    NoiceFormatConfirm = { bg = c.surface1 },
    NoiceFormatConfirmDefault = { bg = c.visual, bold = true },
    NoiceFormatProgressDone = { fg = c.crust, bg = c.cyan },
    NoiceFormatProgressTodo = { bg = c.surface1 },
    NoiceFormatLevelError = { fg = c.diag.error },
    NoiceFormatLevelWarn = { fg = c.diag.warn },
    NoiceFormatLevelInfo = { fg = c.diag.info },
    NoiceFormatLevelDebug = { fg = c.overlay1 },
    NoiceFormatLevelTrace = { fg = c.violet },
    NoiceFormatLevelOff = { fg = c.overlay0 },
    NoiceLspProgressTitle = { fg = c.overlay1 },
    NoiceLspProgressClient = { fg = c.cyan, bold = true },
    NoiceLspProgressSpinner = { fg = c.cyan },
  }

  return vim.tbl_extend("force", ret, require("defaulx.groups.kinds").groups("NoiceCompletionItemKind"))
end
