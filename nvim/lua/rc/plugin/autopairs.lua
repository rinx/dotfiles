-- [nfnl] Compiled from  by https://github.com/Olical/nfnl, do not edit.
local autopairs = require("nvim-autopairs")
autopairs.setup({})
autopairs.remove_rule()
local function autopairs_adjust_rules_clojure()
  return autopairs.remove_rule("'")
end
local group_5_auto = vim.api.nvim_create_augroup("init-autopairs-clojure", {clear = true})
return vim.api.nvim_create_autocmd({"FileType"}, {callback = autopairs_adjust_rules_clojure, group = group_5_auto, pattern = "clojure"})
