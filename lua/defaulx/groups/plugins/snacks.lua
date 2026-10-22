---folke/snacks.nvim
---@param c defaulx.Theme
---@param o defaulx.Options
return function(c, o)
  local blend = require("defaulx.color").blend
  local float = o.transparent and "NONE" or c.mantle

  local ret = {
    SnacksBackdrop = { bg = c.crust },
    SnacksTitle = { link = "FloatTitle" },
    SnacksWinKey = { fg = c.orange },
    SnacksWinKeySep = { fg = c.overlay0 },
    SnacksWinKeyDesc = { fg = c.cyan },
    SnacksZenIcon = { fg = c.yellow },
    SnacksDim = { fg = c.overlay0 },

    SnacksDashboardNormal = { link = "Normal" },
    SnacksDashboardHeader = { fg = c.cyan },
    SnacksDashboardTitle = { fg = c.cyan, bold = true },
    SnacksDashboardIcon = { fg = c.blue },
    SnacksDashboardKey = { fg = c.orange, bold = true },
    SnacksDashboardDesc = { fg = c.text },
    SnacksDashboardFile = { fg = c.text },
    SnacksDashboardDir = { fg = c.overlay1 },
    SnacksDashboardSpecial = { fg = c.violet },
    SnacksDashboardFooter = { fg = c.overlay1, italic = true },

    SnacksIndent = { fg = c.surface1 },
    SnacksIndentScope = { fg = c.overlay0 },

    SnacksInputNormal = { link = "NormalFloat" },
    SnacksInputBorder = { fg = c.cyan, bg = float },
    SnacksInputTitle = { fg = c.cyan, bg = float, bold = true },
    SnacksInputIcon = { fg = c.blue },

    SnacksNotifierHistory = { link = "NormalFloat" },
    SnacksNotifierHistoryTitle = { fg = c.cyan, bold = true },
    SnacksNotifierHistoryDateTime = { fg = c.overlay1 },
    SnacksNotifierMinimal = { link = "NormalFloat" },

    SnacksPickerInputBorder = { fg = c.cyan, bg = float },
    SnacksPickerInputTitle = { fg = c.cyan, bg = float, bold = true },
    SnacksPickerBoxTitle = { fg = c.cyan, bg = float, bold = true },
    SnacksPickerListTitle = { fg = c.subtext1, bg = float, bold = true },
    SnacksPickerPreviewTitle = { fg = c.green, bg = float, bold = true },
    SnacksPickerPrompt = { fg = c.cyan },
    SnacksPickerInputSearch = { fg = c.orange },
    SnacksPickerMatch = { fg = c.cyan, bold = true },
    SnacksPickerSearch = { link = "Search" },
    SnacksPickerSelected = { fg = c.orange },
    SnacksPickerUnselected = { fg = c.overlay0 },
    SnacksPickerTotals = { fg = c.overlay1 },
    SnacksPickerSpinner = { fg = c.cyan },
    SnacksPickerIdx = { fg = c.orange },
    SnacksPickerLabel = { fg = c.orange, bold = true },
    SnacksPickerPickWin = { fg = c.crust, bg = c.cyan, bold = true },
    SnacksPickerPickWinCurrent = { fg = c.crust, bg = c.orange, bold = true },

    SnacksPickerFile = { fg = c.text },
    SnacksPickerDir = { fg = c.overlay1 },
    SnacksPickerDirectory = { fg = c.blue },
    SnacksPickerPathHidden = { fg = c.overlay1 },
    SnacksPickerPathIgnored = { fg = c.overlay0 },
    SnacksPickerTree = { fg = c.surface2 },
    SnacksPickerRow = { fg = c.overlay1 },
    SnacksPickerCol = { fg = c.overlay0 },
    SnacksPickerDimmed = { fg = c.overlay0 },
    SnacksPickerDesc = { fg = c.overlay1 },
    SnacksPickerComment = { fg = c.syn.comment },
    SnacksPickerDiagnosticCode = { fg = c.overlay1 },
    SnacksPickerDiagnosticSource = { fg = c.overlay1 },

    SnacksPickerGitCommit = { fg = c.yellow },
    SnacksPickerGitAuthor = { fg = c.blue },
    SnacksPickerGitDate = { fg = c.overlay1 },
    SnacksPickerGitBranch = { fg = c.magenta, bold = true },
    SnacksPickerGitBranchCurrent = { fg = c.green, bold = true },
    SnacksPickerGitDetached = { fg = c.yellow },
    SnacksPickerGitType = { fg = c.cyan, bold = true },
    SnacksPickerGitScope = { fg = c.overlay1, italic = true },
    SnacksPickerGitBreaking = { fg = c.red, bold = true },
    SnacksPickerGitIssue = { fg = c.orange },
    SnacksPickerGitStatusAdded = { fg = c.git.add },
    SnacksPickerGitStatusModified = { fg = c.git.change },
    SnacksPickerGitStatusDeleted = { fg = c.git.delete },
    SnacksPickerGitStatusRenamed = { fg = c.blue },
    SnacksPickerGitStatusCopied = { fg = c.blue },
    SnacksPickerGitStatusStaged = { fg = c.green, bold = true },
    SnacksPickerGitStatusUnmerged = { fg = c.red, bold = true },
    SnacksPickerGitStatusUntracked = { fg = c.git.untracked },
    SnacksPickerGitStatusIgnored = { fg = c.git.ignored },

    SnacksPickerKeymapLhs = { fg = c.cyan },
    SnacksPickerKeymapMode = { fg = c.orange },
    SnacksPickerKeymapRhs = { fg = c.overlay1 },
    SnacksPickerKeymapNowait = { fg = c.violet, italic = true },
    SnacksPickerUndoCurrent = { fg = c.cyan, bold = true },
    SnacksPickerUndoSaved = { fg = c.green },
  }

  -- Rainbow indent guides, muted so they read as guides, not syntax.
  for i, color in ipairs({ c.cyan, c.blue, c.violet, c.magenta, c.orange, c.yellow, c.green, c.red }) do
    ret["SnacksIndent" .. i] = { fg = blend(color, c.base, 0.45) }
  end

  local levels = {
    Error = c.diag.error,
    Warn = c.diag.warn,
    Info = c.diag.info,
    Debug = c.overlay1,
    Trace = c.violet,
  }
  for level, color in pairs(levels) do
    ret["SnacksNotifier" .. level] = { fg = c.text, bg = float }
    ret["SnacksNotifierBorder" .. level] = { fg = blend(color, c.mantle, 0.6), bg = float }
    ret["SnacksNotifierIcon" .. level] = { fg = color }
    ret["SnacksNotifierTitle" .. level] = { fg = color, bold = true }
    ret["SnacksNotifierFooter" .. level] = { fg = blend(color, c.mantle, 0.6) }
  end

  return ret
end
