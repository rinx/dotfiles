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
  :romgrk/doom-one.vim {}
  :kyazdani42/nvim-web-devicons {}
  :hoob3rt/lualine.nvim {}
  :romgrk/barbar.nvim {}
  :tyru/eskk.vim {:event [:InsertEnter]}
  :dense-analysis/ale {}
  :neovim/nvim-lspconfig {}
  :hrsh7th/vim-vsnip {}
  :hrsh7th/vim-vsnip-integ {}
  :hrsh7th/nvim-compe {}
  :onsails/lspkind-nvim {}
  :nvim-lua/lsp-status.nvim {}
  :RishabhRD/nvim-lsputils {:requires
                            [:RishabhRD/popfix]}
  :kosayoda/nvim-lightbulb {}
  :cohama/lexima.vim {}
  :rafamadriz/friendly-snippets {}
  :kyazdani42/nvim-tree.lua {}
  :junegunn/fzf {}
  :junegunn/fzf.vim {:cmd [:Buffers
                           :Files
                           :GFiles
                           :BLines
                           :History
                           :Helptags
                           :Filetypes
                           :Rg]}
  :stsewd/fzf-checkout.vim {:cmd [:GBranches
                                  :GTags]}
  :lewis6991/gitsigns.nvim {}
  :haya14busa/vim-asterisk {}
  :haya14busa/incsearch.vim {}
  :rhysd/clever-f.vim {}
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
  :rinx/nvim-minimap {}
  :guns/vim-sexp {:ft [:clojure
                       :fennel
                       :hy
                       :lisp
                       :scheme]}
  :mileszs/ack.vim {:cmd [:Ack]}
  :hylang/vim-hy {:ft :hy}
  :Olical/conjure {:ft [:clojure
                        :fennel
                        :hy]
                   :event ["BufNewFile,BufRead *.clj"
                           "BufNewFile,BufRead *.fnl"]}
  :tami5/compe-conjure {:ft [:clojure
                             :fennel]
                        :event ["InsertEnter *.clj"
                                "InsertEnter *.fnl"]}
  :iamcco/markdown-preview.nvim {:run "cd app && yarn install"
                                 :ft :markdown
                                 :cmd "MarkdownPreview"}
  :nvim-treesitter/nvim-treesitter {:run ":TSUpdate"}
  :romgrk/nvim-treesitter-context {})

(when (and (loaded? :nvim-web-devicons)
           (loaded? :nvim-treesitter))
  (def icon (require :util.icon))
  (def ts-cfg (require :nvim-treesitter.configs))
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
  (set nvim.o.completeopt "menuone,noselect")

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

  (set nvim.o.foldmethod "marker")

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
  (set nvim.o.listchars "eol:¬,tab:▸ ,extends:>,precedes:<,trail:-")

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

  (nvim.ex.silent_ "colorscheme doom-one")
  (nvim.ex.set "background=dark")
  (nvim.ex.syntax :enable)

  (nvim.ex.highlight "Normal ctermbg=none guibg=none")

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

  (nnoremap "s" "<Nop>")
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

  (nnoremap "ZZ" "<Nop>")
  (nnoremap "ZQ" "<Nop>")
  (nnoremap "Q" "<Nop>")

  ;; grep
  (if (= (nvim.fn.executable "rg") 1)
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

  ;; ale.vim
  (set nvim.g.ale_lint_on_save 1)
  (set nvim.g.ale_lint_on_enter 1)
  (set nvim.g.ale_lint_on_text_changed :never)
  (set nvim.g.ale_lint_on_filetype_changed 1)
  (set nvim.g.ale_fix_on_save 1)
  (set nvim.g.ale_linters {:clojure [:clj-kondo]})
  (set nvim.g.ale_fixers {"*" [:remove_trailing_lines :trim_whitespace]
                          :go [:goimports]
                          :rust [:rustfmt]})
  (set nvim.g.ale_set_quickfix 0)
  (set nvim.g.ale_set_loclist 1)
  (set nvim.g.ale_open_list 1)
  (set nvim.g.ale_sign_column_always 1)
  (set nvim.g.ale_warn_about_trailing_blank_lines 1)
  (set nvim.g.ale_warn_about_trailing_whitespace 1)

  ;; neovim LSP
  (let [lsp (require :lspconfig)
        configs (require :lspconfig/configs)
        util (require :lspconfig/util)
        lsp-kind (require :lspkind)
        lsp-status (require :lsp-status)
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
    (lsp-status.config {:status_symbol ""
                        :current_function false})
    (when (not lsp.hyls)
      (tset configs :hyls
            {:default_config
             {:cmd [:hyls]
              :filetypes [:hy]
              :root_dir (util.root_pattern ".git")}}))
    (when (not lsp.unifiedls-md)
      (tset configs :unifiedls-md
            {:default_config
             {:cmd [:unified-language-server
                    "--parser=remark-parse"
                    "--stdio"]
              :filetypes [:markdown]
              :root_dir (util.root_pattern ".git")}}))
    (lsp.bashls.setup {:on_attach lsp-status.on_attach
                       :capabilities capabilities})
    (lsp.clojure_lsp.setup {:on_attach lsp-status.on_attach
                            :capabilities capabilities})
    (lsp.dockerls.setup {:on_attach lsp-status.on_attach
                         :capabilities capabilities})
    (lsp.fortls.setup {:on_attach lsp-status.on_attach
                       :capabilities capabilities})
    (lsp.gopls.setup {:on_attach lsp-status.on_attach
                      :capabilities capabilities
                      :settings {:usePlaceholders true
                                 :analyses {:fieldalignment true
                                            :fillstruct true
                                            :nilless true
                                            :shadow true
                                            :unusedwrite true}}})
    (lsp.hls.setup {:on_attach lsp-status.on_attach
                    :capabilities capabilities})
    (lsp.hyls.setup {:on_attach lsp-status.on_attach
                     :capabilities capabilities})
    (lsp.jsonls.setup {:on_attach lsp-status.on_attach
                       :capabilities capabilities})
    (lsp.kotlin_language_server.setup {:on_attach lsp-status.on_attach
                                       :capabilities capabilities})
    (lsp.rust_analyzer.setup {:on_attach lsp-status.on_attach
                              :capabilities capabilities
                              :settings {:rust-analyzer
                                         {:cargo {:allFeatures true}
                                          :lens {:enable true
                                                 :methodReferences true
                                                 :references true}}}})
    (lsp.tsserver.setup {:on_attach lsp-status.on_attach
                         :capabilities capabilities})
    (lsp.unifiedls-md.setup {:on_attach lsp-status.on_attach
                             :capabilities capabilities})
    (lsp.yamlls.setup {:on_attach lsp-status.on_attach
                       :capabilities capabilities
                       :settings {:yaml
                                  {:schemaStore {:enable true}}}})
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
                           :conjure {:kind icontab.lua
                                     :filetypes [:fennel]}
                           :emoji {:kind icontab.heart
                                   :filetypes [:markdown]}
                           :nvim_lsp {:kind icontab.cube}
                           :nvim_lua {:kind icontab.vim}
                           :omni false
                           :path {:kind icontab.dots}
                           :spell {:kind icontab.pencil}
                           :tag {:kind icontab.tag}
                           :treesitter {:kind icontab.leaf}
                           :vsnip {:kind icontab.quote-l}}}))

  (nnoremap-silent "K" ":<C-u>lua vim.lsp.buf.hover()<CR>")
  (nnoremap-silent "gd" ":<C-u>lua vim.lsp.buf.definition()<CR>")
  (nnoremap-silent "gD" ":<C-u>lua vim.lsp.buf.declaration()<CR>")
  (nnoremap-silent "gi" ":<C-u>lua vim.lsp.buf.implementation()<CR>")
  (nnoremap-silent "gr" ":<C-u>lua vim.lsp.buf.references()<CR>")

  (nnoremap-silent "<leader>rn" (.. ":<C-u>" (->viml :rename-by-popfix) "<CR>"))
  (nnoremap-silent "<leader>f" ":<C-u>lua vim.lsp.buf.formatting()<CR>")
  (xnoremap-silent "<leader>f" ":<C-u>lua vim.lsp.buf.range_formatting()<CR>")
  (nnoremap-silent "<Leader>a" ":<C-u>lua vim.lsp.buf.code_action()<CR>")
  (xnoremap-silent "<Leader>a" ":<C-u>lua vim.lsp.buf.range_code_action()<CR>")

  (nnoremap-silent "[d" ":<C-u>lua vim.lsp.diagnostic.goto_prev()<CR>")
  (nnoremap-silent "]d" ":<C-u>lua vim.lsp.diagnostic.goto_next()<CR>")
  (nnoremap-silent "<Leader>d" ":<C-u>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")

  (set nvim.g.diagnostic_enable_virtual_text 1)
  (set nvim.g.diagnostic_trimmed_virtual_text 40)
  (set nvim.g.diagnostic_show_sign 1)
  (set nvim.g.diagnostic_insert_delay 1)

  (nvim.fn.sign_define :LspDiagnosticsSignError
                       {:text icontab.close-octagon
                        :texthl :LspDiagnosticsSignError})
  (nvim.fn.sign_define :LspDiagnosticsSignWarning
                       {:text icontab.exclam-octagon
                        :texthl :LspDiagnosticsSignWarning})
  (nvim.fn.sign_define :LspDiagnosticsSignInformation
                       {:text icontab.info-circle
                        :texthl :LspDiagnosticsSignInformation})
  (nvim.fn.sign_define :LspDiagnosticsSignHint
                       {:text icontab.comment
                        :texthl :LspDiagnosticsSignHint})

  ;; rename by popfix
  (defn rename-by-popfix []
    (let [popfix (require :popfix)
          callback (fn [index line]
                     (vim.lsp.buf.rename line))
          opts {:mode :cursor
                :close_on_bufleave true
                :prompt {:prompt_text :Rename
                         :init_text (vim.fn.expand "<cword>")
                         :border true
                         :border_chars icon.popfix-border-chars-alt}
                :keymaps {:i {"<CR>" (fn [popup]
                                       (popup:close callback))}
                          :n {"<CR>" (fn [popup]
                                       (popup:close callback))
                              "<Esc>" (fn [popup]
                                        (popup:close))}}}]
      (popfix:new opts)))

  ;; throw lsp diagnostics into quickfix
  (let [default (. vim.lsp.handlers :textDocument/publishDiagnostics)
        handler (fn [err method result client-id bufnr config]
                  (default err method result client-id bufnr config)
                  (let [diagnostics (vim.lsp.diagnostic.get_all)
                        qflist []]
                    (each [bufnr diagnostic (pairs diagnostics)]
                      (each [i d (ipairs diagnostic)]
                        (set d.bufnr bufnr)
                        (set d.lnum (core.inc d.range.start.line))
                        (set d.col (core.inc d.range.start.character))
                        (set d.text d.message)
                        (table.insert qflist d)))
                    (vim.lsp.util.set_qflist qflist)))]
    (tset vim.lsp.handlers :textDocument/publishDiagnostics handler))

  ;; lsputils
  (when (loaded? :nvim-lsputils)
    (let [code-action (require :lsputil.codeAction)
          override (fn [key handler]
                     (tset vim.lsp.handlers key handler))]
      (override :textDocument/codeAction code-action.code_action_handler)))

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
             (autocmd "CursorHold,CursorHoldI" "*" (->viml lightbulb-update)))
    (nvim.fn.sign_define :LightBulbSign
                         {:text icontab.lightbulb-alt
                          :texthl :LspDiagnosticsSignHint}))

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

  (nnoremap-silent "<leader>t" ":<C-u>NvimTreeToggle<CR>")

  ;; fzf.vim
  (nnoremap-silent ",ub"  ":<C-u>Buffers<CR>")
  (nnoremap-silent ",uf"  ":<C-u>Files<CR>")
  (nnoremap-silent ",ugf" ":<C-u>GFiles<CR>")
  (nnoremap-silent ",u/"  ":<C-u>BLines<CR>")
  (nnoremap-silent ",ur"  ":<C-u>History<CR>")
  (nnoremap-silent ",uc"  ":<C-u>History:<CR>")
  (nnoremap-silent ",us"  ":<C-u>History/<CR>")
  (nnoremap-silent ",uh"  ":<C-u>Helptags<CR>")
  (nnoremap-silent ",ut"  ":<C-u>Filetypes<CR>")
  (nnoremap-silent ",ug"  ":<C-u>Rg<CR>")
  (nnoremap-silent ",ugb" ":<C-u>GBranches<CR>")
  (nnoremap-silent ",ugt" ":<C-u>GTags<CR>")

  (augroup init-fzf
           (autocmd :FileType :fzf "nnoremap <buffer><silent>q :<C-u>q<CR>"))

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
               :watch_index {:interval 1000}
               :current_line_blame false
               :sign_priority 6
               :update_debounce 100
               :status_formatter nil
               :use_decoration_api true
               :use_internal_diff true}))

  ;; asterisk
  (nvim.set_keymap "" "*" "<Plug>(asterisk-*)" {})
  (nvim.set_keymap "" "#" "<Plug>(asterisk-#)" {})
  (nvim.set_keymap "" "g*" "<Plug>(asterisk-g*)" {})
  (nvim.set_keymap "" "g#" "<Plug>(asterisk-g#)" {})
  (nvim.set_keymap "" "z*" "<Plug>(asterisk-z*)" {})
  (nvim.set_keymap "" "gz*" "<Plug>(asterisk-gz*)" {})
  (nvim.set_keymap "" "z#" "<Plug>(asterisk-z#)" {})
  (nvim.set_keymap "" "gz#" "<Plug>(asterisk-gz#)" {})

  ;; incsearch
  (nvim.set_keymap "" "<buffer>/" "<Plug>(incsearch-forward)" {})
  (nvim.set_keymap "" "<buffer>?" "<Plug>(incsearch-backward)" {})
  (nvim.set_keymap "" "<buffer>g/" "<Plug>(incsearch-stay)" {})

  ;; clever-f
  (set nvim.g.clever_f_not_overwrites_standard_mappings 1)
  (set nvim.g.clever_f_across_no_line 0)
  (set nvim.g.clever_f_ignore_case 0)
  (set nvim.g.clever_f_smart_case 0)
  (set nvim.g.clever_f_use_migemo 0)
  (set nvim.g.clever_f_fix_key_direction 0)
  (set nvim.g.clever_f_show_prompt 0)
  (set nvim.g.clever_f_chars_match_any_signs "")
  (set nvim.g.clever_f_mark_cursor 1)
  (set nvim.g.clever_f_mark_cursor_color "Cursor")
  (set nvim.g.clever_f_hide_cursor_on_cmdline 1)
  (set nvim.g.clever_f_timeout_ms 0)
  (set nvim.g.clever_f_mark_char 1)
  (set nvim.g.clever_f_mark_char_color "CleverFDefaultLabel")
  (set nvim.g.clever_f_repeat_last_char_inputs ["\r"])
  (nmap "f" "<Plug>(clever-f-f)")
  (nmap "F" "<Plug>(clever-f-F)")
  (nmap "t" "<Plug>(clever-f-t)")
  (nmap "T" "<Plug>(clever-f-T)")
  (nmap "<Space>" "<Plug>(clever-f-reset)")

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

  ;; minimap
  (when (loaded? :nvim-minimap)
    (set nvim.g.minimap#window#height 40)
    (nnoremap-silent "<leader>m" ":<C-u>MinimapToggle<CR>")
    (augroup init-minimap
             (autocmd :VimEnter "*" :MinimapOpen)))

  ;; sexp
  (set nvim.g.sexp_enable_insert_mode_mappings 0)
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
           (autocmd :FileType :markdown "setlocal shiftwidth=4"))

  ;; filetypes
  (augroup init-filetype-detect
           (autocmd "BufNewFile,BufRead" "*.nml" "setf fortran")
           (autocmd "BufNewFile,BufRead" "*.namelist" "setf fortran")
           (autocmd "BufNewFile,BufRead" "*.hy" "setf hy"))

  ;; hy
  (set nvim.g.hy_enable_conceal 0)
  (set nvim.g.hy_conceal_fancy 0)

  ;; json
  (augroup init-json
           (autocmd :FileType :json "setlocal shiftwidth=2"))

  ;; yaml
  (augroup init-yaml
           (autocmd :FileType :yaml "setlocal shiftwidth=2"))

  ;; fennel
  (set nvim.g.conjure#client#fennel#aniseed#aniseed_module_prefix "aniseed.")
  (defn conjure-client-fennel-stdio []
    (set nvim.g.conjure#filetype#fennel "conjure.client.fennel.stdio"))
  (nvim.ex.command_ :ConjureClientFennelStdio (->viml :conjure-client-fennel-stdio))

  (augroup init-fennel
           (autocmd :FileType :fennel "setlocal shiftwidth=2")
           (autocmd :FileType :fennel "set colorcolumn=80"))

  ;; clojure
  (augroup init-clojure
           (autocmd :FileType :clojure "set colorcolumn=80"))

  ;; go
  (augroup init-golang
           (autocmd :FileType :go "set colorcolumn=80")
           (autocmd :FileType :go "set noexpandtab")
           (autocmd :FileType :go "set shiftwidth=4")
           (autocmd :FileType :go "set tabstop=4")
           (autocmd :FileType :go "set softtabstop=4")
           (autocmd :FileType :go "compiler go"))


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
  (ts-cfg.setup
    {:ensure_installed :maintained
     :highlight {:enable true
                 :disable []}
     :indent {:enable true
              :disable []}})

  ;; barbar.nvim
  (nnoremap-silent ",bc" ":tabe<CR>")
  (nnoremap-silent ",bd" ":BufferClose<CR>")
  (nnoremap-silent ",bb" ":BufferPick<CR>")
  (nnoremap-silent ",bo" ":BufferOrderByDirectory<CR>")
  (nnoremap-silent ",bl" ":BufferOrderByLanguage<CR>")
  (nnoremap-silent ",bn" ":BufferNext<CR>")
  (nnoremap-silent ",bp" ":BufferPrevious<CR>")
  (nnoremap-silent ",bN" ":BufferMoveNext<CR>")
  (nnoremap-silent ",bP" ":BufferMovePrevious<CR>")
  (nnoremap-silent "gt"  ":BufferNext<CR>")
  (nnoremap-silent "gT"  ":BufferPrevious<CR>")

  (set nvim.g.bufferline {:maximum_padding 6})

  ;; lualine
  (let [ll (require :lualine)
        filename {1 :filename
                  :file_status true
                  :symbols
                  {:modified (.. " " icontab.plus)
                   :readonly (.. " " icontab.lock)}}
        paste-fn (fn []
                   (if vim.o.paste
                     icontab.paste
                     ""))
        spell-fn (fn []
                   (if vim.wo.spell
                     (.. icontab.spellcheck vim.o.spelllang)
                     ""))
        lsp-status-fn (fn []
                        (let [status (when (loaded? :lsp-status.nvim)
                                       (let [lsp-status (require :lsp-status)]
                                         (lsp-status.status)))]
                          (if status
                            status
                            "")))
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
               {:lualine_a [{1 :mode
                             :format (fn [mode-name]
                                       (let [i icontab
                                             dict {:n i.minus-square
                                                   :i i.info
                                                   :v i.cursor-text
                                                   "" i.cursor
                                                   :V i.cursor
                                                   :c i.chevron-r
                                                   :no i.minus-square
                                                   :s i.cursor-text
                                                   :S i.cursor-text
                                                   "" i.cursor-text
                                                   :ic i.info
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
                            paste-fn
                            spell-fn]
                :lualine_b [filename
                            {1 :branch
                             :icon icontab.github}
                            lsp-status-fn]
                :lualine_c []
                :lualine_x [{1 :diagnostics
                             :sources [:ale]}]
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
               []})))
