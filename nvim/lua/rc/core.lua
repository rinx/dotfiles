-- [nfnl] fnl/rc/core.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local icon = autoload("rc.icon")
vim.o.viminfo = "'1000,<100,f1,h,s100"
vim.o.history = 300
vim.o.bs = "indent,eol,start"
vim.o.ruler = true
vim.o.number = true
vim.o.cmdheight = 2
vim.o.wildmenu = true
vim.o.wildchar = 9
vim.o.wildmode = "longest:full,full"
vim.o.shortmess = "filnxtToOFc"
vim.opt.completeopt = {"menu", "menuone", "noselect"}
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.breakindent = true
vim.o.confirm = true
vim.o.clipboard = "unnamed,unnamedplus"
vim.o.mouse = "a"
vim.o.foldmethod = "marker"
vim.o.foldlevel = 99
vim.o.virtualedit = "block"
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.tabstop = 8
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
if (vim.fn.exists("&pumblend") == 1) then
  vim.o.pumblend = 30
else
end
if (vim.fn.exists("&winblend") == 1) then
  vim.o.winblend = 30
else
end
vim.o.visualbell = true
vim.o.lazyredraw = true
vim.o.ttyfast = true
vim.o.showmatch = true
vim.o.matchtime = 3
vim.o.backup = false
vim.o.writebackup = false
vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.wo.signcolumn = "number"
vim.o.undofile = true
vim.o.undolevels = 1000
vim.o.undoreload = 10000
do
  local backupdir = vim.fn.expand("~/.config/nvim/tmp/backup")
  local undodir = vim.fn.expand("~/.config/nvim/tmp/undo")
  local swapdir = vim.fn.expand("~/.config/nvim/tmp/swap")
  vim.o.backupdir = backupdir
  vim.o.undodir = undodir
  vim.o.directory = swapdir
  if not (vim.fn.isdirectory(backupdir) == 1) then
    vim.fn.mkdir(backupdir, "p")
  else
  end
  if not (vim.fn.isdirectory(undodir) == 1) then
    vim.fn.mkdir(undodir, "p")
  else
  end
  if not (vim.fn.isdirectory(swapdir) == 1) then
    vim.fn.mkdir(swapdir, "p")
  else
  end
end
vim.o.list = true
vim.opt.listchars = {eol = icon.tab["subdirectory-arrow-left"], extends = icon.tab.extends, nbsp = icon.tab.nbsp, precedes = icon.tab.precedes, tab = icon.tab["keyboard-tab"], trail = icon.tab.trail}
vim.o.autochdir = false
vim.o.autoread = true
vim.o.autowrite = false
vim.o.exrc = false
vim.o.secure = false
vim.o.timeout = true
vim.o.timeoutlen = 1000
vim.o.ttimeoutlen = 200
vim.o.hidden = true
vim.o.laststatus = 3
vim.o.showtabline = 2
vim.o.termguicolors = true
vim.cmd("syntax on")
vim.cmd("filetype off")
vim.cmd("filetype plugin indent on")
vim.cmd("language en_US.utf-8")
vim.o.modeline = true
if (vim.fn.executable("rg") == 1) then
  vim.o.grepprg = "rg --vimgrep --no-heading"
  vim.o.grepformat = "%f:%l:%c:%m,%f:%l:%m"
  vim.g.ackprg = "rg --vimgrep --no-heading"
else
end
do
  local fonts = {"MonaspaceRn NFM", "FiraCode Nerd Font", "Moralerspace Radon NF", "Noto Color Emoji"}
  local size
  if (vim.fn.has("mac") == 1) then
    size = "h14"
  else
    size = "h12"
  end
  local guifonts
  local function _9_(font)
    return (font .. ":" .. size)
  end
  guifonts = table.concat(core.map(_9_, fonts), ",")
  vim.o.guifont = guifonts
end
if vim.g.neovide then
  vim.g.neovide_floating_blur = 0
  vim.g.neovide_transparency = 0.8
  vim.g.neovide_cursor_animation_length = 0.1
  vim.g.neovide_cursor_trail_size = 0.01
  vim.g.neovide_cursor_vfx_mode = "ripple"
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_underline_automatic_scaling = true
else
end
vim.g["denops#server#deno_args"] = {"-q", "--no-lock", "-A", "--unstable-kv"}
return nil
