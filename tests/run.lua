-- nvim --clean --headless -l tests/run.lua
-- Plain assertions, no test framework, so it runs offline and inside the Nix build.

local root = vim.fs.dirname(vim.fs.dirname(vim.fs.normalize(vim.fn.fnamemodify(arg[0], ":p"))))
vim.opt.rtp:prepend(root)

local cache = vim.fn.tempname()
vim.env.XDG_CACHE_HOME = cache
vim.o.termguicolors = true

local color = require("defaulx.color")
local failures, passed = 0, 0

local function check(ok, msg)
  if ok then
    passed = passed + 1
  else
    failures = failures + 1
    -- selene: allow(incorrect_standard_library_use)
    io.stderr:write("FAIL " .. msg .. "\n")
  end
end

local function hl(name)
  return vim.api.nvim_get_hl(0, { name = name, link = false })
end

local function hex(n)
  return n and ("#%06x"):format(n)
end

local function contrast(fg, bg)
  return color.contrast(fg, bg)
end

local variants = require("defaulx.palette").variants

-- Contrast floors. encre and velin keep the built-in default's 14:1 body text.
local floors = {
  encre = { body = 13.5 },
  lavis = { body = 11 },
  velin = { body = 13.5 },
}

local syntax_groups = {
  "@keyword",
  "@type",
  "@type.builtin",
  "@function",
  "@function.macro",
  "@string",
  "@string.escape",
  "@number",
  "@constant",
  "@variable",
  "@variable.parameter",
  "@variable.member",
  "@module",
  "@label",
  "@operator",
  "@punctuation.bracket",
  "@punctuation.delimiter",
  "@comment",
  "@comment.documentation",
  "@attribute",
  "@property",
  "@constructor",
}

for _, variant in ipairs(variants) do
  vim.cmd.colorscheme("defaulx-" .. variant)
  local name = "defaulx-" .. variant
  check(vim.g.colors_name == name, name .. ": colors_name is " .. tostring(vim.g.colors_name))

  local palette = require("defaulx.palette").get(variant)
  check(vim.o.background == palette.background, name .. ": background")

  local normal = hl("Normal")
  local bg, fg = hex(normal.bg), hex(normal.fg)
  check(contrast(fg, bg) >= floors[variant].body, ("%s: body text %.1f"):format(name, contrast(fg, bg)))

  for _, group in ipairs(syntax_groups) do
    local g = hl(group)
    local gfg = hex(g.fg) or fg
    local ratio = contrast(gfg, bg)
    check(ratio >= 4.5, ("%s: %s %.2f on Normal"):format(name, group, ratio))
  end

  local cl = hex(hl("CursorLine").bg)
  local comment = hex(hl("Comment").fg)
  check(contrast(comment, cl) >= 4.5, ("%s: Comment on CursorLine %.2f"):format(name, contrast(comment, cl)))
  check(contrast(fg, hex(hl("Visual").bg)) >= 4.5, name .. ": Normal on Visual")

  for _, pair in ipairs({ "Search", "CurSearch", "PmenuSel", "MiniStatuslineModeInsert", "FlashLabel" }) do
    local g = hl(pair)
    if g.fg and g.bg then
      local ratio = contrast(hex(g.fg), hex(g.bg))
      check(ratio >= 4.5, ("%s: %s fg/bg %.2f"):format(name, pair, ratio))
    end
  end

  for _, level in ipairs({ "Error", "Warn", "Info", "Hint", "Ok" }) do
    local g = hl("DiagnosticVirtualText" .. level)
    local ratio = contrast(hex(g.fg), hex(g.bg))
    check(ratio >= 4.5, ("%s: DiagnosticVirtualText%s %.2f"):format(name, level, ratio))
  end

  check(vim.g.terminal_color_0 == palette.terminal[1], name .. ": terminal colors")

  -- Every link must land on a group that exists, or the highlight silently vanishes.
  local all = vim.api.nvim_get_hl(0, {})
  local data = require("defaulx.compiled." .. variant)
  for group, spec in pairs(data.groups) do
    if spec.link then
      check(all[spec.link] ~= nil, ("%s: %s links to missing %s"):format(name, group, spec.link))
    end
  end
end

-- :colorscheme defaulx follows 'background'.
vim.o.background = "dark"
vim.cmd.colorscheme("defaulx")
check(vim.g.colors_name == "defaulx", "auto: colors_name")
check(hex(hl("Normal").bg) == require("defaulx.palette").get("encre").base, "auto: dark picks encre")
vim.o.background = "light"
check(hex(hl("Normal").bg) == require("defaulx.palette").get("velin").base, "auto: light switches to velin")

-- Integration registry matches the files on disk.
local Groups = require("defaulx.groups")
local files = {}
for file in vim.fs.dir(vim.fs.joinpath(root, "lua/defaulx/groups/plugins")) do
  files[file:gsub("%.lua$", "")] = true
end
for key, plugin in pairs(Groups.plugins) do
  check(files[plugin.module], "plugin " .. key .. " has no module file")
  check(plugin.url and plugin.url:match("^https://"), "plugin " .. key .. " has no url")
  files[plugin.module] = nil
end
check(next(files) == nil, "unregistered plugin modules: " .. table.concat(vim.tbl_keys(files), ", "))

-- Customized options go through the cache and still apply.
require("defaulx").setup({
  on_palette = function(p)
    p.cyan = "#00ff00"
  end,
  on_highlights = function(h)
    h.LineNr = { fg = "#ff0000" }
  end,
})
vim.cmd.colorscheme("defaulx-encre")
check(hex(hl("@function").fg) == "#00ff00", "on_palette reaches highlights")
check(hex(hl("LineNr").fg) == "#ff0000", "on_highlights applies")
local cached = vim.fs.joinpath(cache, "nvim", "defaulx", "encre.luac")
check(vim.uv.fs_stat(cached) ~= nil, "cache file written to " .. cached)
vim.uv.fs_utime(cached, 1, 1)
vim.cmd.colorscheme("defaulx-encre")
check(vim.uv.fs_stat(cached).mtime.sec == 1, "second load reuses the cache")
check(hex(hl("@function").fg) == "#00ff00", "cached highlights are correct")

-- on_highlights alone keeps the precompiled path.
require("defaulx.compile").clear_cache()
require("defaulx").setup({
  on_highlights = function(h)
    h.LineNr = { fg = "#ff0000" }
  end,
})
vim.cmd.colorscheme("defaulx-encre")
check(vim.uv.fs_stat(cached) == nil, "on_highlights alone does not build a cache")
check(hex(hl("LineNr").fg) == "#ff0000", "on_highlights applies on precompiled path")

io.write(("%d passed, %d failed\n"):format(passed, failures))
os.exit(failures > 0 and 1 or 0)
