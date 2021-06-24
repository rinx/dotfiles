(module init
  {autoload {core aniseed.core
             nvim aniseed.nvim
             util aniseed.nvim.util
             packer packer}
   require-macros [util.macros]})

(defn- bridge [from to]
  (util.fn-bridge from :init to {:return true}))

(defn- nmap [from to]
  (nvim.set_keymap :n from to {}))
(defn- xmap [from to]
  (nvim.set_keymap :x from to {}))
(defn- vmap [from to]
  (nvim.set_keymap :v from to {}))
(defn- omap [from to]
  (nvim.set_keymap :o from to {}))
(defn- nnoremap [from to]
  (nvim.set_keymap :n from to {:noremap true}))
(defn- inoremap [from to]
  (nvim.set_keymap :i from to {:noremap true}))
(defn- cnoremap [from to]
  (nvim.set_keymap :c from to {:noremap true}))
(defn- vnoremap [from to]
  (nvim.set_keymap :v from to {:noremap true}))
(defn- onoremap [from to]
  (nvim.set_keymap :o from to {:noremap true}))

(defn- nmap-silent [from to]
  (nvim.set_keymap :n from to {:silent true}))
(defn- nnoremap-silent [from to]
  (nvim.set_keymap :n from to {:noremap true
                               :silent true}))
(defn- inoremap-silent-expr [from to]
  (nvim.set_keymap :i from to {:noremap true
                               :silent true
                               :expr true}))
(defn- xnoremap-silent [from to]
  (nvim.set_keymap :x from to {:noremap true
                               :silent true}))

(def colors
  {:error :#f07178
   :warn :#ffb454
   :info :#c2d94c
   :hint :#59c2ff
   :purple :#a37acc

   :color2 :#0f1419
   :color3 :#ffee99
   :color4 :#e6e1cf
   :color5 :#14191f
   :color13 :#b8cc52
   :color10 :#36a3d9
   :color8 :#f07178
   :color9 :#3e4b59})

;; plugins
(defn- use [...]
  "Iterates through the arguments as pairs and calls packer's use function for
  each of them. Works around Fennel not liking mixed associative and sequential
  tables as well."
  (let [pkgs [...]]
    (packer.startup
      (fn [use]
        (for [i 1 (core.count pkgs) 2]
          (let [name (. pkgs i)
                opts (. pkgs (+ i 1))]
            (use (core.assoc opts 1 name))))))))

(defn- loaded? [name]
  "Checks if the plugin is loaded."
  (let [plugins (core.get _G :packer_plugins)]
    (when name
      (let [plugin (core.get plugins name)]
        (when plugin
          (core.get plugin :loaded))))))

(use
  :wbthomason/packer.nvim {}
  :Olical/aniseed {}
  :nvim-lua/plenary.nvim {}
  :nvim-lua/popup.nvim {}
  :folke/tokyonight.nvim {}
  :kyazdani42/nvim-web-devicons {}
  :hoob3rt/lualine.nvim {}
  :akinsho/nvim-bufferline.lua {}
  :akinsho/nvim-toggleterm.lua {}
  :tyru/eskk.vim {:event [:InsertEnter]}
  :neovim/nvim-lspconfig {}
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
  :mfussenegger/nvim-dap {}
  :rcarriga/nvim-dap-ui {}
  :cohama/lexima.vim {}
  :rafamadriz/friendly-snippets {}
  :kyazdani42/nvim-tree.lua {}
  :nvim-telescope/telescope.nvim {}
  :nvim-telescope/telescope-dap.nvim {}
  :nvim-telescope/telescope-fzy-native.nvim {}
  :lewis6991/gitsigns.nvim {}
  :norcalli/nvim-colorizer.lua {}
  :ggandor/lightspeed.nvim {}
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
  :pwntester/octo.nvim {}
  :rinx/nvim-minimap {}
  :jbyuki/venn.nvim {}
  :guns/vim-sexp {:ft [:clojure
                       :fennel
                       :hy
                       :lisp
                       :scheme]}
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
                                 :cmd "MarkdownPreview"}
  :nvim-treesitter/nvim-treesitter {:run ":TSUpdate"}
  :romgrk/nvim-treesitter-context {})

(when (and (loaded? :nvim-web-devicons)
           (loaded? :nvim-treesitter))
  (def icon (require :util.icon))
  (def devicon (require :nvim-web-devicons))

  (def icontab icon.tab)

  ;; basics
  (set nvim.o.viminfo "'1000,<100,f1,h,s100")
  (set nvim.o.history 300)
  (set nvim.o.bs "indent,eol,start")

  (nvim.ex.set :ruler)
  (nvim.ex.set :number)
  (set nvim.o.cmdheight 2)
  (nvim.ex.set :wildmenu)
  (set nvim.o.wildchar 9) ;; 9 = <Tab>
  (set nvim.o.wildmode "longest:full,full")

  (set nvim.o.shortmess "filnxtToOFc")
  (set vim.opt.completeopt [:menu :menuone :noselect])

  (nvim.ex.set :imdisable)

  (nvim.ex.set :incsearch)
  (nvim.ex.set :ignorecase)
  (nvim.ex.set :smartcase)

  (nvim.ex.set :autoindent)
  (nvim.ex.set :smartindent)
  (nvim.ex.set :breakindent)

  (nvim.ex.set :confirm)

  (set nvim.o.clipboard "unnamed,unnamedplus")

  (set nvim.o.mouse "a")

  (set nvim.o.foldmethod :marker)
  (set nvim.o.foldlevel 99)

  (set nvim.o.virtualedit "block")

  (nvim.ex.set :expandtab)
  (nvim.ex.set :smarttab)
  (set nvim.o.tabstop 8)
  (set nvim.o.shiftwidth 4)
  (set nvim.o.softtabstop 4)

  (if (= (nvim.fn.exists "&pumblend") 1)
    (set nvim.o.pumblend 30))
  (if (= (nvim.fn.exists "&winblend") 1)
    (set nvim.o.winblend 30))

  (nvim.ex.set :visualbell)
  (nvim.ex.set :lazyredraw)
  (nvim.ex.set :ttyfast)

  (nvim.ex.set :showmatch)
  (set nvim.o.matchtime 3)

  (nvim.ex.set :nobackup)
  (nvim.ex.set :nowritebackup)

  (set nvim.o.updatetime 300)
  (set nvim.o.timeoutlen 500)

  (set nvim.wo.signcolumn "number")

  (nvim.ex.set :undofile)
  (set nvim.o.undolevels 1000)
  (set nvim.o.undoreload 10000)

  (let [backupdir (nvim.fn.expand "~/.config/nvim/tmp/backup")
        undodir (nvim.fn.expand "~/.config/nvim/tmp/undo")
        swapdir (nvim.fn.expand "~/.config/nvim/tmp/swap")]
    (set nvim.o.backupdir backupdir)
    (set nvim.o.undodir undodir)
    (set nvim.o.directory swapdir)

    (if (not (= (nvim.fn.isdirectory backupdir) 1))
      (nvim.fn.mkdir backupdir :p))
    (if (not (= (nvim.fn.isdirectory undodir) 1))
      (nvim.fn.mkdir undodir :p))
    (if (not (= (nvim.fn.isdirectory swapdir) 1))
      (nvim.fn.mkdir swapdir :p)))

  (nvim.ex.set :list)
  (set vim.opt.listchars
       {:eol icontab.subdirectory-arrow-left
        :extends icontab.extends
        :nbsp icontab.nbsp
        :precedes icontab.precedes
        :tab icontab.keyboard-tab
        :trail icontab.trail})

  (nvim.ex.set :noautochdir)
  (nvim.ex.set :autoread)
  (nvim.ex.set :noautowrite)

  (nvim.ex.set :noexrc)
  (nvim.ex.set :nosecure)

  (nvim.ex.set :timeout)
  (set nvim.o.timeoutlen 1000)
  (set nvim.o.ttimeoutlen 200)

  (nvim.ex.set :hidden)

  (set nvim.o.laststatus 2)
  (set nvim.o.showtabline 2)

  (nvim.ex.set :hlsearch)
  (nvim.ex.set :termguicolors)
  (nvim.ex.syntax :on)
  (nvim.ex.filetype :off)
  (nvim.ex.filetype "plugin indent on")

  (set nvim.g.tokyonight_style :storm)
  (set nvim.g.tokyonight_transparent true)
  (set nvim.g.tokyonight_dark_sidebar true)
  (set nvim.g.tokyonight_sidebars [:dapui_breakpoints
                                   :dapui_scopes
                                   :dapui_stacks
                                   :dapui_watches
                                   :NvimTree
                                   :Outline
                                   :packer])
  (nvim.ex.silent_ "colorscheme tokyonight")
  (nvim.ex.set "background=dark")
  (nvim.ex.syntax :enable)

  (defn- hi [name opts]
    (let [fg (match (core.get opts :fg)
               res (.. " ctermfg=" res " guifg=" res)
               _ "")
          bg (match (core.get opts :bg)
               res (.. " ctermbg=" res " guibg=" res)
               _ "")
          others (match (core.get opts :others)
                   res (.. " " res)
                   _ "")]
      (-> (.. name fg bg others)
          (nvim.ex.highlight))))
  (defn hi-link [from to]
    (nvim.ex.highlight_ :link from to))

  (hi :Normal {:bg :none})
  (hi :LineNr {:bg :none})
  (hi :VertSplit {:bg :none})
  (hi :NonText {:bg :none})
  (hi :EndOfBuffer {:bg :none})

  (hi :Keyword {:others "cterm=bold,italic gui=bold,italic"})

  (hi :LspDiagnosticsUnderlineError
      {:others (.. "cterm=undercurl gui=undercurl guisp=" colors.error)})
  (hi :LspDiagnosticsUnderlineWarning
      {:others (.. "cterm=undercurl gui=undercurl guisp=" colors.warn)})
  (hi :LspDiagnosticsUnderlineInformation
      {:others (.. "cterm=undercurl gui=undercurl guisp=" colors.info)})
  (hi :LspDiagnosticsUnderlineHint
      {:others (.. "cterm=undercurl gui=undercurl guisp=" colors.hint)})
  (hi :LspDiagnosticsSignError
      {:others (.. "ctermfg=red guifg=" colors.error)})
  (hi :LspDiagnosticsSignWarning
      {:others (.. "ctermfg=yellow guifg=" colors.warn)})
  (hi :LspDiagnosticsSignInformation
      {:others (.. "ctermfg=green guifg=" colors.info)})
  (hi :LspDiagnosticsSignHint
      {:others (.. "ctermfg=blue guifg=" colors.hint)})
  (hi :LspDiagnosticsSignLightBulb
      {:others (.. "ctermfg=yellow guifg=" colors.warn)})
  (hi :LspDiagnosticsVirtualTextError
      {:others (.. "ctermfg=red guifg=" colors.error " guibg=" colors.color5)})
  (hi :LspDiagnosticsVirtualTextWarning
      {:others (.. "ctermfg=yellow guifg=" colors.warn " guibg=" colors.color5)})
  (hi :LspDiagnosticsVirtualTextInformation
      {:others (.. "ctermfg=green guifg=" colors.info " guibg=" colors.color5)})
  (hi :LspDiagnosticsVirtualTextHint
      {:others (.. "ctermfg=blue guifg=" colors.hint " guibg=" colors.color5)})
  (hi :LspDiagnosticsDefaultError
      {:others (.. "ctermfg=red guifg=" colors.color8 " guibg=" colors.color5)})
  (hi :LspDiagnosticsFloatingError
      {:others (.. "ctermfg=red guifg=" colors.color8 " guibg=" colors.color5)})
  (hi :LspDiagnosticsDefaultWarning
      {:others (.. "ctermfg=yellow guifg=" colors.warn " guibg=" colors.color5)})
  (hi :LspDiagnosticsFloatingWarning
      {:others (.. "ctermfg=yellow guifg=" colors.warn " guibg=" colors.color5)})
  (hi :LspDiagnosticsDefaultHint
      {:others (.. "ctermfg=blue guifg=" colors.color10 " guibg=" colors.color5)})
  (hi :LspDiagnosticsFloatingHint
      {:others (.. "ctermfg=blue guifg=" colors.color10 " guibg=" colors.color5)})
  (hi :LspDiagnosticsDefaultInformation
      {:others (.. "ctermfg=green guifg=" colors.color13 " guibg=" colors.color5)})
  (hi :LspDiagnosticsFloatingInformation
      {:others (.. "ctermfg=green guifg=" colors.color13 " guibg=" colors.color5)})
  (hi :LspCodeLens
      {:others (.. "gui=bold,italic,underline guifg=" colors.color2
                   " guibg=" colors.color10)})

  ;; mappings
  (set nvim.g.mapleader :\)

  (nnoremap ";" ":")
  (nnoremap ":" ";")
  (vnoremap ";" ":")
  (vnoremap ":" ";")

  (nnoremap "<Left>" "<Nop>")
  (nnoremap "<Down>" "<Nop>")
  (nnoremap "<Up>" "<Nop>")
  (nnoremap "<Right>" "<Nop>")

  (inoremap "<Left>" "<Nop>")
  (inoremap "<Down>" "<Nop>")
  (inoremap "<Up>" "<Nop>")
  (inoremap "<Right>" "<Nop>")

  (nnoremap "<C-t>" "<Nop>")

  (nnoremap "j" "gj")
  (nnoremap "k" "gk")
  (nnoremap "0" "g0")
  (nnoremap "$" "g$")
  (vnoremap "j" "gj")
  (vnoremap "k" "gk")
  (onoremap "j" "gj")
  (onoremap "k" "gk")

  (nnoremap "gj" "j")
  (nnoremap "gk" "k")
  (nnoremap "g0" "0")
  (nnoremap "g$" "$")
  (vnoremap "gj" "j")
  (vnoremap "gk" "k")
  (onoremap "gj" "j")
  (onoremap "gk" "k")

  (nnoremap "Y" "y$")

  (nnoremap ",p" "\"+p")
  (nnoremap ",P" "\"+P")

  (nnoremap ",y" "\"+y")
  (nnoremap ",d" "\"+d")
  (vnoremap ",y" "\"+y")
  (vnoremap ",d" "\"+d")

  (cnoremap "<C-p>" "<Up>")
  (cnoremap "<C-n>" "<Down>")

  (nvim.set_keymap :t "<ESC>" "<C-\\><C-n>" {:noremap true
                                             :silent true})

  (nnoremap :s :<Nop>)
  (nnoremap :S :<Nop>)
  (nnoremap-silent "sj" "<C-w>j")
  (nnoremap-silent "sk" "<C-w>k")
  (nnoremap-silent "sl" "<C-w>l")
  (nnoremap-silent "sh" "<C-w>h")
  (nnoremap-silent "sJ" "<C-w>J")
  (nnoremap-silent "sK" "<C-w>K")
  (nnoremap-silent "sL" "<C-w>L")
  (nnoremap-silent "sH" "<C-w>H")
  (nnoremap-silent "sr" "<C-w>r")
  (nnoremap-silent "sw" "<C-w>w")
  (nnoremap-silent "s_" "<C-w>_")
  (nnoremap-silent "s|" "<C-w>|")
  (nnoremap-silent "so" "<C-w>_<C-w>|")
  (nnoremap-silent "sO" "<C-w>=")
  (nnoremap-silent "s=" "<C-w>=")
  (nnoremap-silent "ss" ":<C-u>sp<CR>")
  (nnoremap-silent "sv" ":<C-u>vs<CR>")

  (nnoremap-silent "<Leader>p" ":setl paste!<CR>")
  (nnoremap-silent "<Leader>r" ":setl relativenumber!<CR>")
  (nnoremap-silent "<Leader>s" ":setl spell!<CR>")

  (nnoremap :MM :zz)
  (nnoremap :ZZ :<Nop>)
  (nnoremap :ZQ :<Nop>)
  (nnoremap :Q :<Nop>)

  ;; grep
  (if (= (nvim.fn.executable :rg) 1)
    (do
      (set nvim.o.grepprg "rg --vimgrep --no-heading")
      (set nvim.o.grepformat "%f:%l:%c:%m,%f:%l:%m")
      (set nvim.g.ackprg "rg --vimgrep --no-heading")))

  ;; eskk
  (set nvim.g.eskk#dictionary
       {:path "~/.skk-jisyo"
        :sorted 0
        :encoding "euc_jp"})
  (set nvim.g.eskk#large_dictionary
       {:path "~/.SKK-JISYO.L"
        :sorted 0
        :encoding "euc_jp"})
  (set nvim.g.eskk#show_candidates_count 3)
  (set nvim.g.eskk#kakutei_when_unique_candidate 1)
  (set nvim.g.eskk#marker_henkan ">")
  (set nvim.g.eskk#marker_okuri "*")
  (set nvim.g.eskk#marker_henkan_select ">>")
  (set nvim.g.eskk#marker_jisyo_touroku "?")
  (set nvim.g.eskk#enable_completion 0)
  (set nvim.g.eskk#max_candidates 15)
  (set nvim.g.eskk#use_color_cursor 0)

  ;; neovim LSP
  (let [lsp (require :lspconfig)
        configs (require :lspconfig/configs)
        util (require :lspconfig/util)
        lsp-kind (require :lspkind)
        lsp-status (require :lsp-status)
        lsp-signature (require :lsp_signature)
        on-attach (fn [client bufnr]
                    (lsp-status.on_attach client)
                    (lsp-signature.on_attach {:bind true
                                              :doc_lines 10
                                              :hint_enabled true
                                              :hint_prefix (.. icontab.info " ")
                                              :hint_scheme :String
                                              :handler_opts
                                              {:border :single}
                                              :decorator {"`" "`"}}))
        compe (require :compe)
        capabilities (let [cap (vim.lsp.protocol.make_client_capabilities)]
                       (set cap.textDocument.completion.completionItem.snippetSupport true)
                       (set cap.textDocument.completion.completionItem.resolveSupport
                            {:properties
                             [:documentation
                              :detail
                              :additionalTextEdits]})
                       cap)]
    (lsp-kind.init)
    (lsp-status.register_progress)
    (lsp-status.config {:status_symbol (.. icontab.code-braces " ")
                        :indicator_errors icontab.ban
                        :indicator_warnings icontab.exclam-tri
                        :indicator_info icontab.info-circle
                        :indicator_hint icontab.leaf
                        :indicator_ok icontab.check
                        :current_function false})
    (when (not lsp.hyls)
      (tset configs :hyls
            {:default_config
             {:cmd [:hyls]
              :filetypes [:hy]
              :root_dir util.path.dirname}}))
    (lsp.bashls.setup {:on_attach on-attach
                       :capabilities capabilities})
    (lsp.clojure_lsp.setup {:on_attach on-attach
                            :capabilities capabilities})
    (lsp.dockerls.setup {:on_attach on-attach
                         :capabilities capabilities})
    (lsp.efm.setup {:on_attach on-attach
                    :capabilities capabilities
                    :filetypes [:markdown
                                :proto]
                    :init_options {:codeAction true
                                   :completion true
                                   :documentFormatting true
                                   :documentSymbol true
                                   :hover true}
                    :settings
                    {:languages
                     {:markdown
                      [{:lintCommand "textlint --format unix ${INPUT}"
                        :lintFormats ["%f:%l:%n: %m"]}
                       {:lintCommand "markdownlint -s -c %USERPROFILE%.markdownlintrc"
                        :lintStdin true
                        :lintFormats ["%f:%l %m"
                                      "%f:%l:%c %m"
                                      "%f: %l: %m"]}
                       {:hoverCommand :excitetranslate
                        :hoverStdin true}]
                      :proto
                      [{:lintCommand "buf lint --path"}]}
                     :lintDebounce 3000000000}})
    (lsp.fortls.setup {:on_attach on-attach
                       :capabilities capabilities})
    (lsp.gopls.setup {:on_attach on-attach
                      :capabilities capabilities
                      :settings {:gopls
                                 {:usePlaceholders true
                                  :analyses {:fieldalignment true
                                             :fillstruct true
                                             :nilless true
                                             :shadow true
                                             :unusedwrite true}
                                  :staticcheck true
                                  :gofumpt true}}})
    (lsp.hls.setup {:on_attach on-attach
                    :capabilities capabilities})
    (lsp.hyls.setup {:on_attach on-attach
                     :capabilities capabilities})
    (lsp.jsonls.setup {:on_attach on-attach
                       :capabilities capabilities})
    (lsp.julials.setup {:on_attach on-attach
                        :capabilities capabilities})
    (lsp.kotlin_language_server.setup {:on_attach on-attach
                                       :capabilities capabilities})
    (lsp.tsserver.setup {:on_attach on-attach
                         :capabilities capabilities})
    (lsp.yamlls.setup {:on_attach on-attach
                       :capabilities capabilities
                       :settings {:yaml
                                  {:schemaStore {:enable true}}}})
    ;; rust-analyzer
    (when (loaded? :rust-tools.nvim)
      (let [rust-tools (require :rust-tools)]
        (rust-tools.setup {:tools
                           {:inlay_hints
                            {:parameter_hints_prefix (.. " "
                                                         icontab.slash
                                                         icontab.arrow-l
                                                         " ")
                             :other_hints_prefix (.. " "
                                                     icontab.arrow-r
                                                     " ")}}
                           :server
                           {:on_attach on-attach
                            :capabilities capabilities
                            :settings {:rust-analyzer
                                       {:cargo {:allFeatures true}
                                        :lens {:enable true
                                               :methodReferences true
                                               :references true}}}}})))
    (compe.setup {:enabled true
                  :autocomplete true
                  :debug false
                  :min_length 1
                  :preselect "enable"
                  :throttle_time 80
                  :source_timeout 200
                  :incomplete_delay 400
                  :max_abbr_width 100
                  :max_kind_width 100
                  :max_menu_width 100
                  :documentation true
                  :source {:buffer {:kind icontab.document}
                           :calc {:kind icontab.calc}
                           :conjure {:filetypes [:clojure
                                                 :fennel
                                                 :hy]}
                           :emoji {:kind icontab.heart
                                   :filetypes [:gitcommit
                                               :markdown]}
                           :nvim_lsp {:kind icontab.cube}
                           :nvim_lua {:kind icontab.vim
                                      :filetypes [:lua]}
                           :omni false
                           :path {:kind icontab.dots}
                           :spell {:kind icontab.pencil}
                           :tag {:kind icontab.tag}
                           :treesitter {:kind icontab.leaf}
                           :vsnip {:kind icontab.quote-l}}}))

  (nnoremap-silent :K ":<C-u>lua vim.lsp.buf.hover()<CR>")
  (nnoremap-silent :gd ":<C-u>lua vim.lsp.buf.definition()<CR>")
  (nnoremap-silent :gD ":<C-u>lua vim.lsp.buf.declaration()<CR>")
  (nnoremap-silent :gi ":<C-u>lua vim.lsp.buf.implementation()<CR>")
  (nnoremap-silent :gr ":<C-u>lua vim.lsp.buf.references()<CR>")

  (nnoremap-silent :<leader>f ":<C-u>lua vim.lsp.buf.formatting()<CR>")
  (xnoremap-silent :<leader>f ":<C-u>lua vim.lsp.buf.range_formatting()<CR>")

  (nnoremap-silent :<leader>l ":<C-u>lua vim.lsp.codelens.run()<CR>")
  (augroup init-lsp-codelens
           (autocmd "CursorHold,CursorHoldI"
                    "*"
                    "lua vim.lsp.codelens.refresh()"))

  ;; lspsaga
  (if (loaded? :lspsaga.nvim)
    (do
      (let [saga (require :lspsaga)]
        (saga.init_lsp_saga
          {:error_sign icontab.bug
           :warn_sign icontab.exclam-circle
           :infor_sign icontab.info-circle
           :hint_sign icontab.leaf
           :dianostic_header_icon (.. icontab.search " ")
           :code_action_icon (.. icontab.lightbulb " ")
           :code_action_prompt {:enable true
                                :sign false
                                :sign_priority 20
                                :virtual_text false}
           :finder_definition_icon (.. icontab.star-alt " ")
           :finder_reference_icon (.. icontab.star-alt " ")
           :max_preview_lines 12
           :finder_action_keys {:open :o
                                :vsplit :v
                                :split :s
                                :quit :q
                                :scroll_down "<C-f>"
                                :scroll_up "<C-b>"}
           :code_action_keys {:quit :q :exec "<CR>"}
           :rename_action_keys {:quit "<C-c>" :exec "<CR>"}
           :definition_preview_icon (.. icontab.compas " ")
           :border_style :round
           :rename_prompt_prefix icontab.chevron-r}))
      (nnoremap-silent :gh ":<C-u>Lspsaga lsp_finder<CR>")
      (nnoremap-silent :gs ":<C-u>Lspsaga signature_help<CR>")
      (nnoremap-silent "<leader>rn" ":<C-u>Lspsaga rename<CR>")
      (nnoremap-silent "<Leader>a" ":<C-u>Lspsaga code_action<CR>")
      (xnoremap-silent "<Leader>a" ":<C-u>Lspsaga range_code_action<CR>")
      (nnoremap-silent "<Leader>d" ":<C-u>Lspsaga show_line_diagnostics<CR>")
      (nnoremap-silent "[d" ":<C-u>Lspsaga diagnostic_jump_prev<CR>")
      (nnoremap-silent "]d" ":<C-u>Lspsaga diagnostic_jump_next<CR>"))
    (do
      (nnoremap-silent "<leader>rn" ":<C-u>lua vim.lsp.buf.rename()<CR>")
      (nnoremap-silent "<Leader>a" ":<C-u>lua vim.lsp.buf.code_action()<CR>")
      (xnoremap-silent "<Leader>a" ":<C-u>lua vim.lsp.buf.range_code_action()<CR>")
      (nnoremap-silent "<Leader>d" ":<C-u>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
      (nnoremap-silent "[d" ":<C-u>lua vim.lsp.diagnostic.goto_prev()<CR>")
      (nnoremap-silent "]d" ":<C-u>lua vim.lsp.diagnostic.goto_next()<CR>")))

  (set nvim.g.diagnostic_enable_virtual_text 1)
  (set nvim.g.diagnostic_trimmed_virtual_text 40)
  (set nvim.g.diagnostic_show_sign 1)
  (set nvim.g.diagnostic_insert_delay 1)

  (nvim.fn.sign_define :LspDiagnosticsSignError
                       {:text icontab.bug
                        :texthl :LspDiagnosticsSignError})
  (nvim.fn.sign_define :LspDiagnosticsSignWarning
                       {:text icontab.exclam-circle
                        :texthl :LspDiagnosticsSignWarning})
  (nvim.fn.sign_define :LspDiagnosticsSignInformation
                       {:text icontab.info-circle
                        :texthl :LspDiagnosticsSignInformation})
  (nvim.fn.sign_define :LspDiagnosticsSignHint
                       {:text icontab.leaf
                        :texthl :LspDiagnosticsSignHint})

  ;; trouble.nvim
  (when (loaded? :trouble.nvim)
    (let [trouble (require :trouble)]
      (trouble.setup {:auto_open true
                      :auto_close true
                      :use_lsp_diagnostic_signs true})
      (nnoremap-silent "<leader>xx" ":<C-u>TroubleToggle<CR>")
      (nnoremap-silent "<leader>xw" ":<C-u>TroubleToggle lsp_workspace_diagnostics<CR>")
      (nnoremap-silent "<leader>xd" ":<C-u>TroubleToggle lsp_document_diagnostics<CR>")
      (nnoremap-silent "<leader>xq" ":<C-u>TroubleToggle quickfix<CR>")
      (nnoremap-silent "<leader>xl" ":<C-u>TroubleToggle loclist<CR>")
      (nnoremap-silent "gR" ":<C-u>TroubleToggle lsp_references<CR>")))

  ;; lsp-colors.nvim
  (when (loaded? :lsp-colors.nvim)
    (let [colors (require :lsp-colors)]
      (colors.setup {:Error colors.error
                     :Warning colors.warn
                     :Information colors.info
                     :Hint colors.hint})))

  (when (loaded? :todo-comments.nvim)
    (let [tdc (require :todo-comments)]
      (tdc.setup {:signs true
                  :keywords {:FIX {:icon icontab.bug
                                   :color :error
                                   :alt [:FIXME :BUG :FIXIT :FIX :ISSUE]}
                             :TODO {:icon icontab.check
                                    :color :info}
                             :HACK {:icon icontab.fire
                                    :color :warning}
                             :WARN {:icon icontab.excram-tri
                                    :color :warning}
                             :PERF {:icon icontab.watch
                                    :color :default
                                    :alt [:OPTIM :PERFORMANCE :OPTIMIZE]}
                             :NOTE {:icon icontab.comment-alt
                                    :color :hint
                                    :alt [:INFO]}}
                  :colors {:error [:LspDiagnosticsSignError]
                           :warning [:LspDiagnosticsSignWarning]
                           :info [:LspDiagnosticsSignInformation]
                           :hint [:LspDiagnosticsSignHint]
                           :default [colors.purple]}})))

  ;; symbols-outline
  (when (loaded? :symbols-outline.nvim)
    (set nvim.g.symbols_outline {:highlight_hovered_item true
                                 :show_guides true
                                 :auto_preview true
                                 :position :right
                                 :keymaps {:close :<Esc>
                                           :goto_location :<CR>
                                           :focus_location :o
                                           :hover_symbol :<Space>
                                           :rename_symbol :r
                                           :code_actions :a}
                                 :lsp_blacklist {}})
    (nnoremap-silent :<leader>o ":<C-u>SymbolsOutline<CR>"))

  ;; dap
  (when (and (loaded? :nvim-dap)
             (loaded? :nvim-dap-ui))
    (let [dap (require :dap)
          dap-ext-vscode (require :dap.ext.vscode)
          dapui (require :dapui)]
      ;; go
      (when (= (nvim.fn.executable :dlv) 1)
        (let [dlv-path (vim.fn.exepath :dlv)
              vscode-go-path (.. (vim.fn.stdpath :data) :/dap/vscode-go)
              debug-adapter-path (.. vscode-go-path :/dist/debugAdapter.js)]

          (defn dap-sync-go-adapter []
            (if (vim.fn.empty (vim.fn.glob vscode-go-path))
              (do
                (vim.cmd
                  (string.format
                    (.. "!git clone --depth 1 "
                        "http://github.com/golang/vscode-go %s; "
                        "cd %s; "
                        "npm install; "
                        "npm run compile")
                    vscode-go-path
                    vscode-go-path))
                (print "finished to install Go adapter."))
              (do
                (vim.cmd
                  (string.format
                    (.. "!cd %s; "
                        "git pull origin master; "
                        "npm install; "
                        "npm run compile")
                    vscode-go-path))
                (print "finished to update Go adapter."))))
          (nvim.ex.command_ :DapSyncGoAdapter (->viml :dap-sync-go-adapter))

          (set dap.adapters.go
               {:name :dlv
                :type :executable
                :command :node
                :args [debug-adapter-path]})
          (set dap.configurations.go
               [{:type :go
                 :name "Launch file"
                 :request :launch
                 :showLog true
                 :program "${file}"
                 :dlvToolPath dlv-path}
                {:type :go
                 :name "Launch test file"
                 :request :launch
                 :mode :test
                 :showLog true
                 :program "${file}"
                 :args ["-test.v"]
                 :dlvToolPath dlv-path}])))

      ;; lldb
      (let [adapter-path (.. (vim.fn.stdpath :data) :/dap/codelldb)
            codelldb-path (.. adapter-path :/extension/adapter/codelldb)
            codelldb-url (if (= (vim.fn.has :unix) 1)
                           "https://github.com/vadimcn/vscode-lldb/releases/latest/download/codelldb-x86_64-linux.vsix"
                           "https://github.com/vadimcn/vscode-lldb/releases/latest/download/codelldb-x86_64-darwin.vsix")]
        (defn dap-sync-lldb-adapter []
          (if (vim.fn.empty (vim.fn.glob adapter-path))
            (do
              (vim.cmd
                (string.format
                  (.. "!curl -L %s --output /tmp/codelldb.zip; "
                      "unzip /tmp/codelldb.zip -d %s; "
                      "rm -rf /tmp/codelldb.zip")
                  codelldb-url
                  adapter-path))
              (print "finished to install codelldb."))
            (do
              (print "codelldb already installed."))))
        (nvim.ex.command_ :DapSyncLLDBAdapter (->viml :dap-sync-lldb-adapter))
        (set dap.adapters.rust
             (fn [callback config]
               (let [port (math.random 30000 40000)
                     (handle pid-or-err)
                     (vim.loop.spawn
                       codelldb-path
                       {:args ["--port" (string.format "%d" port)]
                        :detached true}
                       (fn [code]
                         (handle:close)
                         (print "codelldb exited with code: " code)))]
                 (vim.defer_fn
                   (fn []
                     (callback {:type :server
                                :host "127.0.0.1"
                                :port port}))
                   500))))
        (set dap.configurations.rust
             [{:type :rust
               :name :Debug
               :request :launch
               :cwd (vim.fn.getcwd)
               :program (.. :target/debug/
                            (vim.fn.fnamemodify (vim.fn.getcwd) ":t"))}]))

      ;; kotlin
      (let [adapter-path (.. (vim.fn.stdpath :data) :/dap/kotlin)
            bin-path (.. adapter-path
                         :/adapter/build/install/adapter/bin/kotlin-debug-adapter)]
        (defn dap-sync-kotlin-adapter []
          (if (vim.fn.empty (vim.fn.glob adapter-path))
            (do
              (vim.cmd
                (string.format
                  (.. "!git clone --depth 1 "
                      "https://github.com/fwcd/kotlin-debug-adapter %s; "
                      "cd %s; "
                      "./gradlew :adapter:installDist")
                  adapter-path
                  adapter-path))
              (print "finished to install kotlin-debug-adapter"))
            (do
              (print "kotlin-debug-adapter already installed."))))
        (nvim.ex.command_ :DapSyncKotlinAdapter (->viml :dap-sync-kotlin-adapter))
        (set dap.adapters.kotlin
             {:name :kotlin-debug-adapter
              :type :executable
              :command bin-path}))

      ;; loading .vscode/launch.js
      (pcall dap-ext-vscode.load_launchjs)

      (dapui.setup {:icons
                    {:expanded icontab.fold-open
                     :collapsed icontab.fold-closed}})
      (hi :DapBreakpoint {:others (.. "ctermfg=red guifg=" colors.error)})
      (hi :DapLogPoint {:others (.. "ctermfg=yellow guifg=" colors.warn)})
      (hi :DapStopped {:others (.. "ctermfg=blue guifg=" colors.hint)})
      (nvim.fn.sign_define :DapBreakpoint
                           {:text icontab.circle
                            :texthl :DapBreakpoint})
      (nvim.fn.sign_define :DapLogPoint
                           {:text icontab.comment
                            :texthl :DapLogPoint})
      (nvim.fn.sign_define :DapStopped
                           {:text icontab.arrow-r
                            :texthl :DapStopped})

      (nvim.ex.command_ :DapToggleBreakpoint "lua require('dap').toggle_breakpoint()")
      (nvim.ex.command_ :DapListBreakpoints "lua require('dap').list_breakpoints()")
      (nvim.ex.command_ :DapContinue "lua require('dap').continue()")
      (nvim.ex.command_ :DapStepOver "lua require('dap').step_over()")
      (nvim.ex.command_ :DapStepInto "lua require('dap').step_into()")
      (nvim.ex.command_ :DapStepOut "lua require('dap').step_out()")
      (nvim.ex.command_ :DapUIOpen "lua require('dapui').open()")
      (nvim.ex.command_ :DapUIClose "lua require('dapui').close()")
      (nvim.ex.command_ :DapUIToggle "lua require('dapui').toggle()")

      (nnoremap-silent "<F5>" ":<C-u>DapContinue<CR>")
      (nnoremap-silent "<F9>" ":<C-u>DapToggleBreakpoint<CR>")
      (nnoremap-silent "<F10>" ":<C-u>DapStepOver<CR>")
      (nnoremap-silent "<F11>" ":<C-u>DapStepInto<CR>")
      (nnoremap-silent "<F12>" ":<C-u>DapStepOut<CR>")))

  ;; lexima
  (set nvim.g.lexima_no_default_rules true)
  (nvim.fn.lexima#set_default_rules)

  ;; compe
  (inoremap-silent-expr "<C-s>"  "compe#complete()")
  (inoremap-silent-expr "<CR>"   "compe#confirm(lexima#expand('<LT>CR>', 'i'))")
  (inoremap-silent-expr "<C-e>"  "compe#close('<C-e>')")
  (inoremap-silent-expr "<Up>"   "compe#scroll({ 'delta': +4 })")
  (inoremap-silent-expr "<Down>" "compe#scroll({ 'delta': -4 })")

  ;; lightbulb
  (when (loaded? :nvim-lightbulb)
    (defn lightbulb-update []
      (let [lightbulb (require :nvim-lightbulb)]
        (lightbulb.update_lightbulb)))
    (augroup init-lightbulb
             (autocmd "CursorHold,CursorHoldI" "*" (->viml :lightbulb-update)))
    (nvim.fn.sign_define :LightBulbSign
                         {:text icontab.lightbulb
                          :texthl :LspDiagnosticsSignLightBulb}))

  ;; nvim-tree.lua
  (set nvim.g.nvim_tree_side :left)
  (set nvim.g.nvim_tree_width 30)
  (set nvim.g.nvim_tree_auto_close 1)
  (set nvim.g.nvim_tree_follow 1)
  (set nvim.g.nvim_tree_indent_markers 1)
  (set nvim.g.nvim_tree_icons {:default icontab.text
                               :symlink icontab.symlink
                               :git {:unstaged icontab.diff-modified
                                     :staged icontab.check
                                     :unmerged icontab.merge
                                     :renamed icontab.diff-renamed
                                     :untracked icontab.asterisk}
                               :folder {:default icontab.folder
                                        :open icontab.folder-open}})

  (nnoremap-silent :<leader>t ":<C-u>NvimTreeToggle<CR>")

  ;; diffview.nvim
  (when (loaded? :diffview.nvim)
    (let [dv (require :diffview)]
      (dv.setup {:diff_binaries false
                 :file_panel {:width 35
                              :use_icons true}
                 :key_bindings {:disable_defaults false}})))

  ;; telescope
  (when (loaded? :telescope.nvim)
    (let [telescope (require :telescope)
          actions (require :telescope.actions)
          builtin (require :telescope.builtin)
          finders (require :telescope.finders)
          pickers (require :telescope.pickers)
          previewers (require :telescope.previewers)
          sorters (require :telescope.sorters)
          themes (require :telescope.themes)
          action-cmds [:ConjureConnect
                       :ConjureLogSplit
                       :DapContinue
                       :DapListBreakpoints
                       :DapStepInto
                       :DapStepOut
                       :DapStepOver
                       :DapSyncGoAdapter
                       :DapSyncKotlinAdapter
                       :DapSyncLLDBAdapter
                       :DapToggleBreakpoint
                       :DapUIClose
                       :DapUIOpen
                       :DapUIToggle
                       :LspInfo
                       :LspRestart
                       :LspStart
                       :LspStop
                       :MarkdownPreview
                       :MinimapToggle
                       :NvimTreeRefresh
                       :NvimTreeToggle
                       :PackerClean
                       :PackerCompile
                       :PackerInstall
                       :PackerStatus
                       :PackerSync
                       :PackerUpdate
                       :SymbolsOutline
                       :ToggleTerm
                       :ToggleTermCloseAll
                       :ToggleTermOpenAll
                       :TodoTrouble
                       :TroubleToggle
                       "TroubleToggle loclist"
                       "TroubleToggle lsp_document_diagnostics"
                       "TroubleToggle lsp_references"
                       "TroubleToggle lsp_workspace_diagnostics"
                       "TroubleToggle quickfix"]]
      (telescope.setup {:defaults
                        {:prompt_prefix (.. icontab.search " ")
                         :selection_caret (.. icontab.rquot " ")
                         :sorting_strategy :ascending
                         :scroll_strategy :cycle}
                        :extensions
                        {:fzy_native
                         {:override_generic_sorter true
                          :override_file_sorter true}}})

      (when (loaded? :telescope-dap.nvim)
        (telescope.load_extension :dap))

      (when (loaded? :telescope-fzy-native.nvim)
        (telescope.load_extension :fzy_native))

      (defn telescope-git-status []
        (builtin.git_status
          {:previewer (previewers.new_termopen_previewer
                        {:get_command
                         (fn [entry]
                           [:git :-c :core.pager=delta
                            :-c :delta.side-by-side=false :diff
                            entry.value])})}))
      (nvim.ex.command_ :TelescopeGitStatus (->viml :telescope-git-status))

      (defn telescope-actions []
        (let [p (pickers.new
                  (themes.get_dropdown {})
                  {:prompt_title :Actions
                   :finder (finders.new_table {:results action-cmds})
                   :sorter (sorters.get_fzy_sorter)
                   :attach_mappings (fn [_ map]
                                      (map :i :<CR> actions.set_command_line)
                                      true)})]
          (p:find)))
      (nvim.ex.command_ :TelescopeActions (->viml :telescope-actions))

      (hi :TelescopeBorder
          {:bg :none
           :others (.. "blend=0 ctermfg=blue guifg=" colors.color10)})
      (hi :TelescopePromptPrefix
          {:others (.. "ctermfg=blue guifg=" colors.color10)})

      (nnoremap-silent ",uf" ":<C-u>Telescope fd<CR>")
      (nnoremap-silent ",uaf"
                       ":<C-u>Telescope find_files find_command=fd,--hidden<CR>")
      (nnoremap-silent ",uof" ":<C-u>Telescope oldfiles<CR>")
      (nnoremap-silent ",ugf" ":<C-u>Telescope git_files<CR>")
      (nnoremap-silent ",ugb" ":<C-u>Telescope git_branches<CR>")
      (nnoremap-silent ",ugc" ":<C-u>Telescope git_commits<CR>")
      (nnoremap-silent ",ugs" ":<C-u>TelescopeGitStatus<CR>")
      (nnoremap-silent ",ug" ":<C-u>Telescope live_grep<CR>")
      (nnoremap-silent ",u/" ":<C-u>Telescope current_buffer_fuzzy_find<CR>")
      (nnoremap-silent ",ub" ":<C-u>Telescope buffers<CR>")
      (nnoremap-silent ",ut" ":<C-u>Telescope filetypes<CR>")
      (nnoremap-silent ",uc"
                       ":<C-u>Telescope command_history theme=get_dropdown<CR>")
      (nnoremap-silent ",uh" ":<C-u>Telescope help_tags<CR>")
      (nnoremap-silent :<Leader><Leader>
                       ":<C-u>Telescope commands theme=get_dropdown<CR>")
      (nnoremap-silent :<C-\> ":<C-u>Telescope builtin<CR>")
      (nnoremap-silent :<Leader>h ":<C-u>TelescopeActions<CR>")))

  ;; gitsigns
  (let [gs (require :gitsigns)]
    (gs.setup {:signs {:add {:hl :GitSignsAdd
                             :text icontab.plus
                             :numhl :GitSignsAddNr
                             :linehl :GitSignsAddLn}
                       :change {:hl :GitSignsChange
                                :text icontab.circle
                                :numhl :GitSignsChangeNr
                                :linehl :GitSignsChangeLn}
                       :delete {:hl :GitSignsDelete
                                :text icontab.minus
                                :numhl :GitSignsDeleteNr
                                :linehl :GitSignsDeleteLn}
                       :topdelete {:hl :GitSignsDelete
                                   :text icontab.level-up
                                   :numhl :GitSignsDeleteNr
                                   :linehl :GitSignsDeleteLn}
                       :changedelete {:hl :GitSignsChange
                                      :text icontab.dots
                                      :numhl :GitSignsChangeNr
                                      :linehl :GitSignsChangeLn}}
               :numhl false
               :linehl false
               :keymaps {}
               :watch_index {:interval 1000}
               :current_line_blame false
               :sign_priority 6
               :update_debounce 100
               :status_formatter nil
               :use_decoration_api true
               :use_internal_diff true}))

  ;; nvim-colorizer
  (when (loaded? :nvim-colorizer.lua)
    (let [colorizer (require :colorizer)]
      (colorizer.setup)))

  ;; lightspeed.nvim
  (when (loaded? :lightspeed.nvim)
    (let [lightspeed (require :lightspeed)]
      (lightspeed.setup {:jump_to_first_match true
                         :jump_on_partial_input_safety_timeout 400
                         :highlight_unique_chars false
                         :grey_out_search_area true
                         :match_only_the_start_of_same_char_seqs true
                         :limit_ft_matches 5
                         :full_inclusive_prefix_key :<C-x>}))
    (nmap :z :<Plug>Lightspeed_s)
    (nmap :Z :<Plug>Lightspeed_S))

  ;; submode
  (nvim.ex.silent_ "call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')")
  (nvim.ex.silent_ "call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')")
  (nvim.ex.silent_ "call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')")
  (nvim.ex.silent_ "call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')")
  (nvim.ex.silent_ "call submode#map('bufmove', 'n', '', '>', '<C-w>>')")
  (nvim.ex.silent_ "call submode#map('bufmove', 'n', '', '<', '<C-w><')")
  (nvim.ex.silent_ "call submode#map('bufmove', 'n', '', '+', '<C-w>+')")
  (nvim.ex.silent_ "call submode#map('bufmove', 'n', '', '-', '<C-w>-')")

  ;; arpeggio
  (nvim.ex.silent_ "call arpeggio#load()")

  ;; operator
  (set nvim.g.caw_no_default_keymappings 1)
  (nvim.ex.silent_ "Arpeggio map or <Plug>(operator-replace)")
  (nvim.ex.silent_ "Arpeggio map oc <Plug>(caw:hatpos:toggle:operator)")
  (nvim.ex.silent_ "Arpeggio map od <Plug>(caw:hatpos:uncomment:operator)")
  (nvim.ex.silent_ "Arpeggio map oe <Plug>(caw:zeropos:toggle:operator)")
  (nvim.set_keymap "" "Sa" "<Plug>(operator-surround-append)" {})
  (nvim.set_keymap "" "Sd" "<Plug>(operator-surround-delete)" {})
  (nvim.set_keymap "" "Sr" "<Plug>(operator-surround-replace)" {})

  ;; textobj
  (set nvim.g.textobj_between_no_default_key_mappings 1)
  (omap "ac" "<Plug>(textobj-between-a)")
  (omap "ic" "<Plug>(textobj-between-i)")
  (vmap "ac" "<Plug>(textobj-between-a)")
  (vmap "ic" "<Plug>(textobj-between-i)")
  (omap "ab" "<Plug>(textobj-multiblock-a)")
  (omap "ib" "<Plug>(textobj-multiblock-i)")
  (vmap "ab" "<Plug>(textobj-multiblock-a)")
  (vmap "ib" "<Plug>(textobj-multiblock-i)")

  ;; octo.nvim
  (when (and (loaded? :octo.nvim) (= (nvim.fn.executable :gh) 1))
    (let [octo (require :octo)]
      (octo.setup {})))

  ;; minimap
  (when (loaded? :nvim-minimap)
    (set nvim.g.minimap#window#height 40)
    (nnoremap-silent "<leader>m" ":<C-u>MinimapToggle<CR>"))

  ;; sexp
  (set nvim.g.sexp_enable_insert_mode_mappings 0)
  (set nvim.g.sexp_mappings {:sexp_insert_at_list_head ""
                             :sexp_insert_at_list_tail ""
                             :sexp_round_head_wrap_element ""
                             :sexp_round_tail_wrap_element ""
                             :sexp_round_head_wrap_list ""
                             :sexp_round_tail_wrap_list ""
                             :sexp_square_head_wrap_list ""
                             :sexp_square_tail_wrap_list ""
                             :sexp_curly_head_wrap_list ""
                             :sexp_curly_tail_wrap_list ""
                             :sexp_round_head_wrap_element ""
                             :sexp_round_tail_wrap_element ""
                             :sexp_square_head_wrap_element ""
                             :sexp_square_tail_wrap_element ""
                             :sexp_curly_head_wrap_element ""
                             :sexp_curly_tail_wrap_element ""
                             :sexp_insert_at_list_head ""
                             :sexp_insert_at_list_tail ""
                             :sexp_splice_list ""
                             :sexp_convolute ""
                             :sexp_raise_list ""
                             :sexp_raise_element ""})
  (set nvim.g.sexp_insert_after_wrap 0)
  (set nvim.g.sexp_filetypes "clojure,fennel,hy,lisp,scheme")
  (nmap ">(" "<Plug>(sexp_emit_head_element)")
  (nmap "<)" "<Plug>(sexp_emit_tail_element)")
  (nmap "<(" "<Plug>(sexp_capture_prev_element)")
  (nmap ">)" "<Plug>(sexp_capture_next_element)")

  ;; markdown
  (set nvim.g.mkdp_open_to_the_world 1)
  (set nvim.g.mkdp_open_ip "0.0.0.0")
  (set nvim.g.mkdp_port "8000")
  (defn mkdp-echo-url [url]
    (nvim.ex.echo (.. "'" url "'")))
  (bridge :MkdpEchoURL :mkdp-echo-url)
  (set nvim.g.mkdp_browserfunc "MkdpEchoURL")

  (augroup init-markdown
           (autocmd :FileType :markdown "setl shiftwidth=4"))

  ;; filetypes
  (augroup init-filetype-detect
           (autocmd "BufNewFile,BufRead" "*.nml" "setf fortran")
           (autocmd "BufNewFile,BufRead" "*.namelist" "setf fortran")
           (autocmd "BufNewFile,BufRead" "*.hy" "setf hy")
           (autocmd "BufNewFile,BufRead" "*.jl" "setf julia"))

  (augroup init-git-files
           (autocmd :FileType "gitcommit,gitrebase" "set bufhidden=delete"))

  ;; hy
  (set nvim.g.hy_enable_conceal 0)
  (set nvim.g.hy_conceal_fancy 0)
  (set nvim.g.conjure#client#hy#stdio#command "hy --repl-output-fn=hy.core.hy-repr.hy-repr")

  ;; json
  (augroup init-json
           (autocmd :FileType :json "setl shiftwidth=2"))

  ;; julia
  (augroup init-julia
           (autocmd :FileType :julia "setl shiftwidth=4"))

  ;; yaml
  (augroup init-yaml
           (autocmd :FileType :yaml "setl shiftwidth=2"))

  ;; fennel
  (set nvim.g.conjure#client#fennel#aniseed#aniseed_module_prefix "aniseed.")
  (defn conjure-client-fennel-stdio []
    (set nvim.g.conjure#filetype#fennel "conjure.client.fennel.stdio"))
  (nvim.ex.command_ :ConjureClientFennelStdio (->viml :conjure-client-fennel-stdio))

  (augroup init-fennel
           (autocmd :FileType :fennel "setl shiftwidth=2")
           (autocmd :FileType :fennel "setl colorcolumn=80"))

  ;; lua
  (augroup init-lua
           (autocmd :FileType :lua "setl shiftwidth=2"))


  ;; clojure
  (augroup init-clojure
           (autocmd :FileType :clojure "setl colorcolumn=80"))

  ;; go
  (augroup init-golang
           (autocmd :FileType :go "setl colorcolumn=80")
           (autocmd :FileType :go "setl noexpandtab")
           (autocmd :FileType :go "setl shiftwidth=4")
           (autocmd :FileType :go "setl tabstop=4")
           (autocmd :FileType :go "setl softtabstop=4")
           (autocmd :FileType :go "compiler go")
           (autocmd :BufWritePre "*.go" "lua vim.lsp.buf.formatting_sync(nil, 1000)"))

  ;; rust
  (augroup init-rust
           (autocmd :BufWritePre "*.rs" "lua vim.lsp.buf.formatting_sync(nil, 1000)"))

  ;; QuickFix
  (augroup init-qf
           (autocmd :FileType :qf "nnoremap <buffer> j j")
           (autocmd :FileType :qf "nnoremap <buffer> k k")
           (autocmd :FileType :qf "nnoremap <buffer> 0 0")
           (autocmd :FileType :qf "nnoremap <buffer> $ $")
           (autocmd :FileType :qf "nnoremap <buffer> gj gj")
           (autocmd :FileType :qf "nnoremap <buffer> gk gk")
           (autocmd :FileType :qf "nnoremap <buffer> g0 g0")
           (autocmd :FileType :qf "nnoremap <buffer> g$ g$")
           (autocmd :FileType :qf "nnoremap <buffer><silent>q :<C-u>q<CR>")
           (autocmd :WinEnter :* "if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'quickfix' | q | endif"))

  ;; Help
  (augroup init-help
           (autocmd :FileType :help "nnoremap <buffer> j j")
           (autocmd :FileType :help "nnoremap <buffer> k k")
           (autocmd :FileType :help "nnoremap <buffer> 0 0")
           (autocmd :FileType :help "nnoremap <buffer> $ $")
           (autocmd :FileType :help "nnoremap <buffer> gj gj")
           (autocmd :FileType :help "nnoremap <buffer> gk gk")
           (autocmd :FileType :help "nnoremap <buffer> g0 g0")
           (autocmd :FileType :help "nnoremap <buffer> g$ g$")
           (autocmd :FileType :help "nnoremap <buffer><silent>q :<C-u>q<CR>")
           (autocmd :WinEnter :* "if (winnr('$') == 1) && (getbufvar(winbufnr(0), '&buftype')) == 'help' | q | endif"))

  ;; treesitter
  (let [ts-cfg (require :nvim-treesitter.configs)]
    (ts-cfg.setup
      {:ensure_installed :maintained
       :highlight {:enable true
                   :disable []}
       :indent {:enable true
                :disable []}}))

  ;; nvim-bufferline.lua
  (when (loaded? :nvim-bufferline.lua)
    (let [bl (require :bufferline)]
      (bl.setup {:highlights {:fill
                              {:guibg colors.color2}
                              :background
                              {:guibg colors.color5}
                              :tab
                              {:guibg colors.color5}
                              :tab_selected
                              {:guibg colors.color9}
                              :tab_close
                              {:guibg colors.color2}
                              :buffer_selected
                              {:guibg colors.color9}
                              :buffer_visible
                              {:guibg colors.color5}
                              :close_button
                              {:guibg colors.color5}
                              :close_button_visible
                              {:guibg colors.color5}
                              :close_button_selected
                              {:guibg colors.color9}
                              :diagnostic
                              {:guibg colors.color5}
                              :diagnostic_visible
                              {:guibg colors.color5}
                              :diagnostic_selected
                              {:guibg colors.color9}
                              :info
                              {:guifg colors.info
                               :guibg colors.color5}
                              :info_visible
                              {:guifg colors.info
                               :guibg colors.color5}
                              :info_selected
                              {:guifg colors.info
                               :guibg colors.color9
                               :gui :bolditalic}
                              :info_diagnostic
                              {:guifg colors.info
                               :guibg colors.color5}
                              :info_diagnostic_visible
                              {:guifg colors.info
                               :guibg colors.color5}
                              :info_diagnostic_selected
                              {:guifg colors.info
                               :guibg colors.color9
                               :gui :bolditalic}
                              :warning
                              {:guifg colors.warn
                               :guibg colors.color5}
                              :warning_visible
                              {:guifg colors.warn
                               :guibg colors.color5}
                              :warning_selected
                              {:guifg colors.warn
                               :gui :bolditalic
                               :guibg colors.color9}
                              :warning_diagnostic
                              {:guifg colors.warn
                               :guibg colors.color5}
                              :warning_diagnostic_visible
                              {:guifg colors.warn
                               :guibg colors.color5}
                              :warning_diagnostic_selected
                              {:guifg colors.warn
                               :gui :bolditalic
                               :guibg colors.color9}
                              :error
                              {:guifg colors.error
                               :guibg colors.color5}
                              :error_visible
                              {:guifg colors.error
                               :guibg colors.color5}
                              :error_selected
                              {:guifg colors.error
                               :gui :bolditalic
                               :guibg colors.color9}
                              :error_diagnostic
                              {:guifg colors.error
                               :guibg colors.color5}
                              :error_diagnostic_visible
                              {:guifg colors.error
                               :guibg colors.color5}
                              :error_diagnostic_selected
                              {:guifg colors.error
                               :gui :bolditalic
                               :guibg colors.color9}
                              :duplicate
                              {:guibg colors.color5}
                              :duplicate_selected
                              {:guibg colors.color9}
                              :duplicate_visible
                              {:guibg colors.color5}
                              :modified
                              {:guibg colors.color5}
                              :modified_selected
                              {:guibg colors.color9}
                              :modified_visible
                              {:guibg colors.color5}
                              :separator
                              {:guifg colors.color5
                               :guibg colors.color5}
                              :separator_selected
                              {:guifg colors.color9
                               :guibg colors.color9}
                              :separator_visible
                              {:guifg colors.color5
                               :guibg colors.color5}
                              :indicator_selected
                              {:guifg colors.hint
                               :guibg colors.color9}
                              :pick
                              {:guibg colors.color5
                               :guifg colors.warn}
                              :pick_selected
                              {:guibg colors.color9
                               :guifg colors.error}
                              :pick_visible
                              {:guibg colors.color5
                               :guifg colors.error}}
                 :options {:numbers :none
                           :mappings false
                           :max_name_length 18
                           :max_prefix_length 15
                           :tab_size 18
                           :diagnostics :nvim_lsp
                           :diagnostics_indicator
                           (fn [count level dict ctx]
                             (if (ctx.buffer:current)
                               ""
                               (.. " " icontab.exclam-circle count)))
                           :show_tab_indicators false
                           :separator_style :thin
                           :always_show_bufferline true
                           :sort_by :extension}}))
    (nnoremap-silent ",bc" ":tabe<CR>")
    (nnoremap-silent ",bb" ":<C-u>BufferLinePick<CR>")
    (nnoremap-silent ",bo" ":<C-u>BufferLineSortByDirectory<CR>")
    (nnoremap-silent ",be" ":<C-u>BufferLineSortByExtension<CR>")
    (nnoremap-silent ",bn" ":<C-u>BufferLineCycleNext<CR>")
    (nnoremap-silent ",bp" ":<C-u>BufferLineCyclePrev<CR>")
    (nnoremap-silent ",bN" ":<C-u>BufferLineMoveNext<CR>")
    (nnoremap-silent ",bP" ":<C-u>BufferLineMovePrev<CR>")
    (nnoremap-silent :gt  ":<C-u>BufferLineCycleNext<CR>")
    (nnoremap-silent :gT  ":<C-u>BufferLineCyclePrev<CR>")
    (defn buffer-close []
      (let [bn (nvim.fn.bufnr :%)
            abn (nvim.fn.bufnr :#)]
        (if (not (= abn -1))
          (nvim.ex.silent_ :bnext)
          (nvim.ex.silent_ :enew))
        (nvim.ex.silent_ (.. "bdelete " bn))))
    (nvim.ex.command_ :BufferClose (->viml :buffer-close))
    (nnoremap-silent ",bd" ":<C-u>BufferClose<CR>"))

  ;; toggleterm
  (when (loaded? :nvim-toggleterm.lua)
    (let [tt (require :toggleterm)]
      (tt.setup {}))
    (nnoremap-silent :<leader>w ":<C-u>ToggleTerm<CR>"))

  ;; lualine
  (let [ll (require :lualine)
        filename {1 :filename
                  :file_status true
                  :symbols
                  {:modified (.. " " icontab.plus)
                   :readonly (.. " " icontab.lock)}}
        mode {1 :mode
              :format (fn [mode-name]
                        (let [i icontab
                              dict {:n i.meteor
                                    :i i.zap
                                    :v i.cursor-text
                                    "" i.cursor
                                    :V i.cursor
                                    :c i.chevron-r
                                    :no i.meteor
                                    :s i.cursor-text
                                    :S i.cursor-text
                                    "" i.cursor-text
                                    :ic i.lightning
                                    :R i.arrow-r
                                    :Rv i.arrow-r
                                    :cv i.hashtag
                                    :ce i.hashtag
                                    :r i.chevron-r
                                    :rm i.chevron-r
                                    "r?" i.chevron-r
                                    "!" i.chevron-r
                                    :t i.chevron-r}]
                          (or (. dict (vim.fn.mode))
                              mode-name)))}
        paste-fn (fn []
                   (if vim.o.paste
                     icontab.paste
                     ""))
        spell-fn (fn []
                   (if vim.wo.spell
                     (.. icontab.spellcheck vim.o.spelllang)
                     ""))
        lsp-status-fn (fn []
                        (match (when (loaded? :lsp-status.nvim)
                                 (let [lsp-status (require :lsp-status)]
                                   (lsp-status.status)))
                          status status
                          _ ""))
        dap-status-fn (fn []
                        (match (when (loaded? :nvim-dap)
                                 (let [dap (require :dap)]
                                   (dap.status)))
                          "" " "
                          status (.. icontab.play-circle" " status)
                          _ ""))
        lineinfo-fn (fn []
                      (let [row (nvim.fn.line ".")
                            col (nvim.fn.col ".")]
                        (.. icontab.ln row " " icontab.cn col)))]
    (ll.setup {:options
               {:theme :ayu_dark
                :section_separators [icontab.round-l
                                     icontab.round-r]
                :component_separators ["|" "|"]
                :icons_enabled true}
               :sections
               {:lualine_a [mode
                            paste-fn
                            spell-fn]
                :lualine_b [filename
                            {1 :branch
                             :icon icontab.github}
                            lsp-status-fn]
                :lualine_c []
                :lualine_x [dap-status-fn]
                :lualine_y [:fileformat
                            :encoding
                            :filetype]
                :lualine_z [lineinfo-fn]}
               :inactive_sections
               {:lualine_a []
                :lualine_b []
                :lualine_c [filename]
                :lualine_x [:filetype]
                :lualine_y []
                :lualine_z []}
               :extensions
               [:quickfix
                {:sections {:lualine_a
                            [(fn []
                               (.. icontab.alarm-light " Trouble"))]
                            :lualine_b
                            [(fn [] 
                               (let [tc (require :trouble.config)
                                     mode tc.options.mode]
                                 (match mode
                                   :quickfix
                                   (let [title (core.get
                                                 (vim.fn.getqflist {:title 1})
                                                 :title)]
                                     (if (> (string.len title) 0)
                                       (.. mode " | " title)
                                       mode))
                                   :loclist
                                   (let [title (core.get
                                                 (vim.fn.getloclist
                                                   (vim.fn.winnr)
                                                   {:title 1})
                                                 :title)]
                                     (if (> (string.len title) 0)
                                       (.. mode " | " title)
                                       mode))
                                   _ mode)))]}
                 :filetypes [:Trouble]}
                {:sections {:lualine_a
                            [(fn []
                               (.. icontab.chevron-r " REPL"))]}
                 :filetypes [:dap-repl]}
                {:sections {:lualine_a
                            [(fn []
                               (.. icontab.glasses " Watches"))]}
                 :filetypes [:dapui_watches]}
                {:sections {:lualine_a
                            [(fn []
                               (.. icontab.stackoverflow " Stacks"))]}
                 :filetypes [:dapui_stacks]}
                {:sections {:lualine_a
                            [(fn []
                               (.. icontab.tags " Breakpoints"))]}
                 :filetypes [:dapui_breakpoints]}
                {:sections {:lualine_a
                            [(fn []
                               (.. icontab.scope " Scopes"))]}
                 :filetypes [:dapui_scopes]}
                {:sections {:lualine_a
                            [(fn []
                               (.. icontab.terminal
                                   " Term "
                                   nvim.b.toggle_number))]}
                 :filetypes [:toggleterm]}
                {:sections {:lualine_a
                            [(fn []
                               (.. icontab.package-alt " Packer"))]}
                 :filetypes [:packer]}
                {:sections {:lualine_a
                            [(fn []
                               (.. icontab.tree " NvimTree"))]}
                 :filetypes [:NvimTree]}
                {:sections {:lualine_a
                            [(fn []
                               (.. icontab.hierarchy " Outline"))]}
                 :filetypes [:Outline]}]})))
