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
    local tbl_17_auto = {}
    local i_18_auto = #tbl_17_auto
    for name, opts in pairs(pkgs) do
      local val_19_auto = core.assoc(opts, 1, name)
      if (nil ~= val_19_auto) then
        i_18_auto = (i_18_auto + 1)
        do end (tbl_17_auto)[i_18_auto] = val_19_auto
      else
      end
    end
    plugins = tbl_17_auto
  end
  return lazy.setup(plugins, {ui = {icons = ui_icons}, performance = {rtp = {disabled_plugins = rtp_disabled_plugins}}})
end
return use({["folke/lazy.nvim"] = {lazy = true}, ["nvim-lua/plenary.nvim"] = {lazy = true}, ["nvim-lua/popup.nvim"] = {lazy = true}, ["MunifTanjim/nui.nvim"] = {lazy = true}, ["EdenEast/nightfox.nvim"] = {build = cmd__3efn("NightfoxCompile"), lazy = true, priority = 1000}, ["kyazdani42/nvim-web-devicons"] = {config = mod("devicons")}, ["feline-nvim/feline.nvim"] = {config = mod("feline"), event = {"BufEnter"}}, ["akinsho/bufferline.nvim"] = {config = mod("bufferline"), event = {"BufEnter"}}, ["akinsho/toggleterm.nvim"] = {config = mod("toggleterm"), event = {"BufReadPost"}}, ["windwp/nvim-autopairs"] = {config = mod("autopairs"), event = {"InsertEnter"}}, ["kyazdani42/nvim-tree.lua"] = {event = {"VeryLazy"}, config = mod("nvim-tree")}, ["sidebar-nvim/sidebar.nvim"] = {config = mod("sidebar"), event = {"VeryLazy"}}, ["lewis6991/gitsigns.nvim"] = {event = {"VeryLazy"}, config = mod("gitsigns")}, ["APZelos/blamer.nvim"] = {event = {"VeryLazy"}}, ["rcarriga/nvim-notify"] = {config = mod("notify"), event = {"BufEnter"}}, ["norcalli/nvim-colorizer.lua"] = {config = mod("colorizer"), event = {"BufEnter"}}, ["lukas-reineke/indent-blankline.nvim"] = {event = {"VeryLazy"}, config = mod("indent-blankline")}, ["ggandor/lightspeed.nvim"] = {event = {"BufReadPost"}, config = mod("lightspeed")}, ["numToStr/Comment.nvim"] = {event = {"BufReadPost"}, config = mod("comment")}, ["kyoh86/vim-ripgrep"] = {config = mod("grep"), event = {"VimEnter"}}, ["kana/vim-submode"] = {event = {"BufEnter"}, config = mod("submode")}, ["ahmedkhalf/project.nvim"] = {config = mod("project"), event = {"BufEnter"}}, ["pwntester/octo.nvim"] = {cmd = {"Octo"}, config = mod("octo")}, ["ghillb/cybu.nvim"] = {config = mod("cybu"), event = {"BufEnter"}}, ["tomiis4/Hypersonic.nvim"] = {cmd = {"Hypersonic"}, config = mod("hypersonic")}, ["neovim/nvim-lspconfig"] = {config = mod("lsp"), dependencies = {"ray-x/lsp_signature.nvim", "kosayoda/nvim-lightbulb", "b0o/schemastore.nvim", "simrat39/rust-tools.nvim"}, event = {"BufReadPre"}}, ["stevearc/dressing.nvim"] = {config = mod("dressing"), event = {"BufReadPost"}}, ["j-hui/fidget.nvim"] = {tag = "legacy", config = mod("fidget"), event = {"BufReadPost"}}, ["aznhe21/actions-preview.nvim"] = {config = mod("actions-preview"), event = {"BufReadPost"}}, ["folke/trouble.nvim"] = {config = mod("trouble"), event = {"BufReadPost"}}, ["folke/lsp-colors.nvim"] = {config = mod("lsp-colors"), event = {"BufReadPost"}}, ["folke/todo-comments.nvim"] = {config = mod("todo-comments"), event = {"BufReadPost"}}, ["whynothugo/lsp_lines.nvim"] = {url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim", config = mod("lsp-lines"), event = {"BufReadPost"}}, ["hrsh7th/nvim-cmp"] = {config = mod("cmp"), event = {"InsertEnter"}, dependencies = {"hrsh7th/cmp-buffer", "hrsh7th/cmp-calc", "hrsh7th/cmp-cmdline", "hrsh7th/cmp-emoji", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path", "hrsh7th/cmp-vsnip", "hrsh7th/vim-vsnip", "f3fora/cmp-spell", "petertriho/cmp-git", "rafamadriz/friendly-snippets", "ray-x/cmp-treesitter", "PaterJason/cmp-conjure", "rinx/cmp-skkeleton"}}, ["mfussenegger/nvim-dap"] = {config = mod("dap"), event = {"BufReadPost"}, dependencies = {"rcarriga/nvim-dap-ui"}}, ["nvim-telescope/telescope.nvim"] = {config = mod("telescope"), event = {"BufEnter"}, dependencies = {"nvim-telescope/telescope-dap.nvim", "cljoly/telescope-repo.nvim"}}, ["havi/telescope-toggleterm.nvim"] = {url = "https://git.sr.ht/~havi/telescope-toggleterm.nvim", event = {"BufEnter"}}, ["vim-denops/denops.vim"] = {}, ["vim-skk/skkeleton"] = {config = mod("skkeleton"), event = {"BufEnter"}}, ["gamoutatsumi/dps-ghosttext.vim"] = {event = {"BufEnter"}}, ["lambdalisue/guise.vim"] = {config = mod("guise")}, ["skanehira/denops-silicon.vim"] = {cmd = {"Silicon"}}, ["kana/vim-operator-user"] = {event = {"VeryLazy"}, dependencies = {"kana/vim-operator-replace", "rhysd/vim-operator-surround"}}, ["kana/vim-textobj-user"] = {event = {"VeryLazy"}, dependencies = {"kana/vim-textobj-indent", "kana/vim-textobj-function", "kana/vim-textobj-entire", "kana/vim-textobj-line", "thinca/vim-textobj-between", "mattn/vim-textobj-url", "osyo-manga/vim-textobj-multiblock"}}, ["guns/vim-sexp"] = {ft = {"clojure", "fennel"}, config = mod("sexp")}, ["gpanders/nvim-parinfer"] = {}, ["Olical/conjure"] = {}, ["Olical/nfnl"] = {}, ["nvim-treesitter/nvim-treesitter"] = {build = cmd__3efn("TSUpdate"), config = mod("treesitter"), event = {"BufEnter"}, dependencies = {"romgrk/nvim-treesitter-context", "JoosepAlviste/nvim-ts-context-commentstring"}}, ["danymat/neogen"] = {config = mod("neogen"), event = {"BufReadPost"}}})
