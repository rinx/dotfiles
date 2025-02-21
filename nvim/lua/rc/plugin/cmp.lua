-- [nfnl] Compiled from fnl/rc/plugin/cmp.fnl by https://github.com/Olical/nfnl, do not edit.
local cmp = require("blink.cmp")
local mini_snippets = require("mini.snippets")
cmp.setup({keymap = {preset = "default"}, sources = {default = {"lsp", "path", "snippets", "buffer"}}, snippets = {preset = "mini_snippets"}})
return mini_snippets.setup({snippets = {mini_snippets.gen_loader.from_lang()}, mappings = {expand = "<C-i>"}})
