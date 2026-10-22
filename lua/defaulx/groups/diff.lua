---Diff mode. Backgrounds are tints so syntax colors stay readable on top.
---@param c defaulx.Theme
return function(c)
  return {
    DiffAdd = { bg = c.diff_add },
    DiffChange = { bg = c.diff_change },
    DiffDelete = { fg = c.overlay1, bg = c.diff_delete },
    DiffText = { bg = c.diff_text },
    DiffTextAdd = { bg = c.diff_text_add },
  }
end
