local M = {}

---Applied in order; later modules win on conflicts.
M.base = { "editor", "syntax", "treesitter", "semantic", "lsp", "diff" }

---Integration name (as used in `opts.plugins`) to module and upstream repo.
M.plugins = {
  blink = { module = "blink", url = "https://github.com/saghen/blink.cmp" },
  flash = { module = "flash", url = "https://github.com/folke/flash.nvim" },
  gitsigns = { module = "gitsigns", url = "https://github.com/lewis6991/gitsigns.nvim" },
  mini = { module = "mini", url = "https://github.com/nvim-mini/mini.nvim" },
  noice = { module = "noice", url = "https://github.com/folke/noice.nvim" },
  snacks = { module = "snacks", url = "https://github.com/folke/snacks.nvim" },
  ["which-key"] = { module = "which-key", url = "https://github.com/folke/which-key.nvim" },
}

---@param opts defaulx.Options
---@param name string
function M.enabled(opts, name)
  local v = opts.plugins[name]
  if v == nil then
    return opts.plugins.all ~= false
  end
  return v
end

---@param c defaulx.Theme
---@param opts defaulx.Options
---@return table<string, vim.api.keyset.highlight>
function M.get(c, opts)
  local ret = {}
  local function add(mod)
    for name, hl in pairs(require(mod)(c, opts)) do
      ret[name] = hl
    end
  end
  for _, name in ipairs(M.base) do
    add("defaulx.groups." .. name)
  end
  local names = vim.tbl_keys(M.plugins)
  table.sort(names)
  for _, name in ipairs(names) do
    if M.enabled(opts, name) then
      add("defaulx.groups.plugins." .. M.plugins[name].module)
    end
  end
  return ret
end

return M
