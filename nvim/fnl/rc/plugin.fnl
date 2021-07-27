(module rc.plugin
  {autoload {core aniseed.core
             packer packer}})

(defn- load-plugin-configs? []
  (core.nil? vim.env.NVIM_SKIP_PLUGIN_CONFIGS))

(defn- safe-require-plugin-config [name]
  (let [(ok? val-or-err) (pcall require
                                (.. :rc.plugin. name))]
    (when (not ok?)
      (print (.. "rc error: " val-or-err)))))

(defn- use [...]
  (let [pkgs [...]]
    (packer.startup
      (fn [use]
        (for [i 1 (core.count pkgs) 2]
          (let [name (. pkgs i)
                opts (. pkgs (+ i 1))]
            (when (load-plugin-configs?)
              (-?> (. opts :mod) (safe-require-plugin-config)))
            (use (core.assoc opts 1 name))))))))

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
  :hrsh7th/vim-vsnip {}
  :hrsh7th/vim-vsnip-integ {}
  :hrsh7th/nvim-compe {}
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
  :cohama/lexima.vim {}
  :rafamadriz/friendly-snippets {}
  :kyazdani42/nvim-tree.lua {:cmd [:NvimTreeOpen
                                   :NvimTreeToggle]
                             :mod :nvim-tree}
  :nvim-telescope/telescope.nvim {:mod :telescope}
  :nvim-telescope/telescope-dap.nvim {}
  :nvim-telescope/telescope-fzy-native.nvim {}
  :lewis6991/gitsigns.nvim {:mod :gitsigns}
  :norcalli/nvim-colorizer.lua {:mod :colorizer}
  :lukas-reineke/indent-blankline.nvim {:event [:BufRead]
                                        :mod :indent-blankline}
  :ggandor/lightspeed.nvim {:mod :lightspeed}
  :kana/vim-submode {}
  :kana/vim-arpeggio {}
  :tyru/caw.vim {}
  :kana/vim-operator-user {}
  :kana/vim-operator-replace {}
  :rhysd/vim-operator-surround {}
  :kana/vim-textobj-user {}
  :kana/vim-textobj-indent {}
  :kana/vim-textobj-function {}
  :kana/vim-textobj-entire {}
  :kana/vim-textobj-line {}
  :thinca/vim-textobj-between {}
  :mattn/vim-textobj-url {}
  :osyo-manga/vim-textobj-multiblock {}
  :tpope/vim-repeat {}
  :pwntester/octo.nvim {:mod :octo}
  :rinx/nvim-minimap {:cmd [:MinimapOpen
                            :MinimapToggle] 
                      :mod :minimap}
  :jbyuki/venn.nvim {}
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
