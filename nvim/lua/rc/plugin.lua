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
  return lazy.setup(plugins, {ui = {icons = ui_icons}, performance = {rtp = {disabled_plugins = rtp_disabled_plugins}}})
end
return use({["folke/lazy.nvim"] = {lazy = true}, ["nvim-lua/plenary.nvim"] = {lazy = true}, ["nvim-lua/popup.nvim"] = {lazy = true}, ["MunifTanjim/nui.nvim"] = {lazy = true}, ["stevearc/dressing.nvim"] = {config = mod("dressing")}, ["EdenEast/nightfox.nvim"] = {build = cmd__3efn("NightfoxCompile"), lazy = true, priority = 1000}, ["kyazdani42/nvim-web-devicons"] = {config = mod("devicons")}, ["rebelot/heirline.nvim"] = {config = mod("heirline"), event = {"BufEnter"}}, ["akinsho/bufferline.nvim"] = {config = mod("bufferline"), event = {"BufEnter"}}, ["akinsho/toggleterm.nvim"] = {config = mod("toggleterm"), event = {"BufReadPost", "BufAdd", "BufNewFile"}}, ["windwp/nvim-autopairs"] = {config = mod("autopairs"), event = {"InsertEnter"}}, ["kyazdani42/nvim-tree.lua"] = {event = {"VeryLazy"}, config = mod("nvim-tree")}, ["lewis6991/gitsigns.nvim"] = {event = {"VeryLazy"}, config = mod("gitsigns")}, ["APZelos/blamer.nvim"] = {event = {"VeryLazy"}}, ["norcalli/nvim-colorizer.lua"] = {config = mod("colorizer"), event = {"BufEnter"}}, ["lukas-reineke/indent-blankline.nvim"] = {event = {"BufReadPost", "BufAdd", "BufNewFile"}, config = mod("indent-blankline")}, ["ggandor/lightspeed.nvim"] = {event = {"BufReadPost", "BufAdd", "BufNewFile"}, config = mod("lightspeed")}, ["numToStr/Comment.nvim"] = {event = {"BufReadPost", "BufAdd", "BufNewFile"}, config = mod("comment")}, ["kyoh86/vim-ripgrep"] = {config = mod("grep"), event = {"VimEnter"}}, ["kana/vim-submode"] = {event = {"BufReadPost", "BufAdd", "BufNewFile"}, config = mod("submode")}, ["ahmedkhalf/project.nvim"] = {config = mod("project"), event = {"BufRead", "BufNewFile"}}, ["pwntester/octo.nvim"] = {cmd = {"Octo"}, config = mod("octo")}, ["ghillb/cybu.nvim"] = {config = mod("cybu"), event = {"BufReadPost", "BufAdd", "BufNewFile"}}, ["tomiis4/Hypersonic.nvim"] = {cmd = {"Hypersonic"}, config = mod("hypersonic")}, ["neovim/nvim-lspconfig"] = {config = mod("lsp"), dependencies = {"ray-x/lsp_signature.nvim", "SmiteshP/nvim-navic", "b0o/schemastore.nvim"}, event = {"BufReadPre"}}, ["j-hui/fidget.nvim"] = {config = mod("fidget"), event = {"BufReadPost", "BufAdd", "BufNewFile"}}, ["aznhe21/actions-preview.nvim"] = {config = mod("actions-preview"), event = {"BufReadPost", "BufAdd", "BufNewFile"}}, ["kosayoda/nvim-lightbulb"] = {config = mod("lightbulb"), event = {"BufReadPost", "BufAdd", "BufNewFile"}}, ["folke/trouble.nvim"] = {config = mod("trouble"), event = {"BufReadPost", "BufAdd", "BufNewFile"}}, ["folke/lsp-colors.nvim"] = {config = mod("lsp-colors"), event = {"BufReadPost", "BufAdd", "BufNewFile"}}, ["folke/todo-comments.nvim"] = {config = mod("todo-comments"), event = {"BufReadPost", "BufAdd", "BufNewFile"}}, ["whynothugo/lsp_lines.nvim"] = {url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim", config = mod("lsp-lines"), event = {"BufReadPost", "BufAdd", "BufNewFile"}}, ["hrsh7th/nvim-cmp"] = {config = mod("cmp"), event = {"InsertEnter"}, dependencies = {"hrsh7th/cmp-buffer", "hrsh7th/cmp-calc", "hrsh7th/cmp-cmdline", "hrsh7th/cmp-emoji", "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-path", "f3fora/cmp-spell", "petertriho/cmp-git", "rafamadriz/friendly-snippets", "ray-x/cmp-treesitter", "PaterJason/cmp-conjure", "rinx/cmp-skkeleton"}}, ["mfussenegger/nvim-dap"] = {config = mod("dap"), event = {"BufReadPost", "BufAdd", "BufNewFile"}, dependencies = {"nvim-neotest/nvim-nio", "rcarriga/nvim-dap-ui"}}, ["nvim-telescope/telescope.nvim"] = {config = mod("telescope"), event = {"BufEnter"}, dependencies = {"nvim-telescope/telescope-dap.nvim", "cljoly/telescope-repo.nvim"}}, ["havi/telescope-toggleterm.nvim"] = {url = "https://git.sr.ht/~havi/telescope-toggleterm.nvim", event = {"BufEnter"}}, ["vim-denops/denops.vim"] = {event = {"VimEnter"}}, ["vim-skk/skkeleton"] = {config = mod("skkeleton"), event = {"BufEnter"}}, ["gamoutatsumi/dps-ghosttext.vim"] = {config = mod("ghosttext"), event = {"BufEnter"}}, ["lambdalisue/guise.vim"] = {config = mod("guise"), event = {"VimEnter"}}, ["tani/glance-vim"] = {event = {"BufReadPost", "BufAdd", "BufNewFile"}}, ["kana/vim-operator-user"] = {config = mod("operator"), event = {"CursorHold", "CursorHoldI"}, dependencies = {"kana/vim-operator-replace", "rhysd/vim-operator-surround"}}, ["kana/vim-textobj-user"] = {config = mod("textobj"), event = {"CursorHold", "CursorHoldI"}, dependencies = {"kana/vim-textobj-indent", "kana/vim-textobj-function", "kana/vim-textobj-entire", "kana/vim-textobj-line", "thinca/vim-textobj-between", "mattn/vim-textobj-url", "osyo-manga/vim-textobj-multiblock"}}, ["gpanders/nvim-parinfer"] = {ft = {"clojure", "fennel"}}, ["julienvincent/nvim-paredit"] = {ft = {"clojure", "fennel"}}, ["julienvincent/nvim-paredit-fennel"] = {dependencies = {"julienvincent/nvim-paredit"}, ft = {"fennel"}}, ["dundalek/parpar.nvim"] = {ft = {"clojure", "fennel"}, dependencies = {"gpanders/nvim-parinfer", "julienvincent/nvim-paredit", "julienvincent/nvim-paredit-fennel"}, config = mod("parpar")}, ["Olical/conjure"] = {ft = {"clojure", "fennel"}}, ["Olical/nfnl"] = {ft = {"fennel"}, config = mod("nfnl")}, ["nvim-treesitter/nvim-treesitter"] = {build = cmd__3efn("TSUpdate"), config = mod("treesitter"), event = {"BufEnter"}, dependencies = {"JoosepAlviste/nvim-ts-context-commentstring"}}, ["danymat/neogen"] = {config = mod("neogen"), event = {"BufReadPost", "BufAdd", "BufNewFile"}}})
