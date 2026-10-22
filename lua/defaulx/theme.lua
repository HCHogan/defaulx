---The role table shared by every variant: palette colors in, meanings out.
---Groups only ever read from these roles or from the palette's UI greys.

---@class defaulx.Theme: defaulx.Palette
---@field syn table<string, string>
---@field diag table<string, string>
---@field tint table<string, string>
---@field git table<string, string>
---@field mode table<string, string>

---@param p defaulx.Palette
---@return defaulx.Theme
return function(p)
  local c = setmetatable({}, { __index = p }) --[[@as defaulx.Theme]]

  c.syn = {
    keyword = p.violet,
    type = p.blue,
    type_builtin = p.azure,
    func = p.cyan,
    macro = p.magenta,
    attribute = p.magenta,
    string = p.green,
    escape = p.escape,
    number = p.orange,
    constant = p.orange,
    variable = p.text,
    parameter = p.parameter,
    member = p.member,
    module = p.module,
    lifetime = p.lifetime,
    operator = p.subtext1,
    bracket = p.subtext1,
    delimiter = p.subtext0,
    comment = p.comment,
    doc = p.doc,
    tag = p.blue,
    special = p.cyan,
  }

  c.diag = {
    error = p.red,
    warn = p.yellow,
    info = p.cyan,
    hint = p.blue,
    ok = p.green,
  }

  c.tint = {
    error = p.tint_red,
    warn = p.tint_yellow,
    info = p.tint_cyan,
    hint = p.tint_blue,
    ok = p.tint_green,
  }

  c.git = {
    add = p.green,
    change = p.cyan,
    delete = p.red,
    ignored = p.overlay1,
    untracked = p.subtext0,
  }

  c.mode = {
    normal = p.cyan,
    insert = p.green,
    visual = p.violet,
    replace = p.red,
    command = p.yellow,
    other = p.blue,
  }

  return c
end
