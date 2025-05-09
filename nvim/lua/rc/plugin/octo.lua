-- [nfnl] fnl/rc/plugin/octo.fnl
local octo = require("octo")
if (vim.fn.executable("gh") == 1) then
  return octo.setup({})
else
  return nil
end
