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
        {:disabled_plugins rtp-disabled-plugins}}
       :rocks
       {:enabled false}})))

(use
  {:folke/lazy.nvim {:lazy true}
   :folke/snacks.nvim {:priority 1000
                       :lazy false
                       :config (mod :snacks)}
   :folke/which-key.nvim {:event [:VeryLazy]
                          :opts {}
                          :config (mod :which-key)}
   :nvim-lua/plenary.nvim {:lazy true}
   :nvim-lua/popup.nvim {:lazy true}
   :MunifTanjim/nui.nvim {:lazy true}
   :echasnovski/mini.nvim {:config (mod :mini)
                           :event [:VeryLazy]}
   :stevearc/dressing.nvim {:config (mod :dressing)}
   :EdenEast/nightfox.nvim {:build (cmd->fn :NightfoxCompile)
                            :lazy true
                            :priority 1000}
   :kyazdani42/nvim-web-devicons {:config (mod :devicons)}
   :rebelot/heirline.nvim {:config (mod :heirline)
                           :event [:BufEnter]}
   :akinsho/bufferline.nvim {:config (mod :bufferline)
                             :event [:BufEnter]}
   :lewis6991/gitsigns.nvim {:event [:VeryLazy]
                             :config (mod :gitsigns)}
   :norcalli/nvim-colorizer.lua {:config (mod :colorizer)
                                 :event [:BufEnter]}
   :lukas-reineke/indent-blankline.nvim {:event [:BufReadPost :BufAdd :BufNewFile]
                                         :config (mod :indent-blankline)}
   :ggandor/leap.nvim {:event [:VeryLazy]
                       :config (mod :leap)}
   :numToStr/Comment.nvim {:event [:BufReadPost :BufAdd :BufNewFile]
                           :config (mod :comment)}
   :kana/vim-submode {:event [:BufReadPost :BufAdd :BufNewFile]
                      :config (mod :submode)}
   :LennyPhoenix/project.nvim {:branch :fix-get_clients
                               :config (mod :project)
                               :event [:BufRead :BufNewFile]}
   :pwntester/octo.nvim {:cmd [:Octo]
                         :config (mod :octo)}
   :ghillb/cybu.nvim {:config (mod :cybu)
                      :event [:BufReadPost :BufAdd :BufNewFile]}
   :tomiis4/Hypersonic.nvim {:cmd [:Hypersonic]
                             :config (mod :hypersonic)}
   :notomo/waitevent.nvim {:config (mod :waitevent)}
   :HakonHarnes/img-clip.nvim {:config (mod :img-clip)
                               :event [:VeryLazy]}

   ;; copilot
   :zbirenbaum/copilot.lua {:config (mod :copilot)
                            :event [:VeryLazy]}
   :yetone/avante.nvim {:build :make
                        :config (mod :avante)
                        :cmd [:AvanteAsk
                              :AvanteChat
                              :AvanteToggle]
                        :dependencies [:ravitemer/mcphub.nvim]}

   ;; lsp
   :neovim/nvim-lspconfig {:config (mod :lsp)
                           :dependencies [:ray-x/lsp_signature.nvim
                                          :b0o/schemastore.nvim]
                           :event [:BufReadPre]}
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

   ;; completion
   :saghen/blink.cmp {:event [:InsertEnter
                              :CmdlineEnter]
                      :version :v1.*
                      :dependencies [:rafamadriz/friendly-snippets
                                     :echasnovski/mini.snippets
                                     :mikavilpas/blink-ripgrep.nvim
                                     :moyiz/blink-emoji.nvim
                                     :Kaiser-Yang/blink-cmp-git
                                     :Kaiser-Yang/blink-cmp-avante
                                     :giuxtaposition/blink-cmp-copilot]
                      :config (mod :cmp)}

   ;; dap
   :mfussenegger/nvim-dap {:config (mod :dap)
                           :event [:BufReadPost :BufAdd :BufNewFile]
                           :dependencies [:nvim-neotest/nvim-nio
                                          :igorlfs/nvim-dap-view]}
   :leoluz/nvim-dap-go {:ft [:go]
                        :config (mod :dap-go)}
   :rinx/nvim-dap-rego {:ft [:rego]
                        :config (mod :dap-rego)}
                        ; :dir (vim.fn.expand "~/local/src/github.com/rinx/nvim-dap-rego")}

   ;; telescope
   :nvim-telescope/telescope.nvim {:config (mod :telescope)
                                   :event [:VeryLazy]
                                   :dependencies [:nvim-telescope/telescope-dap.nvim
                                                  :cljoly/telescope-repo.nvim
                                                  :nvim-orgmode/telescope-orgmode.nvim]}

   ;; denops.vim
   :vim-denops/denops.vim {:event [:VimEnter]}
   :vim-skk/skkeleton {:config (mod :skkeleton)
                       :event [:BufEnter]}
   :lambdalisue/vim-kensaku {:event [:VimEnter]}

   ;; languages
   :gpanders/nvim-parinfer {:ft [:clojure
                                 :fennel]}
   :julienvincent/nvim-paredit {:ft [:clojure
                                     :fennel]}
   :dundalek/parpar.nvim {:ft [:clojure
                               :fennel]
                          :dependencies [:gpanders/nvim-parinfer
                                         :julienvincent/nvim-paredit]
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

   ;; orgmode
   :nvim-orgmode/orgmode {:config (mod :orgmode)
                          :event [:VeryLazy]
                          :ft [:org]
                          :dependencies [:nvim-orgmode/org-bullets.nvim
                                         :danilshvalov/org-modern.nvim
                                         :chipsenkbeil/org-roam.nvim]}})
