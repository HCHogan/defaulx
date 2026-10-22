---Legacy syntax groups, see :h group-name. Treesitter and many plugins link here.
---@param c defaulx.Theme
---@param o defaulx.Options
return function(c, o)
  local s = c.syn
  local keyword = vim.tbl_extend("force", { fg = s.keyword }, o.styles.keywords)

  return {
    Comment = vim.tbl_extend("force", { fg = s.comment }, o.styles.comments),
    SpecialComment = { fg = s.doc },
    Todo = { fg = c.crust, bg = c.yellow, bold = true },

    Constant = { fg = s.constant },
    String = { fg = s.string },
    Character = { fg = s.string },
    Number = { fg = s.number },
    Float = { link = "Number" },
    Boolean = { fg = s.constant },

    Identifier = vim.tbl_extend("force", { fg = s.member }, o.styles.variables),
    Function = vim.tbl_extend("force", { fg = s.func }, o.styles.functions),

    Statement = keyword,
    Conditional = { link = "Statement" },
    Repeat = { link = "Statement" },
    Label = { fg = s.lifetime },
    Keyword = { link = "Statement" },
    Exception = { link = "Statement" },
    Operator = { fg = s.operator },

    PreProc = { fg = s.macro },
    Include = { link = "Statement" },
    Define = { fg = s.macro },
    Macro = { fg = s.macro },
    PreCondit = { fg = s.macro },

    Type = vim.tbl_extend("force", { fg = s.type }, o.styles.types),
    StorageClass = { link = "Statement" },
    Structure = { link = "Statement" },
    Typedef = { link = "Statement" },

    Special = { fg = s.special },
    SpecialChar = { fg = s.escape },
    Tag = { fg = s.tag },
    Delimiter = { fg = s.delimiter },
    Debug = { fg = c.orange },

    Underlined = { underline = true },
    Bold = { bold = true },
    Italic = { italic = true },
    Ignore = { fg = c.overlay0 },
    Error = { fg = c.red },

    diffAdded = { fg = c.git.add },
    diffRemoved = { fg = c.git.delete },
    diffChanged = { fg = c.git.change },
    diffOldFile = { fg = c.orange },
    diffNewFile = { fg = c.blue },
    diffFile = { fg = c.blue, bold = true },
    diffLine = { fg = c.overlay1 },
    diffIndexLine = { fg = c.magenta },
    diffSubname = { fg = c.text },
  }
end
