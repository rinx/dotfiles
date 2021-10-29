(module rc.plugin
  {autoload {core aniseed.core
             nvim aniseed.nvim
             packer packer}})

(defn- load-plugin-configs? []
  (core.nil? vim.env.NVIM_SKIP_PLUGIN_CONFIGS))

(defn- config-require-str [name]
  (.. "require('rc.plugin." name "')"))

(defn- use [...]
  (let [pkgs [...]]
    (packer.startup
      (fn [use]
        (for [i 1 (core.count pkgs) 2]
          (let [name (. pkgs i)
                opts (. pkgs (+ i 1))]
            (if (and (load-plugin-configs?) (. opts :mod))
              (use (core.assoc
                     opts
                     1 name
                     :config (config-require-str (. opts :mod))))
              (use (core.assoc opts 1 name)))))))))

(use
  :wbthomason/packer.nvim {}
  :Olical/aniseed {}
  :nvim-lua/plenary.nvim {}
  :nvim-lua/popup.nvim {}
  :nathom/filetype.nvim {}
  :folke/tokyonight.nvim {}
  :kyazdani42/nvim-web-devicons {:mod :devicons}
  :famiu/feline.nvim {:mod :feline}
  :akinsho/nvim-bufferline.lua {:mod :bufferline}
  :akinsho/nvim-toggleterm.lua {:mod :toggleterm}
  :windwp/nvim-autopairs {:mod :autopairs}
  :kyazdani42/nvim-tree.lua {:event [:BufEnter]
                             :mod :nvim-tree}
  :lewis6991/gitsigns.nvim {:event [:BufEnter]
                            :mod :gitsigns}
  :rcarriga/nvim-notify {:mod :notify}
  :norcalli/nvim-colorizer.lua {:mod :colorizer}
  :lukas-reineke/indent-blankline.nvim {:event [:BufEnter]
                                        :mod :indent-blankline}
  :ggandor/lightspeed.nvim {:event [:BufEnter]
                            :mod :lightspeed}
  :terrortylor/nvim-comment {:event [:BufEnter]
                             :mod :comment}
  :rinx/nvim-ripgrep {:mod :rg}
  :kana/vim-submode {:event [:BufEnter]
                     :mod :submode}
  :pwntester/octo.nvim {:cmd [:Octo]
                        :mod :octo}

  ;; lsp
  :neovim/nvim-lspconfig {:mod :lsp}
  :ray-x/lsp_signature.nvim {}
  :tami5/lspsaga.nvim {}
  :weilbith/nvim-code-action-menu {:cmd [:CodeActionMenu]}
  :kosayoda/nvim-lightbulb {}
  :folke/trouble.nvim {}
  :folke/lsp-colors.nvim {}
  :folke/todo-comments.nvim {}
  :simrat39/symbols-outline.nvim {}

  ;; cmp
  :hrsh7th/nvim-cmp {:mod :cmp}
  :hrsh7th/cmp-buffer {:after :nvim-cmp}
  :hrsh7th/cmp-calc {:after :nvim-cmp}
  :hrsh7th/cmp-cmdline {:after :nvim-cmp}
  :hrsh7th/cmp-emoji {:after :nvim-cmp}
  :hrsh7th/cmp-nvim-lsp {:after :nvim-cmp}
  :hrsh7th/cmp-path {:after :nvim-cmp}
  :hrsh7th/cmp-vsnip {:after :nvim-cmp}
  :hrsh7th/vim-vsnip {:after :nvim-cmp}
  :f3fora/cmp-spell {:after :nvim-cmp}
  :petertriho/cmp-git {:after :nvim-cmp}
  :ray-x/cmp-treesitter {:after [:nvim-cmp :nvim-treesitter]}
  :PaterJason/cmp-conjure {:after [:nvim-cmp :conjure]}
  :rafamadriz/friendly-snippets {:after :nvim-cmp}
  :rinx/cmp-skkeleton {:after [:nvim-cmp :skkeleton]}

  ;; dap
  :mfussenegger/nvim-dap {:mod :dap}
  :rcarriga/nvim-dap-ui {}

  ;; telescope
  :nvim-telescope/telescope.nvim {:mod :telescope}
  :nvim-telescope/telescope-dap.nvim {}
  :nvim-telescope/telescope-fzy-native.nvim {}

  ;; denops.vim
  :vim-denops/denops.vim {}
  :vim-skk/skkeleton {:mod :skkeleton}
  :gamoutatsumi/dps-ghosttext.vim {}
  :rinx/dps-dpresence {}
  :kat0h/bufpreview.vim {:ft [:markdown]}

  ;; operator/textobj
  :kana/vim-operator-user {:event [:BufEnter]}
  :kana/vim-operator-replace {:after :vim-operator-user}
  :rhysd/vim-operator-surround {:after :vim-operator-user}
  :kana/vim-textobj-user {:event [:BufEnter]}
  :kana/vim-textobj-indent {:after :vim-textobj-user}
  :kana/vim-textobj-function {:after :vim-textobj-user}
  :kana/vim-textobj-entire {:after :vim-textobj-user}
  :kana/vim-textobj-line {:after :vim-textobj-user}
  :thinca/vim-textobj-between {:after :vim-textobj-user}
  :mattn/vim-textobj-url {:after :vim-textobj-user}
  :osyo-manga/vim-textobj-multiblock {:after :vim-textobj-user}

  ;; languages
  :gpanders/nvim-parinfer {:ft [:clojure
                                :fennel
                                :hy
                                :lisp
                                :scheme]}
  :guns/vim-sexp {:ft [:clojure
                       :fennel
                       :hy
                       :lisp
                       :scheme]
                  :mod :sexp}
  :simrat39/rust-tools.nvim {} ;; NOTE: currently cannot be lazy loaded
  :hylang/vim-hy {:ft [:hy]}
  :Olical/conjure {:ft [:clojure
                        :fennel
                        :hy]}
  :nvim-neorg/neorg {:mod :neorg
                     :branch :unstable
                     :requires [:nvim-neorg/neorg-telescope]}

  ;; treesitter
  :nvim-treesitter/nvim-treesitter {:run ":TSUpdate"
                                    :mod :treesitter}
  :romgrk/nvim-treesitter-context {}
  :JoosepAlviste/nvim-ts-context-commentstring {}
  :danymat/neogen {:mod :neogen})
