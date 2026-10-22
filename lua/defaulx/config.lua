local M = {}

---@class defaulx.Styles
---@field comments? vim.api.keyset.highlight
---@field keywords? vim.api.keyset.highlight
---@field functions? vim.api.keyset.highlight
---@field variables? vim.api.keyset.highlight
---@field types? vim.api.keyset.highlight

---@class defaulx.Options
M.defaults = {
  -- Variant `:colorscheme defaulx` picks for each 'background'.
  dark = "encre",
  light = "velin",
  -- Leave Normal, NormalFloat and the sidebars without a background.
  transparent = false,
  ---@type defaulx.Styles
  styles = {
    comments = {},
    keywords = { bold = true },
    functions = {},
    variables = {},
    types = {},
  },
  -- Plugin integrations. `all` covers everything not named explicitly;
  -- `{ all = false, snacks = true }` enables snacks only.
  ---@type table<string, boolean>
  plugins = { all = true },
  -- Change palette colors before highlights are built.
  ---@type fun(palette: defaulx.Palette, variant: string)?
  on_palette = nil,
  -- Change highlights after they are built.
  ---@type fun(hl: table<string, vim.api.keyset.highlight>, c: defaulx.Theme, variant: string)?
  on_highlights = nil,
  -- Cache highlights for customized setups under stdpath("cache")/defaulx.
  cache = true,
}

---@type defaulx.Options
M.options = vim.deepcopy(M.defaults)

---@param opts? defaulx.Options
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", vim.deepcopy(M.defaults), opts or {})
end

---Whether highlights built with `opts` equal the precompiled ones shipped in
---lua/defaulx/compiled. `on_highlights` does not matter: it runs afterwards.
---@param opts defaulx.Options
function M.is_precompiled(opts)
  return opts.on_palette == nil
    and opts.transparent == M.defaults.transparent
    and vim.deep_equal(opts.styles, M.defaults.styles)
    and vim.deep_equal(opts.plugins, M.defaults.plugins)
end

return M
