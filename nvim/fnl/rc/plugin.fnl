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
   :nvim-lua/plenary.nvim {:lazy true}
   :nvim-lua/popup.nvim {:lazy true}
   :MunifTanjim/nui.nvim {:lazy true}
   :stevearc/dressing.nvim {:config (mod :dressing)}
   :EdenEast/nightfox.nvim {:build (cmd->fn :NightfoxCompile)
                            :lazy true
                            :priority 1000}
   :kyazdani42/nvim-web-devicons {:config (mod :devicons)}
   :rebelot/heirline.nvim {:config (mod :heirline)
                           :event [:BufEnter]}
   :akinsho/bufferline.nvim {:config (mod :bufferline)
                             :event [:BufEnter]}
   :akinsho/toggleterm.nvim {:config (mod :toggleterm)
                             :event [:BufReadPost :BufAdd :BufNewFile]}
   :windwp/nvim-autopairs {:config (mod :autopairs)
                           :event [:InsertEnter]}
   :kyazdani42/nvim-tree.lua {:event [:VeryLazy]
                              :config (mod :nvim-tree)}
   :lewis6991/gitsigns.nvim {:event [:VeryLazy]
                             :config (mod :gitsigns)}
   :APZelos/blamer.nvim {:event [:VeryLazy]}
   :rcarriga/nvim-notify {:config (mod :notify)
                          :event [:BufEnter]}
   :norcalli/nvim-colorizer.lua {:config (mod :colorizer)
                                 :event [:BufEnter]}
   :lukas-reineke/indent-blankline.nvim {:event [:BufReadPost :BufAdd :BufNewFile]
                                         :config (mod :indent-blankline)}
   :ggandor/lightspeed.nvim {:event [:BufReadPost :BufAdd :BufNewFile]
                             :config (mod :lightspeed)}
   :numToStr/Comment.nvim {:event [:BufReadPost :BufAdd :BufNewFile]
                           :config (mod :comment)}
   :kyoh86/vim-ripgrep {:config (mod :grep)
                        :event [:VimEnter]}
   :kana/vim-submode {:event [:BufReadPost :BufAdd :BufNewFile]
                      :config (mod :submode)}
   :ahmedkhalf/project.nvim {:config (mod :project)
                             :event [:BufRead :BufNewFile]}
   :pwntester/octo.nvim {:cmd [:Octo]
                         :config (mod :octo)}
   :ghillb/cybu.nvim {:config (mod :cybu)
                      :event [:BufReadPost :BufAdd :BufNewFile]}
   :tomiis4/Hypersonic.nvim {:cmd [:Hypersonic]
                             :config (mod :hypersonic)}

   ;; :stevearc/profile.nvim {:config (mod :profile)}

   ;; lsp
   :neovim/nvim-lspconfig {:config (mod :lsp)
                           :dependencies [:ray-x/lsp_signature.nvim
                                          :SmiteshP/nvim-navic
                                          :b0o/schemastore.nvim
                                          :simrat39/rust-tools.nvim]
                           :event [:BufReadPre]}
   :j-hui/fidget.nvim {:config (mod :fidget)
                       :event [:BufReadPost :BufAdd :BufNewFile]}
   :aznhe21/actions-preview.nvim {:config (mod :actions-preview)
                                  :event [:BufReadPost :BufAdd :BufNewFile]}
   :kosayoda/nvim-lightbulb {:config (mod :lightbulb)
                             :event [:BufReadPost :BufAdd :BufNewFile]}
   :folke/trouble.nvim {:config (mod :trouble)
                        :event [:BufReadPost :BufAdd :BufNewFile]}
   :folke/lsp-colors.nvim {:config (mod :lsp-colors)
                           :event [:BufReadPost :BufAdd :BufNewFile]}
   :folke/todo-comments.nvim {:config (mod :todo-comments)
                              :event [:BufReadPost :BufAdd :BufNewFile]}
   :whynothugo/lsp_lines.nvim {:url "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
                               :config (mod :lsp-lines)
                               :event [:BufReadPost :BufAdd :BufNewFile]}

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
                           :event [:BufReadPost :BufAdd :BufNewFile]
                           :dependencies [:rcarriga/nvim-dap-ui]}

   ;; telescope
   :nvim-telescope/telescope.nvim {:config (mod :telescope)
                                   :event [:BufEnter]
                                   :dependencies [:nvim-telescope/telescope-dap.nvim
                                                  :cljoly/telescope-repo.nvim]}
   :havi/telescope-toggleterm.nvim {:url "https://git.sr.ht/~havi/telescope-toggleterm.nvim"
                                    :event [:BufEnter]}

   ;; denops.vim
   :vim-denops/denops.vim {:event [:VimEnter]}
   :vim-skk/skkeleton {:config (mod :skkeleton)
                       :event [:BufEnter]}
   :gamoutatsumi/dps-ghosttext.vim {:config (mod :ghosttext)
                                    :event [:BufEnter]}
   :lambdalisue/guise.vim {:config (mod :guise)
                           :event [:VimEnter]}
   :tani/glance-vim {:event [:BufReadPost :BufAdd :BufNewFile]}

   ;; operator/textobj
   :kana/vim-operator-user {:config (mod :operator)
                            :event [:CursorHold :CursorHoldI]
                            :dependencies [:kana/vim-operator-replace
                                           :rhysd/vim-operator-surround]}
   :kana/vim-textobj-user {:config (mod :textobj)
                           :event [:CursorHold :CursorHoldI]
                           :dependencies [:kana/vim-textobj-indent
                                          :kana/vim-textobj-function
                                          :kana/vim-textobj-entire
                                          :kana/vim-textobj-line
                                          :thinca/vim-textobj-between
                                          :mattn/vim-textobj-url
                                          :osyo-manga/vim-textobj-multiblock]}

   ;; languages
   :gpanders/nvim-parinfer {:ft [:clojure
                                 :fennel]}
   :julienvincent/nvim-paredit {:ft [:clojure
                                     :fennel]}
   :julienvincent/nvim-paredit-fennel {:dependencies [:julienvincent/nvim-paredit]
                                       :ft [:fennel]}
   :dundalek/parpar.nvim {:ft [:clojure
                               :fennel]
                          :dependencies [:gpanders/nvim-parinfer
                                         :julienvincent/nvim-paredit
                                         :julienvincent/nvim-paredit-fennel]
                          :config (mod :parpar)}
   :Olical/conjure {:ft [:clojure
                         :fennel]}
   :Olical/nfnl {:ft [:fennel]
                 :config (mod :nfnl)}

   ;; treesitter
   :nvim-treesitter/nvim-treesitter {:build (cmd->fn :TSUpdate)
                                     :config (mod :treesitter)
                                     :event [:BufEnter]
                                     :dependencies [:JoosepAlviste/nvim-ts-context-commentstring]}
   :danymat/neogen {:config (mod :neogen)
                    :event [:BufReadPost :BufAdd :BufNewFile]}})
