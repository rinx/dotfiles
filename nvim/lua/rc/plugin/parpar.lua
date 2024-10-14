-- [nfnl] Compiled from fnl/rc/plugin/parpar.fnl by https://github.com/Olical/nfnl, do not edit.
local paredit = require("nvim-paredit")
local parpar = require("parpar")
return paredit.setup({filetypes = {"clojure", "fennel"}, keys = {[">)"] = {parpar.wrap(paredit.api.slurp_forwards), "Slurp forwards"}, ["<("] = {parpar.wrap(paredit.api.slurp_backwards), "Slurp backwards"}, ["<)"] = {parpar.wrap(paredit.api.barf_forwards), "Barf forwards"}, [">("] = {parpar.wrap(paredit.api.barf_backwards), "Barf backwards"}}, use_default_keys = false})
