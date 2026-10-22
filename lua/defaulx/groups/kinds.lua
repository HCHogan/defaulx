---LSP completion item kinds, shared by completion and picker integrations.
local M = {}

M.links = {
  Array = "@punctuation.bracket",
  Boolean = "@boolean",
  Class = "@type",
  Color = "@constant",
  Constant = "@constant",
  Constructor = "@constructor",
  Enum = "@type",
  EnumMember = "@constant",
  Event = "@type",
  Field = "@variable.member",
  File = "Normal",
  Folder = "Directory",
  Function = "@function",
  Interface = "@lsp.type.interface",
  Key = "@variable.member",
  Keyword = "@keyword",
  Method = "@function.method",
  Module = "@module",
  Namespace = "@module",
  Null = "@constant.builtin",
  Number = "@number",
  Object = "@type",
  Operator = "@operator",
  Package = "@module",
  Property = "@property",
  Reference = "@variable",
  Snippet = "@attribute",
  String = "@string",
  Struct = "@type",
  Text = "Comment",
  TypeParameter = "@lsp.type.typeParameter",
  Unit = "@number",
  Value = "@constant",
  Variable = "@variable",
}

---@param prefix string e.g. "BlinkCmpKind"
---@return table<string, vim.api.keyset.highlight>
function M.groups(prefix)
  local ret = {}
  for kind, link in pairs(M.links) do
    ret[prefix .. kind] = { link = link }
  end
  return ret
end

return M
