-- [nfnl] Compiled from fnl/rc/plugin/paredit.fnl by https://github.com/Olical/nfnl, do not edit.
local paredit = require("nvim-paredit")
return paredit.setup({filetypes = {"clojure", "fennel"}, keys = {[">)"] = {paredit.api.slurp_forwards, "Slurp forwards"}, [">("] = {paredit.api.slurp_backwards, "Slurp backwards"}, ["<)"] = {paredit.api.barf_forwards, "Barf forwards"}, ["<("] = {paredit.api.barf_backwards, "Barf backwards"}}, use_default_keys = false})
