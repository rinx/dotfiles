-- [nfnl] Compiled from fnl/rc/plugin/nfnl.fnl by https://github.com/Olical/nfnl, do not edit.
local function compile_all_files()
  local nfnl = require("nfnl.api")
  return nfnl["compile-all-files"]()
end
return vim.api.nvim_create_user_command("NfnlCompileAllFiles", compile_all_files, {})
