-- [nfnl] Compiled from fnl/rc/plugin/grep.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local icon = autoload("rc.icon")
local icontab = icon.tab
local function rg(args)
  return vim.fn["ripgrep#search"](args)
end
local function callback(query)
  if query then
    return rg(query)
  else
    return nil
  end
end
local function rg_input()
  return vim.ui.input({prompt = icontab.search, completion = "file"}, callback)
end
vim.api.nvim_create_user_command("Rg", rg_input, {})
return vim.keymap.set("n", "<Leader>g", ":<C-u>Rg<CR>", {silent = true})
