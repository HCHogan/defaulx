# defaulx

Neovim's default colorscheme, finished.

*defaulx* reads "day-foe": **default**, made **deluxe**. The built-in
colorscheme that shipped with Neovim 0.10 has the right bones, cold greys, a
green-blue accent, bold keywords, a palette designed in Oklch, but it stops
there: types, numbers and constants share the body text color, the popup menu
and the cursor line share a grey, and no plugin gets any attention. defaulx
keeps those bones and finishes the rest.

| Variant | Background | What it is |
|---|---|---|
| `defaulx-encre` (ink) | dark | Body text, comments and line numbers use the exact built-in values, 14:1 body contrast. The built-in red, yellow, green, cyan and blue stay; orange and magenta are added at the same Oklch lightness. |
| `defaulx-lavis` (ink wash) | dark | encre diluted: the same roles, with text and accents one step down. |
| `defaulx-velin` (vellum) | light | The built-in light scheme, mirrored the same way. Its one deliberate change: `NvimDarkCyan` only reaches 4.4:1, so cyan is a step darker. |

`:colorscheme defaulx` follows `'background'` like the built-in default:
encre when dark, velin when light.

All three variants share one role table: bold keywords with a faint violet,
blue types, cyan functions, green strings, orange numbers and constants,
magenta macros and attributes, punctuation a step dimmer than text.

## Install

With the built-in package manager (Neovim 0.12+):

```lua
vim.pack.add({ "https://github.com/HCHogan/defaulx" })
vim.cmd.colorscheme("defaulx")
```

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{ "HCHogan/defaulx", lazy = false, priority = 1000, opts = {} }
```

With Nix, add the flake and use the package or the overlay:

```nix
inputs.defaulx.url = "github:HCHogan/defaulx";
# then
pkgs.vimPlugins.defaulx # with inputs.defaulx.overlays.default
inputs.defaulx.packages.${system}.default
```

No build step is needed anywhere: the highlights for the default options are
committed under `lua/defaulx/compiled/`.

## Configuration

`setup()` is optional. Call it before `:colorscheme`.

```lua
require("defaulx").setup({
  dark = "encre", -- variant for 'background' = dark
  light = "velin", -- variant for 'background' = light
  transparent = false,
  styles = {
    comments = {},
    keywords = { bold = true },
    functions = {},
    variables = {},
    types = {},
  },
  -- `all` covers every integration not named here.
  plugins = { all = true },
  on_palette = function(palette, variant) end,
  on_highlights = function(hl, c, variant) end,
  cache = true,
})
```

`on_palette` changes colors before any highlight is built; `on_highlights`
edits the finished table, where `c` holds the palette plus the role table
(`c.syn.keyword`, `c.diag.warn`, `c.git.add`, …). `require("defaulx").palette()`
returns the active palette for statuslines and other plugins.

## Loading and caching

1. Default options (with or without `on_highlights`) load the precompiled
   table from `lua/defaulx/compiled/` with no computation.
2. Customized options build once and cache the result as Lua bytecode under
   `stdpath("cache")/defaulx/`. The cache key covers the options, the resolved
   palette and a hash of the plugin's sources, so updates and edits invalidate
   it. `require("defaulx.compile").clear_cache()` removes it by hand.
3. The Nix build regenerates the precompiled files and fails if they differ
   from the committed ones, then runs the test suite.

## Plugins

[blink.cmp](https://github.com/saghen/blink.cmp),
[flash.nvim](https://github.com/folke/flash.nvim),
[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim),
[mini.nvim](https://github.com/nvim-mini/mini.nvim) (every module with
highlight groups), [noice.nvim](https://github.com/folke/noice.nvim),
[snacks.nvim](https://github.com/folke/snacks.nvim) and
[which-key.nvim](https://github.com/folke/which-key.nvim).

Built-in coverage: every group in `:h highlight-groups` for Neovim 0.12, the
standard tree-sitter captures, LSP semantic tokens (including rust-analyzer's
lifetimes, format specifiers and `self`), diagnostics with tinted virtual
text, diff mode, and the 16 terminal colors.

## Development

```sh
nvim --clean --headless -l scripts/build.lua          # regenerate palettes and compiled/
nvim --clean --headless -l scripts/build.lua --check  # fail if anything is stale
nvim --clean --headless -l tests/run.lua              # contrast floors, links, cache
nix flake check                                       # all of the above in a sandbox
```

Colors live in `lua/defaulx/palette/spec.lua`, in Oklch or as the verbatim
`Nvim*` defaults; never edit the generated `palette/<variant>.lua` files.
Roles are in `lua/defaulx/theme.lua`, highlight groups in
`lua/defaulx/groups/`. A new integration is one file in
`lua/defaulx/groups/plugins/` plus an entry in `lua/defaulx/groups/init.lua`.

## License

MIT
