local M = {}

---@param opts? defaulx.Options
function M.setup(opts)
  require("defaulx.config").setup(opts)
end

---Apply a variant. Without one, follow 'background' the way the built-in
---default does, and keep following it when 'background' changes.
---@param variant? "encre"|"lavis"|"velin"
function M.load(variant)
  local opts = require("defaulx.config").options
  local follow = variant == nil
  if follow then
    variant = vim.o.background == "light" and opts.light or opts.dark
  end
  ---@cast variant string

  local data = require("defaulx.compile").get(variant, opts)

  -- `:hi clear` also unsets g:colors_name, so the 'background' change below
  -- does not re-source whatever scheme was active before.
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end
  if vim.o.background ~= data.background then
    vim.o.background = data.background
  end

  local groups = data.groups
  if opts.on_highlights then
    groups = vim.deepcopy(groups)
    local palette = require("defaulx.palette").get(variant)
    if opts.on_palette then
      opts.on_palette(palette, variant)
    end
    opts.on_highlights(groups, require("defaulx.theme")(palette), variant)
  end

  for name, hl in pairs(groups) do
    vim.api.nvim_set_hl(0, name, hl)
  end
  for i, color in ipairs(data.terminal) do
    vim.g["terminal_color_" .. (i - 1)] = color
  end

  vim.g.colors_name = follow and "defaulx" or "defaulx-" .. variant
end

---The palette of a variant, for statuslines and other plugins.
---@param variant? string defaults to the active one
---@return defaulx.Palette
function M.palette(variant)
  local opts = require("defaulx.config").options
  variant = variant
    or (vim.g.colors_name or ""):match("^defaulx%-(%a+)$")
    or (vim.o.background == "light" and opts.light or opts.dark)
  local palette = require("defaulx.palette").get(variant)
  if opts.on_palette then
    opts.on_palette(palette, variant)
  end
  return palette
end

return M
