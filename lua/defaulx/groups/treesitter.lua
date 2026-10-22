---Tree-sitter captures, see :h treesitter-highlight-groups.
---@param c defaulx.Theme
---@param o defaulx.Options
return function(c, o)
  local s = c.syn
  local st = o.styles
  local keyword = vim.tbl_extend("force", { fg = s.keyword }, st.keywords)

  return {
    ["@variable"] = vim.tbl_extend("force", { fg = s.variable }, st.variables),
    ["@variable.builtin"] = { fg = s.keyword, italic = true },
    ["@variable.parameter"] = { fg = s.parameter },
    ["@variable.parameter.builtin"] = { fg = s.parameter, italic = true },
    ["@variable.member"] = { fg = s.member },

    ["@constant"] = { fg = s.constant },
    ["@constant.builtin"] = { fg = s.constant },
    ["@constant.macro"] = { fg = s.constant },

    ["@module"] = { fg = s.module },
    ["@module.builtin"] = { fg = s.module, italic = true },
    ["@label"] = { fg = s.lifetime, italic = true },

    ["@string"] = { link = "String" },
    ["@string.documentation"] = { fg = s.doc },
    ["@string.regexp"] = { fg = s.escape },
    ["@string.escape"] = { fg = s.escape },
    ["@string.special"] = { fg = s.escape },
    ["@string.special.symbol"] = { fg = s.constant },
    ["@string.special.path"] = { fg = c.blue },
    ["@string.special.url"] = { fg = c.cyan, underline = true },

    ["@character"] = { link = "Character" },
    ["@character.special"] = { fg = s.escape },
    ["@boolean"] = { link = "Boolean" },
    ["@number"] = { link = "Number" },
    ["@number.float"] = { link = "Number" },

    ["@type"] = { link = "Type" },
    ["@type.builtin"] = vim.tbl_extend("force", { fg = s.type_builtin }, st.types),
    ["@type.definition"] = { link = "Type" },

    ["@attribute"] = { fg = s.attribute },
    ["@attribute.builtin"] = { fg = s.attribute },
    ["@property"] = { fg = s.member },

    ["@function"] = { link = "Function" },
    ["@function.builtin"] = { link = "Function" },
    ["@function.call"] = { link = "Function" },
    ["@function.macro"] = { fg = s.macro },
    ["@function.method"] = { link = "Function" },
    ["@function.method.call"] = { link = "Function" },
    ["@constructor"] = { fg = s.type },
    ["@operator"] = { link = "Operator" },

    ["@keyword"] = keyword,
    ["@keyword.coroutine"] = { link = "@keyword" },
    ["@keyword.function"] = { link = "@keyword" },
    ["@keyword.operator"] = { link = "@keyword" },
    ["@keyword.import"] = { link = "@keyword" },
    ["@keyword.type"] = { link = "@keyword" },
    ["@keyword.modifier"] = { link = "@keyword" },
    ["@keyword.repeat"] = { link = "@keyword" },
    ["@keyword.return"] = { link = "@keyword" },
    ["@keyword.debug"] = { fg = c.orange },
    ["@keyword.exception"] = { link = "@keyword" },
    ["@keyword.conditional"] = { link = "@keyword" },
    ["@keyword.conditional.ternary"] = { link = "Operator" },
    ["@keyword.directive"] = { fg = s.macro },
    ["@keyword.directive.define"] = { fg = s.macro },

    ["@punctuation.delimiter"] = { link = "Delimiter" },
    ["@punctuation.bracket"] = { fg = s.bracket },
    ["@punctuation.special"] = { fg = s.special },

    ["@comment"] = { link = "Comment" },
    ["@comment.documentation"] = { fg = s.doc },
    ["@comment.error"] = { fg = c.diag.error, bold = true },
    ["@comment.warning"] = { fg = c.diag.warn, bold = true },
    ["@comment.todo"] = { fg = c.blue, bold = true },
    ["@comment.note"] = { fg = c.cyan, bold = true },

    ["@markup.strong"] = { bold = true },
    ["@markup.italic"] = { italic = true },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.heading"] = { fg = c.cyan, bold = true },
    ["@markup.heading.1"] = { fg = c.cyan, bold = true },
    ["@markup.heading.2"] = { fg = c.blue, bold = true },
    ["@markup.heading.3"] = { fg = c.green, bold = true },
    ["@markup.heading.4"] = { fg = c.orange, bold = true },
    ["@markup.heading.5"] = { fg = c.magenta, bold = true },
    ["@markup.heading.6"] = { fg = c.violet, bold = true },
    ["@markup.quote"] = { fg = c.subtext0, italic = true },
    ["@markup.math"] = { fg = c.blue },
    ["@markup.link"] = { fg = c.cyan },
    ["@markup.link.label"] = { fg = c.blue },
    ["@markup.link.url"] = { fg = c.cyan, underline = true },
    ["@markup.raw"] = { fg = c.azure },
    ["@markup.raw.block"] = { fg = c.subtext1 },
    ["@markup.list"] = { fg = c.cyan },
    ["@markup.list.checked"] = { fg = c.green },
    ["@markup.list.unchecked"] = { fg = c.overlay1 },

    ["@diff.plus"] = { fg = c.git.add },
    ["@diff.minus"] = { fg = c.git.delete },
    ["@diff.delta"] = { fg = c.git.change },

    ["@tag"] = { fg = s.tag },
    ["@tag.builtin"] = { fg = s.tag },
    ["@tag.attribute"] = { fg = s.member, italic = true },
    ["@tag.delimiter"] = { fg = s.delimiter },

    ["@none"] = {},
  }
end
