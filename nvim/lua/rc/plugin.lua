-- [nfnl] fnl/rc/plugin.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local lazy = require("lazy")
local icon = autoload("rc.icon")
local ui_icons = icon["lazy-nvim-ui-icons"]
local rtp_disabled_plugins = {"gzip", "netrwPlugin", "tarPlugin", "tohtml", "tutor", "zipPlugin"}
local function config_require_str(name)
  return ("require('rc.plugin." .. name .. "')")
end
local function eval(str)
  return assert(load(str))
end
local function mod(m)
  return eval(config_require_str(m))
end
local function cmd__3efn(cmd)
  local function _2_()
    return vim.cmd((":" .. cmd))
  end
  return _2_
end
local function use(pkgs)
  local plugins
  do
    local tbl_26_ = {}
    local i_27_ = 0
    for name, opts in pairs(pkgs) do
      local val_28_ = core.assoc(opts, 1, name)
      if (nil ~= val_28_) then
        i_27_ = (i_27_ + 1)
        tbl_26_[i_27_] = val_28_
      else
      end
    end
    plugins = tbl_26_
  end
  return lazy.setup(plugins, {ui = {icons = ui_icons}, performance = {rtp = {disabled_plugins = rtp_disabled_plugins}}, rocks = {enabled = false}})
end
return use({["folke/lazy.nvim"] = {lazy = true}, ["folke/snacks.nvim"] = {priority = 1000, config = mod("snacks"), lazy = false}, ["folke/which-key.nvim"] = {event = {"VeryLazy"}, opts = {}, config = mod("which-key")}, ["nvim-lua/plenary.nvim"] = {lazy = true}, ["nvim-lua/popup.nvim"] = {lazy = true}, ["MunifTanjim/nui.nvim"] = {lazy = true}, ["echasnovski/mini.nvim"] = {config = mod("mini"), event = {"VeryLazy"}}, ["stevearc/dressing.nvim"] = {config = mod("dressing")}, ["EdenEast/nightfox.nvim"] = {build = cmd__3efn("NightfoxCompile"), lazy = true, priority = 1000}, ["kyazdani42/nvim-web-devicons"] = {config = mod("devicons")}, ["rebelot/heirline.nvim"] = {config = mod("heirline"), event = {"BufEnter"}}, ["akinsho/bufferline.nvim"] = {config = mod("bufferline"), event = {"BufEnter"}}, ["lewis6991/gitsigns.nvim"] = {event = {"VeryLazy"}, config = mod("gitsigns")}, ["norcalli/nvim-colorizer.lua"] = {config = mod("colorizer"), event = {"BufEnter"}}, ["lukas-reineke/indent-blankline.nvim"] = {event = {"BufReadPost", "BufAdd", "BufNewFile"}, config = mod("indent-blankline")}, ["andyg/leap.nvim"] = {url = "https://codeberg.org/andyg/leap.nvim.git", event = {"VeryLazy"}, config = mod("leap")}, ["numToStr/Comment.nvim"] = {event = {"BufReadPost", "BufAdd", "BufNewFile"}, config = mod("comment")}, ["ghillb/cybu.nvim"] = {config = mod("cybu"), event = {"BufReadPost", "BufAdd", "BufNewFile"}}, ["tomiis4/Hypersonic.nvim"] = {cmd = {"Hypersonic"}, config = mod("hypersonic")}, ["notomo/waitevent.nvim"] = {config = mod("waitevent")}, ["HakonHarnes/img-clip.nvim"] = {config = mod("img-clip"), event = {"VeryLazy"}}, ["zbirenbaum/copilot.lua"] = {config = mod("copilot"), event = {"VeryLazy"}}, ["yetone/avante.nvim"] = {build = "make", config = mod("avante"), cmd = {"AvanteAsk", "AvanteChat", "AvanteToggle", "MCPHub"}, dependencies = {"ravitemer/mcphub.nvim"}}, ["neovim/nvim-lspconfig"] = {}, ["b0o/schemastore.nvim"] = {lazy = true}, ["kosayoda/nvim-lightbulb"] = {config = mod("lightbulb"), event = {"BufReadPost", "BufAdd", "BufNewFile"}}, ["folke/trouble.nvim"] = {config = mod("trouble"), event = {"BufReadPost", "BufAdd", "BufNewFile"}}, ["folke/todo-comments.nvim"] = {config = mod("todo-comments"), event = {"BufReadPost", "BufAdd", "BufNewFile"}}, ["saghen/blink.cmp"] = {event = {"InsertEnter", "CmdlineEnter"}, version = "v1.*", dependencies = {"rafamadriz/friendly-snippets", "echasnovski/mini.snippets", "mikavilpas/blink-ripgrep.nvim", "moyiz/blink-emoji.nvim", "Kaiser-Yang/blink-cmp-git", "Kaiser-Yang/blink-cmp-avante", "giuxtaposition/blink-cmp-copilot"}, config = mod("cmp")}, ["mfussenegger/nvim-dap"] = {config = mod("dap"), event = {"BufReadPost", "BufAdd", "BufNewFile"}, dependencies = {"nvim-neotest/nvim-nio", "igorlfs/nvim-dap-view"}}, ["leoluz/nvim-dap-go"] = {ft = {"go"}, config = mod("dap-go")}, ["rinx/nvim-dap-rego"] = {ft = {"rego"}, config = mod("dap-rego")}, ["vim-denops/denops.vim"] = {event = {"VimEnter"}}, ["vim-skk/skkeleton"] = {config = mod("skkeleton"), event = {"BufEnter"}}, ["lambdalisue/vim-kensaku"] = {event = {"VimEnter"}}, ["gpanders/nvim-parinfer"] = {ft = {"clojure", "fennel", "hy"}}, ["julienvincent/nvim-paredit"] = {ft = {"clojure", "fennel", "hy"}}, ["dundalek/parpar.nvim"] = {ft = {"clojure", "fennel", "hy"}, dependencies = {"gpanders/nvim-parinfer", "julienvincent/nvim-paredit"}, config = mod("parpar")}, ["Olical/conjure"] = {ft = {"clojure", "fennel", "hy"}}, ["Olical/nfnl"] = {ft = {"fennel"}, config = mod("nfnl")}, ["hylang/vim-hy"] = {ft = {"hy"}}, ["nvim-treesitter/nvim-treesitter"] = {branch = "main", config = mod("treesitter"), event = {"BufEnter"}}, ["nvim-orgmode/orgmode"] = {config = mod("orgmode"), event = {"VeryLazy"}, ft = {"org"}, dependencies = {"nvim-orgmode/org-bullets.nvim", "danilshvalov/org-modern.nvim", "chipsenkbeil/org-roam.nvim"}}})
