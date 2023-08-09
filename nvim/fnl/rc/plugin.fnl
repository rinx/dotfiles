(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

(local lazy (require :lazy))

(local icon (autoload :rc.icon))
(local ui-icons icon.lazy-nvim-ui-icons)

(local rtp-disabled-plugins
  [:gzip
   :netrwPlugin
   :tarPlugin
   :tohtml
   :tutor
   :zipPlugin])

(fn config-require-str [name]
  (.. "require('rc.plugin." name "')"))

(fn eval [str]
  (assert (load str)))

(fn mod [m]
  (-> m
      config-require-str
      eval))

(fn cmd->fn [cmd]
  (fn []
    (vim.cmd (.. ":" cmd))))

(fn use [pkgs]
  (let [plugins (icollect [name opts (pairs pkgs)]
                  (core.assoc opts 1 name))]
    (lazy.setup
      plugins
      {:ui
       {:icons ui-icons}
       :performance
       {:rtp
        {:disabled_plugins rtp-disabled-plugins}}})))

(use
  {:folke/lazy.nvim {:lazy true}
   :Olical/nfnl {:lazy true
                 :ft [:fennel]}
   :nvim-lua/plenary.nvim {:lazy true}
   :nvim-lua/popup.nvim {:lazy true}
   :MunifTanjim/nui.nvim {:lazy true}
   :EdenEast/nightfox.nvim {:build (cmd->fn :NightfoxCompile)
                            :lazy true
                            :priority 1000}
   :kyazdani42/nvim-web-devicons {:config (mod :devicons)}
   :feline-nvim/feline.nvim {:config (mod :feline)
                             :event [:BufEnter]}
   :akinsho/bufferline.nvim {:config (mod :bufferline)
                             :event [:BufEnter]}
   :akinsho/toggleterm.nvim {:config (mod :toggleterm)
                             :event [:BufReadPost]}
   :windwp/nvim-autopairs {:config (mod :autopairs)
                           :event [:InsertEnter]}
   :kyazdani42/nvim-tree.lua {:event [:VeryLazy]
                              :config (mod :nvim-tree)}
   :sidebar-nvim/sidebar.nvim {:config (mod :sidebar)
                               :event [:VeryLazy]}
   :lewis6991/gitsigns.nvim {:event [:VeryLazy]
                             :config (mod :gitsigns)}
   :APZelos/blamer.nvim {:event [:VeryLazy]}
   :rcarriga/nvim-notify {:config (mod :notify)
                          :event [:BufEnter]}
   :norcalli/nvim-colorizer.lua {:config (mod :colorizer)
                                 :event [:BufEnter]}
   :lukas-reineke/indent-blankline.nvim {:event [:VeryLazy]
                                         :config (mod :indent-blankline)}
   :ggandor/lightspeed.nvim {:event [:BufReadPost]
                             :config (mod :lightspeed)}
   :numToStr/Comment.nvim {:event [:BufReadPost]
                           :config (mod :comment)}
   :kyoh86/vim-ripgrep {:config (mod :grep)
                        :event [:VimEnter]}
   :kana/vim-submode {:event [:BufEnter]
                      :config (mod :submode)}
   :ahmedkhalf/project.nvim {:config (mod :project)
                             :event [:BufEnter]}
   :pwntester/octo.nvim {:cmd [:Octo]
                         :config (mod :octo)}
   :ghillb/cybu.nvim {:config (mod :cybu)
                      :event [:BufEnter]}
   :tomiis4/Hypersonic.nvim {:cmd [:Hypersonic]
                             :config (mod :hypersonic)}

   ;; :stevearc/profile.nvim {:config (mod :profile)}

   ;; lsp
   :neovim/nvim-lspconfig {:config (mod :lsp)
                           :dependencies [:ray-x/lsp_signature.nvim
                                          :kosayoda/nvim-lightbulb
                                          :b0o/schemastore.nvim
                                          :simrat39/rust-tools.nvim]
                           :event [:BufReadPre]}
   :stevearc/dressing.nvim {:config (mod :dressing)
                            :event [:BufReadPost]}
   :j-hui/fidget.nvim {:tag :legacy
                       :config (mod :fidget)
                       :event [:BufReadPost]}
   :aznhe21/actions-preview.nvim {:config (mod :actions-preview)
                                  :event [:BufReadPost]}
   :folke/trouble.nvim {:config (mod :trouble)
                        :event [:BufReadPost]}
   :folke/lsp-colors.nvim {:config (mod :lsp-colors)
                           :event [:BufReadPost]}
   :folke/todo-comments.nvim {:config (mod :todo-comments)
                              :event [:BufReadPost]}
   :whynothugo/lsp_lines.nvim {:url "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
                               :config (mod :lsp-lines)
                               :event [:BufReadPost]}

   ;; cmp
   :hrsh7th/nvim-cmp {:config (mod :cmp)
                      :event [:InsertEnter]
                      :dependencies [:hrsh7th/cmp-buffer
                                     :hrsh7th/cmp-calc
                                     :hrsh7th/cmp-cmdline
                                     :hrsh7th/cmp-emoji
                                     :hrsh7th/cmp-nvim-lsp
                                     :hrsh7th/cmp-path
                                     :hrsh7th/cmp-vsnip
                                     :hrsh7th/vim-vsnip
                                     :f3fora/cmp-spell
                                     :petertriho/cmp-git
                                     :rafamadriz/friendly-snippets
                                     :ray-x/cmp-treesitter
                                     :PaterJason/cmp-conjure
                                     :rinx/cmp-skkeleton]}

   ;; dap
   :mfussenegger/nvim-dap {:config (mod :dap)
                           :event [:BufReadPost]
                           :dependencies [:rcarriga/nvim-dap-ui]}

   ;; telescope
   :nvim-telescope/telescope.nvim {:config (mod :telescope)
                                   :event [:BufEnter]
                                   :dependencies [:nvim-telescope/telescope-dap.nvim
                                                  :cljoly/telescope-repo.nvim]}
   :havi/telescope-toggleterm.nvim {:url "https://git.sr.ht/~havi/telescope-toggleterm.nvim"
                                    :event [:BufEnter]}

   ;; denops.vim
   :vim-denops/denops.vim {}
   :vim-skk/skkeleton {:config (mod :skkeleton)
                       :event [:BufEnter]}
   :gamoutatsumi/dps-ghosttext.vim {:event [:BufEnter]}
   :lambdalisue/guise.vim {:config (mod :guise)}
   :skanehira/denops-silicon.vim {:cmd [:Silicon]}

   ;; operator/textobj
   :kana/vim-operator-user {:event [:VeryLazy]
                            :dependencies [:kana/vim-operator-replace
                                           :rhysd/vim-operator-surround]}
   :kana/vim-textobj-user {:event [:VeryLazy]
                           :dependencies [:kana/vim-textobj-indent
                                          :kana/vim-textobj-function
                                          :kana/vim-textobj-entire
                                          :kana/vim-textobj-line
                                          :thinca/vim-textobj-between
                                          :mattn/vim-textobj-url
                                          :osyo-manga/vim-textobj-multiblock]}

   ;; languages
   :guns/vim-sexp {:ft [:clojure
                        :fennel]
                   :config (mod :sexp)}
   :gpanders/nvim-parinfer {}
   :Olical/conjure {}

   ;; treesitter
   :nvim-treesitter/nvim-treesitter {:build (cmd->fn :TSUpdate)
                                     :config (mod :treesitter)
                                     :event [:BufEnter]
                                     :dependencies [:romgrk/nvim-treesitter-context
                                                    :JoosepAlviste/nvim-ts-context-commentstring]}
   :danymat/neogen {:config (mod :neogen)
                    :event [:BufReadPost]}})
