-- [nfnl] fnl/rc/plugin/nfnl.fnl
local function compile_all_files()
  local nfnl = require("nfnl.api")
  return nfnl["compile-all-files"]()
end
return vim.api.nvim_create_user_command("NfnlCompileAllFiles", compile_all_files, {})
