-- [nfnl] Compiled from fnl/rc/plugin.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
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
    local tbl_21_auto = {}
    local i_22_auto = 0
    for name, opts in pairs(pkgs) do
      local val_23_auto = core.assoc(opts, 1, name)
      if (nil ~= val_23_auto) then
        i_22_auto = (i_22_auto + 1)
        tbl_21_auto[i_22_auto] = val_23_auto
      else
      end
    end
    plugins = tbl_21_auto
  end
  return lazy.setup(plugins, {ui = {icons = ui_icons}, performance = {rtp = {disabled_plugins = rtp_disabled_plugins}}, rocks = {enabled = false}})
end
return use({["folke/lazy.nvim"] = {lazy = true}, ["folke/snacks.nvim"] = {priority = 1000, config = mod("snacks"), lazy = false}, ["folke/which-key.nvim"] = {event = {"VeryLazy"}, opts = {}, config = mod("which-key")}, ["nvim-lua/plenary.nvim"] = {lazy = true}, ["nvim-lua/popup.nvim"] = {lazy = true}, ["MunifTanjim/nui.nvim"] = {lazy = true}, ["echasnovski/mini.nvim"] = {config = mod("mini"), event = {"VeryLazy"}}, ["stevearc/dressing.nvim"] = {config = mod("dressing")}, ["EdenEast/nightfox.nvim"] = {build = cmd__3efn("NightfoxCompile"), lazy = true, priority = 1000}, ["kyazdani42/nvim-web-devicons"] = {config = mod("devicons")}, ["rebelot/heirline.nvim"] = {config = mod("heirline"), event = {"BufEnter"}}, ["akinsho/bufferline.nvim"] = {config = mod("bufferline"), event = {"BufEnter"}}, ["kyazdani42/nvim-tree.lua"] = {event = {"VeryLazy"}, config = mod("nvim-tree")}, ["lewis6991/gitsigns.nvim"] = {event = {"VeryLazy"}, config = mod("gitsigns")}, ["norcalli/nvim-colorizer.lua"] = {config = mod("colorizer"), event = {"BufEnter"}}, ["lukas-reineke/indent-blankline.nvim"] = {event = {"BufReadPost", "BufAdd", "BufNewFile"}, config = mod("indent-blankline")}, ["ggandor/leap.nvim"] = {event = {"VeryLazy"}, config = mod("leap")}, ["numToStr/Comment.nvim"] = {event = {"BufReadPost", "BufAdd", "BufNewFile"}, config = mod("comment")}, ["kana/vim-submode"] = {event = {"BufReadPost", "BufAdd", "BufNewFile"}, config = mod("submode")}, ["ahmedkhalf/project.nvim"] = {config = mod("project"), event = {"BufRead", "BufNewFile"}}, ["pwntester/octo.nvim"] = {cmd = {"Octo"}, config = mod("octo")}, ["ghillb/cybu.nvim"] = {config = mod("cybu"), event = {"BufReadPost", "BufAdd", "BufNewFile"}}, ["tomiis4/Hypersonic.nvim"] = {cmd = {"Hypersonic"}, config = mod("hypersonic")}, ["notomo/waitevent.nvim"] = {config = mod("waitevent")}, ["neovim/nvim-lspconfig"] = {config = mod("lsp"), dependencies = {"ray-x/lsp_signature.nvim", "b0o/schemastore.nvim"}, event = {"BufReadPre"}}, ["kosayoda/nvim-lightbulb"] = {config = mod("lightbulb"), event = {"BufReadPost", "BufAdd", "BufNewFile"}}, ["folke/trouble.nvim"] = {config = mod("trouble"), event = {"BufReadPost", "BufAdd", "BufNewFile"}}, ["folke/lsp-colors.nvim"] = {config = mod("lsp-colors"), event = {"BufReadPost", "BufAdd", "BufNewFile"}}, ["folke/todo-comments.nvim"] = {config = mod("todo-comments"), event = {"BufReadPost", "BufAdd", "BufNewFile"}}, ["whynothugo/lsp_lines.nvim"] = {url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim", config = mod("lsp-lines"), event = {"BufReadPost", "BufAdd", "BufNewFile"}}, ["saghen/blink.cmp"] = {event = {"InsertEnter", "CmdlineEnter"}, version = "v0.*", dependencies = {"rafamadriz/friendly-snippets", "echasnovski/mini.snippets", "mikavilpas/blink-ripgrep.nvim", "moyiz/blink-emoji.nvim", "Kaiser-Yang/blink-cmp-git"}, config = mod("cmp")}, ["mfussenegger/nvim-dap"] = {config = mod("dap"), event = {"BufReadPost", "BufAdd", "BufNewFile"}, dependencies = {"nvim-neotest/nvim-nio", "rcarriga/nvim-dap-ui"}}, ["leoluz/nvim-dap-go"] = {ft = {"go"}, config = mod("dap-go")}, ["rinx/nvim-dap-rego"] = {ft = {"rego"}, config = mod("dap-rego")}, ["nvim-telescope/telescope.nvim"] = {config = mod("telescope"), event = {"VeryLazy"}, dependencies = {"nvim-telescope/telescope-dap.nvim", "cljoly/telescope-repo.nvim", "nvim-orgmode/telescope-orgmode.nvim"}}, ["havi/telescope-toggleterm.nvim"] = {url = "https://git.sr.ht/~havi/telescope-toggleterm.nvim", event = {"VeryLazy"}}, ["vim-denops/denops.vim"] = {event = {"VimEnter"}}, ["vim-skk/skkeleton"] = {config = mod("skkeleton"), event = {"BufEnter"}}, ["lambdalisue/vim-kensaku"] = {event = {"VimEnter"}}, ["gpanders/nvim-parinfer"] = {ft = {"clojure", "fennel"}}, ["julienvincent/nvim-paredit"] = {ft = {"clojure", "fennel"}}, ["dundalek/parpar.nvim"] = {ft = {"clojure", "fennel"}, dependencies = {"gpanders/nvim-parinfer", "julienvincent/nvim-paredit"}, config = mod("parpar")}, ["Olical/conjure"] = {ft = {"clojure", "fennel"}}, ["Olical/nfnl"] = {ft = {"fennel"}, config = mod("nfnl")}, ["nvim-treesitter/nvim-treesitter"] = {build = cmd__3efn("TSUpdate"), config = mod("treesitter"), event = {"BufEnter"}, dependencies = {"JoosepAlviste/nvim-ts-context-commentstring"}}, ["nvim-orgmode/orgmode"] = {config = mod("orgmode"), event = {"VeryLazy"}, ft = {"org"}, dependencies = {"nvim-orgmode/org-bullets.nvim", "danilshvalov/org-modern.nvim", "chipsenkbeil/org-roam.nvim"}}})
