---Built-in LSP and diagnostic groups, see :h lsp-highlight and :h diagnostic-highlights.
---@param c defaulx.Theme
return function(c)
  local ret = {
    LspReferenceText = { bg = c.surface1 },
    LspReferenceRead = { link = "LspReferenceText" },
    LspReferenceWrite = { bg = c.surface1, underline = true },
    LspReferenceTarget = { link = "LspReferenceText" },
    LspSignatureActiveParameter = { bg = c.surface1, bold = true },
    LspCodeLens = { fg = c.overlay1 },
    LspCodeLensSeparator = { fg = c.surface2 },
    LspInlayHint = { fg = c.overlay1, bg = c.inlay },
    LspInfoBorder = { link = "FloatBorder" },

    DiagnosticUnnecessary = { fg = c.overlay1 },
    DiagnosticDeprecated = { sp = c.overlay1, strikethrough = true },
  }

  for _, level in ipairs({ "Error", "Warn", "Info", "Hint", "Ok" }) do
    local key = level:lower()
    local fg, tint = c.diag[key], c.tint[key]
    ret["Diagnostic" .. level] = { fg = fg }
    ret["DiagnosticSign" .. level] = { fg = fg }
    ret["DiagnosticFloating" .. level] = { fg = fg }
    ret["DiagnosticVirtualText" .. level] = { fg = fg, bg = tint }
    ret["DiagnosticVirtualLines" .. level] = { fg = fg }
    ret["DiagnosticUnderline" .. level] = { sp = fg, undercurl = true }
  end

  return ret
end
