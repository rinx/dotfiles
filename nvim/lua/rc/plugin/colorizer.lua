-- [nfnl] fnl/rc/plugin/colorizer.fnl
local colorizer = require("colorizer")
vim.o.termguicolors = true
return colorizer.setup()
