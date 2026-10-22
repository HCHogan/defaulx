---nvim-mini/mini.nvim, every module that defines highlight groups.
---@param c defaulx.Theme
---@param o defaulx.Options
return function(c, o)
  local float = o.transparent and "NONE" or c.mantle
  local m = c.mode

  local ret = {
    MiniAnimateCursor = { reverse = true, nocombine = true },
    MiniAnimateNormalFloat = { link = "NormalFloat" },

    MiniClueBorder = { link = "FloatBorder" },
    MiniClueDescGroup = { fg = c.blue },
    MiniClueDescSingle = { fg = c.text },
    MiniClueNextKey = { fg = c.cyan, bold = true },
    MiniClueNextKeyWithPostkeys = { fg = c.red, bold = true },
    MiniClueSeparator = { fg = c.overlay0 },
    MiniClueTitle = { link = "FloatTitle" },

    MiniCmdlinePeekBorder = { link = "FloatBorder" },
    MiniCmdlinePeekLineNr = { fg = c.yellow },
    MiniCmdlinePeekNormal = { link = "NormalFloat" },
    MiniCmdlinePeekSep = { link = "SignColumn" },
    MiniCmdlinePeekSign = { fg = c.blue },
    MiniCmdlinePeekTitle = { link = "FloatTitle" },

    MiniCompletionActiveParameter = { link = "LspSignatureActiveParameter" },
    MiniCompletionDeprecated = { link = "DiagnosticDeprecated" },
    MiniCompletionInfoBorderOutdated = { fg = c.yellow, bg = float },

    MiniCursorword = { bg = c.surface1 },
    MiniCursorwordCurrent = { bg = c.surface1 },

    MiniDepsChangeAdded = { link = "diffAdded" },
    MiniDepsChangeRemoved = { link = "diffRemoved" },
    MiniDepsHint = { link = "DiagnosticHint" },
    MiniDepsInfo = { link = "DiagnosticInfo" },
    MiniDepsMsgBreaking = { link = "DiagnosticWarn" },
    MiniDepsPlaceholder = { link = "Comment" },
    MiniDepsTitle = { link = "Title" },
    MiniDepsTitleError = { fg = c.crust, bg = c.red },
    MiniDepsTitleSame = { link = "DiffText" },
    MiniDepsTitleUpdate = { fg = c.crust, bg = c.green },

    MiniDiffSignAdd = { fg = c.git.add },
    MiniDiffSignChange = { fg = c.git.change },
    MiniDiffSignDelete = { fg = c.git.delete },
    MiniDiffOverAdd = { link = "DiffAdd" },
    MiniDiffOverChange = { link = "DiffText" },
    MiniDiffOverChangeBuf = { link = "MiniDiffOverChange" },
    MiniDiffOverContext = { link = "DiffChange" },
    MiniDiffOverContextBuf = {},
    MiniDiffOverDelete = { link = "DiffDelete" },

    MiniFilesBorder = { link = "FloatBorder" },
    MiniFilesBorderModified = { fg = c.yellow, bg = float },
    MiniFilesCursorLine = { bg = c.surface1 },
    MiniFilesDirectory = { link = "Directory" },
    MiniFilesFile = { fg = c.text },
    MiniFilesNormal = { link = "NormalFloat" },
    MiniFilesTitle = { fg = c.overlay1, bg = float },
    MiniFilesTitleFocused = { fg = c.cyan, bg = float, bold = true },

    MiniHipatternsFixme = { fg = c.crust, bg = c.red, bold = true },
    MiniHipatternsHack = { fg = c.crust, bg = c.yellow, bold = true },
    MiniHipatternsNote = { fg = c.crust, bg = c.cyan, bold = true },
    MiniHipatternsTodo = { fg = c.crust, bg = c.blue, bold = true },

    MiniIconsAzure = { fg = c.azure },
    MiniIconsBlue = { fg = c.blue },
    MiniIconsCyan = { fg = c.cyan },
    MiniIconsGreen = { fg = c.green },
    MiniIconsGrey = { fg = c.subtext0 },
    MiniIconsOrange = { fg = c.orange },
    MiniIconsPurple = { fg = c.violet },
    MiniIconsRed = { fg = c.red },
    MiniIconsYellow = { fg = c.yellow },

    MiniIndentscopeSymbol = { fg = c.overlay1 },
    MiniIndentscopeSymbolOff = { fg = c.red },

    MiniJump = { sp = c.cyan, undercurl = true },
    MiniJump2dDim = { fg = c.overlay0 },
    MiniJump2dSpot = { fg = c.orange, bold = true, nocombine = true },
    MiniJump2dSpotAhead = { fg = c.cyan, nocombine = true },
    MiniJump2dSpotUnique = { fg = c.magenta, bold = true, nocombine = true },

    MiniMapNormal = { fg = c.overlay1, bg = float },
    MiniMapSymbolCount = { fg = c.overlay1 },
    MiniMapSymbolLine = { fg = c.cyan },
    MiniMapSymbolView = { fg = c.cyan },

    MiniNotifyBorder = { link = "FloatBorder" },
    MiniNotifyLspProgress = { fg = c.overlay1, bg = float },
    MiniNotifyNormal = { link = "NormalFloat" },
    MiniNotifyTitle = { link = "FloatTitle" },

    MiniOperatorsExchangeFrom = { link = "IncSearch" },

    MiniPickBorder = { link = "FloatBorder" },
    MiniPickBorderBusy = { fg = c.yellow, bg = float },
    MiniPickBorderText = { link = "FloatTitle" },
    MiniPickCursor = { blend = 100, nocombine = true },
    MiniPickHeader = { fg = c.blue },
    MiniPickIconDirectory = { link = "Directory" },
    MiniPickIconFile = { fg = c.text },
    MiniPickMatchCurrent = { bg = c.surface1 },
    MiniPickMatchMarked = { bg = c.visual },
    MiniPickMatchRanges = { fg = c.cyan, bold = true },
    MiniPickNormal = { link = "NormalFloat" },
    MiniPickPreviewLine = { link = "CursorLine" },
    MiniPickPreviewRegion = { link = "IncSearch" },
    MiniPickPrompt = { fg = c.cyan },
    MiniPickPromptCaret = { fg = c.cyan },
    MiniPickPromptPrefix = { fg = c.cyan, bold = true },

    MiniSnippetsCurrent = { sp = c.yellow, underdouble = true },
    MiniSnippetsCurrentReplace = { sp = c.red, underdouble = true },
    MiniSnippetsFinal = { sp = c.green, underdouble = true },
    MiniSnippetsUnvisited = { sp = c.cyan, underdouble = true },
    MiniSnippetsVisited = { sp = c.blue, underdouble = true },

    MiniStarterCurrent = { link = "MiniStarterItem" },
    MiniStarterFooter = { link = "Comment" },
    MiniStarterHeader = { fg = c.cyan, bold = true },
    MiniStarterInactive = { link = "Comment" },
    MiniStarterItem = { link = "Normal" },
    MiniStarterItemBullet = { fg = c.overlay0 },
    MiniStarterItemPrefix = { fg = c.orange, bold = true },
    MiniStarterSection = { fg = c.violet, bold = true },
    MiniStarterQuery = { fg = c.green, bold = true },

    MiniStatuslineModeNormal = { fg = c.crust, bg = m.normal, bold = true },
    MiniStatuslineModeInsert = { fg = c.crust, bg = m.insert, bold = true },
    MiniStatuslineModeVisual = { fg = c.crust, bg = m.visual, bold = true },
    MiniStatuslineModeReplace = { fg = c.crust, bg = m.replace, bold = true },
    MiniStatuslineModeCommand = { fg = c.crust, bg = m.command, bold = true },
    MiniStatuslineModeOther = { fg = c.crust, bg = m.other, bold = true },
    MiniStatuslineDevinfo = { fg = c.text, bg = c.surface1 },
    MiniStatuslineFileinfo = { link = "MiniStatuslineDevinfo" },
    MiniStatuslineFilename = { fg = c.subtext1, bg = c.mantle },
    MiniStatuslineInactive = { link = "StatusLineNC" },

    MiniSurround = { link = "IncSearch" },

    MiniTablineCurrent = { fg = c.text, bg = c.base, bold = true },
    MiniTablineVisible = { fg = c.subtext0, bg = c.mantle },
    MiniTablineHidden = { fg = c.overlay1, bg = c.mantle },
    MiniTablineModifiedCurrent = { fg = c.orange, bg = c.base, bold = true },
    MiniTablineModifiedVisible = { fg = c.orange, bg = c.mantle },
    MiniTablineModifiedHidden = { fg = c.orange, bg = c.mantle },
    MiniTablineFill = { bg = c.crust },
    MiniTablineTabpagesection = { fg = c.crust, bg = c.cyan, bold = true },
    MiniTablineTrunc = { fg = c.overlay1, bg = c.mantle },

    MiniTestEmphasis = { bold = true },
    MiniTestFail = { fg = c.red, bold = true },
    MiniTestPass = { fg = c.green, bold = true },

    MiniTrailspace = { bg = c.tint_red },
  }

  return ret
end
