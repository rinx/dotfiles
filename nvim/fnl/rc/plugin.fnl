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
  :folke/tokyonight.nvim {}
  :kyazdani42/nvim-web-devicons {:mod :devicons}
  :hoob3rt/lualine.nvim {:mod :lualine}
  :akinsho/nvim-bufferline.lua {:mod :bufferline}
  :akinsho/nvim-toggleterm.lua {:mod :toggleterm}
  :tyru/eskk.vim {:event [:InsertEnter]
                  :mod :eskk}
  :neovim/nvim-lspconfig {:mod :lsp}
  :hrsh7th/nvim-compe {:event [:InsertEnter]
                       :mod :compe}
  :hrsh7th/vim-vsnip {:after :nvim-compe}
  :hrsh7th/vim-vsnip-integ {:after :nvim-compe}
  :rafamadriz/friendly-snippets {:after :nvim-compe}
  :windwp/nvim-autopairs {:after :nvim-compe
                          :mod :autopairs}
  :onsails/lspkind-nvim {}
  :nvim-lua/lsp-status.nvim {}
  :ray-x/lsp_signature.nvim {}
  :glepnir/lspsaga.nvim {}
  :kosayoda/nvim-lightbulb {}
  :folke/trouble.nvim {}
  :folke/lsp-colors.nvim {}
  :folke/todo-comments.nvim {}
  :simrat39/symbols-outline.nvim {}
  :mfussenegger/nvim-dap {:mod :dap}
  :rcarriga/nvim-dap-ui {}
  :kyazdani42/nvim-tree.lua {:event [:BufEnter]
                             :mod :nvim-tree}
  :nvim-telescope/telescope.nvim {:mod :telescope}
  :nvim-telescope/telescope-dap.nvim {}
  :nvim-telescope/telescope-fzy-native.nvim {}
  :lewis6991/gitsigns.nvim {:event [:BufEnter]
                            :mod :gitsigns}
  :norcalli/nvim-colorizer.lua {:mod :colorizer}
  :lukas-reineke/indent-blankline.nvim {:event [:BufEnter]
                                        :mod :indent-blankline}
  :ggandor/lightspeed.nvim {:event [:BufEnter]
                            :mod :lightspeed}
  :kana/vim-submode {:event [:BufEnter]}
  :kana/vim-arpeggio {}
  :tyru/caw.vim {:event [:BufEnter]}
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
  :tpope/vim-repeat {}
  :pwntester/octo.nvim {:cmd [:Octo]
                        :mod :octo}
  :rinx/nvim-minimap {:cmd [:MinimapOpen
                            :MinimapToggle]
                      :mod :minimap}
  :guns/vim-sexp {:ft [:clojure
                       :fennel
                       :hy
                       :lisp
                       :scheme]
                  :mod :sexp}
  :mileszs/ack.vim {:cmd [:Ack]}
  :simrat39/rust-tools.nvim {} ;; NOTE: currently cannot be lazy loaded
  :hylang/vim-hy {:ft [:hy]}
  :Olical/conjure {:ft [:clojure
                        :fennel
                        :hy]
                   :event ["BufNewFile,BufRead *.clj"
                           "BufNewFile,BufRead *.fnl"
                           "BufNewFile,BufRead *.hy"]}
  :tami5/compe-conjure {:ft [:clojure
                             :fennel
                             :hy]
                        :event ["InsertEnter *.clj"
                                "InsertEnter *.fnl"
                                "InsertEnter *.hy"]}
  :iamcco/markdown-preview.nvim {:run "cd app && yarn install"
                                 :ft [:markdown]
                                 :cmd [:MarkdownPreview]}
  :nvim-treesitter/nvim-treesitter {:run ":TSUpdate"
                                    :mod :treesitter}
  :romgrk/nvim-treesitter-context {})
