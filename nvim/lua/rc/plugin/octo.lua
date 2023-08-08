-- [nfnl] Compiled from fnl/rc/plugin/octo.fnl by https://github.com/Olical/nfnl, do not edit.
local octo = require("octo")
if (vim.fn.executable("gh") == 1) then
  return octo.setup({})
else
  return nil
end
