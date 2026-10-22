---lewis6991/gitsigns.nvim
---@param c defaulx.Theme
return function(c)
  local blend = require("defaulx.color").blend
  local g = c.git

  local ret = {
    GitSignsAdd = { fg = g.add },
    GitSignsChange = { fg = g.change },
    GitSignsDelete = { fg = g.delete },
    GitSignsChangedelete = { link = "GitSignsChange" },
    GitSignsTopdelete = { link = "GitSignsDelete" },
    GitSignsUntracked = { fg = g.untracked },

    GitSignsAddInline = { bg = c.diff_text_add },
    GitSignsChangeInline = { bg = c.diff_text },
    GitSignsDeleteInline = { bg = blend(g.delete, c.base, 0.28) },
    GitSignsAddPreview = { link = "DiffAdd" },
    GitSignsDeletePreview = { link = "DiffDelete" },
    GitSignsDeleteVirtLn = { link = "DiffDelete" },
    GitSignsCurrentLineBlame = { fg = c.overlay1 },
  }

  -- Staged hunks: same hue, half strength.
  for _, kind in ipairs({ "Add", "Change", "Delete", "Changedelete", "Topdelete", "Untracked" }) do
    local base = ({ Add = g.add, Delete = g.delete, Topdelete = g.delete, Untracked = g.untracked })[kind] or g.change
    ret["GitSignsStaged" .. kind] = { fg = blend(base, c.base, 0.5) }
  end

  return ret
end
