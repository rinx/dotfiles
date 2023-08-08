-- [nfnl] Compiled from fnl/rc/plugin/sidebar.fnl by https://github.com/Olical/nfnl, do not edit.
local sidebar = require("sidebar-nvim")
sidebar.setup({side = "right", sections = {"git", "todos", "buffers", "symbols"}, disable_closing_prompt = true, open = false})
return vim.keymap.set("n", "<leader>o", ":<C-u>SidebarNvimToggle<CR>", {silent = true})
