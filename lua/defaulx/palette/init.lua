local M = {}

---@class defaulx.Palette
---@field background "dark"|"light"
---@field terminal string[]
---@field [string] string

M.variants = { "encre", "lavis", "velin" }

---@param variant string
---@return defaulx.Palette
function M.get(variant)
  if not vim.list_contains(M.variants, variant) then
    error(("defaulx: unknown variant %q, expected one of %s"):format(variant, table.concat(M.variants, ", ")))
  end
  return vim.deepcopy(require("defaulx.palette." .. variant))
end

return M
